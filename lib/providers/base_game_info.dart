import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Direction { up, down }

class BaseGameInfo with ChangeNotifier {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  Map initialState;
  List<Map> _history;
  int _historyIndex = 0;
  Map<String, dynamic> _baseState = {
    'createdAt': null,
    'updatedAt': null,
    'gameUuid': '',
    'numberOfInnings': 5,
    'outsPerInning': 3,
    'foulsStrikesPerOut': 4,
    'ballsPerWalk': 4,
    'foulsPerOut': 4,
    'strikesPerOut': 3,
    'combineFoulsStrikes': true,
    'awayTeam': 'Away Team',
    'homeTeam': 'Home Team',
    'balls': 0,
    'strikes': 0,
    'fouls': 0,
    'outs': 0,
    'inning': 1,
    'topInning': true,
    'awayRuns': 0,
    'homeRuns': 0,
    'finalized': false,
  };

  BaseGameInfo({this.initialState}) {
    Map base = initialState ?? _baseState;
    _history = [base];
  }

  Map get state => hasState ? _history[_historyIndex] : _baseState;

  bool get hasState => _history.isNotEmpty;

  void undo() {
    if (_historyIndex > 0) {
      _historyIndex--;
      notifyListeners();
    }
  }

  void redo() {
    int stateLength = _history.length - 1;
    if (_historyIndex < stateLength) {
      _historyIndex++;
      notifyListeners();
    }
  }

  void changeTag(String tag, Direction direction) {
    switch (direction) {
      case Direction.up:
        {
          _baseState[tag]++;
          notifyListeners();
        }
        break;
      case Direction.down:
        {
          if (_baseState[tag] > 1) {
            _baseState[tag]--;
            notifyListeners();
          }
        }
        break;
    }
  }

  void inPlay() {
    _resetCount();
  }

  void out() {
    _resetCount(incrementOut: true);
  }

  void ball() {
    int newBalls = state['balls'] + 1;
    newBalls >= state['ballsPerWalk']
        ? _resetCount()
        : _increaseStat(Map.from(state), newBalls, 'balls');
  }

  void strikeOrFoul(String tag) {
    int newStat = state[tag] + 1;
    if (state['combineFoulsStrikes']) {
      String otherTag = tag == 'fouls' ? 'strikes' : 'fouls';
      int foulsStrikes = state[otherTag] + newStat;
      foulsStrikes >= state['foulsStrikesPerOut']
          ? _resetCount(incrementOut: true)
          : _increaseStat(Map.from(state), newStat, tag);
    } else {
      newStat >= state['${tag}PerOut']
          ? _resetCount(incrementOut: true)
          : _increaseStat(Map.from(state), newStat, tag);
    }
  }

  void _increaseStat(Map newState, statNumber, statId) {
    newState[statId] = statNumber;
    updateState(newState);
  }

  void _resetCount({bool incrementOut = false, Map incomingState = null}) {
    Map newState = incomingState ?? Map.from(state);
    newState['balls'] = 0;
    newState['strikes'] = 0;
    newState['fouls'] = 0;
    if (incrementOut == true) {
      int newOuts = state['outs'] + 1;
      newOuts >= state['outsPerInning']
          ? _incrementInning(newState)
          : newState['outs'] = newOuts;
    }
    updateState(newState);
  }

  Map _incrementInning(state) {
    bool newTopInning = !state['topInning'];
    if (state['topInning'] == false) {
      int newInning = state['inning'] + 1;
      state['inning'] = newInning;
    }
    state['topInning'] = newTopInning;
    state['outs'] = 0;
    _resetCount();
    return state;
  }

  void updateState(Map state) {
    if (_historyIndex != (_history.length - 1)) {
      _history = _history.sublist(0, (_historyIndex + 1));
    }
    _history.add(state);
    _historyIndex++;
    _updateGameData();
    notifyListeners();
  }

  Future<Null> _updateGameData() async {
    final p = await prefs;
    var gamesJson = p.getString('allGames');
    List allGames = jsonDecode(gamesJson);
    int gameIndex = allGames
        .indexWhere((element) => element['gameUuid'] == state['gameUuid']);
    allGames.removeAt(gameIndex);
    allGames.add(state);
    p.setString('allGames', jsonEncode(allGames));
  }

  void toggleFoulsStrikes(bool value) {
    _baseState['combineFoulsStrikes'] = value;
    notifyListeners();
  }

  void updateTeam(String teamName, String tag) {
    String name = teamName.trim() == ''
        ? tag == 'awayTeam' ? 'Away Team' : 'Home Team'
        : teamName;
    updateTag(name, tag);
  }

  void updateTag(dynamic value, String tag) {
    _baseState[tag] = value;
  }

  void run() {
    Map newState = Map.from(state);
    String tag = state['topInning'] ? 'awayRuns' : 'homeRuns';
    int newRuns = state[tag] + 1;
    newState[tag] = newRuns;
    _resetCount(incomingState: newState);
  }
}
