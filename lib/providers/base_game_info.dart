import 'package:flutter/material.dart';

enum Direction { up, down }

class BaseGameInfo with ChangeNotifier {
  Map initialState;
  List<Map> _history;
  int _historyIndex = 0;
  Map<String, dynamic> _baseState = {
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
  };

  BaseGameInfo({this.initialState}) {
    Map base = initialState ?? _baseState;
    _history = [base];
  }

  Map get state => _baseState;

  bool get hasState => _history.isNotEmpty;

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

  void toggleFoulsStrikes(bool value) {
    _baseState['combineFoulsStrikes'] = value;
    notifyListeners();
  }

  void updateTeam(String teamName, String tag) {
    String name = teamName.trim() == ''
        ? tag == 'awayTeam' ? 'Away Team' : 'Home Team'
        : teamName;
    _baseState[tag] = name;
  }
}
