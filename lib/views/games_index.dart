import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/widgets/game_row.dart';
import 'package:rounded_paint_scratch_fe/widgets/nav_bar.dart';

class GamesIndex extends StatefulWidget {
  @override
  _GamesIndexState createState() => _GamesIndexState();
}

class _GamesIndexState extends State<GamesIndex> {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  List<dynamic> _games;

  Future<Null> clearGames() async {
    final p = await prefs;
    p.setString('allGames', null);
  }

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

  String buildInning(Map game) {
    String prefix = game['topInning'] ? 'Top' : 'Bottom';
    String inning = game['inning'].toString();
    return '$prefix $inning';
  }

  ListView buildGames(BuildContext context) {
    if (_games.isEmpty) {
      return ListView(children: [
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
      ]);
    } else {
      return ListView.builder(
        itemCount: _games.length,
        itemBuilder: (BuildContext context, int index) {
          return GameRow(
            // TODO: Can this be refactored to just send the singular game in?
            games: _games,
            index: index,
            inning: buildInning(_games[index]),
          );
        },
      );
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
          children: [
            Expanded(
              child: Container(
                child: buildGames(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
