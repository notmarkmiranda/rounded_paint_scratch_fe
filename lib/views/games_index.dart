import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/widgets/nav_bar.dart';

class GamesIndex extends StatefulWidget {
  @override
  _GamesIndexState createState() => _GamesIndexState();
}

class _GamesIndexState extends State<GamesIndex> {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  List<Map> _games;

  Future<Null> getString(String key) async {
    final p = await prefs;
    String gamesJson = p.getString(key);
    setState(() {
      _games = gamesJson != null ? jsonDecode(gamesJson) : [];
    });
  }

  @override
  void initState() {
    super.initState();
    _games = [];
    getString('allGames');
  }

  List<Widget> buildGames() {
    if (_games.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "There are no games just yet.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: NavBar(
        title: 'SCORES',
        section: 'index',
      ),
      body: Container(
        margin: EdgeInsets.only(top: 25),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buildGames(),
        ),
      ),
    );
  }
}
