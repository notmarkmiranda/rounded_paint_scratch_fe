import 'package:flutter/material.dart';

enum Direction { up, down }

class BaseGameInfo with ChangeNotifier {
  String awayTeam;
  String homeTeam;

  Map<String, dynamic> _baseState = {
    'numberOfInnings': 5,
    'outsPerInning': 3,
    'foulsStrikesPerOut': 4,
    'ballsPerWalk': 4,
    'foulsPerOut': 4,
    'combineFoulsStrikes': true,
  };

  Map get state => _baseState;

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
}
