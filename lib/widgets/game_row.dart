import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';
import 'package:rounded_paint_scratch_fe/views/score_game.dart';

class GameRow extends StatelessWidget {
  final List games;
  final int index;
  final String inning;
  final Function removeGame;

  GameRow({this.games, this.index, this.inning, this.removeGame});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (games[index]['finalized'] == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ChangeNotifierProvider<BaseGameInfo>(
                create: (context) => BaseGameInfo(
                  initialState: games[index],
                ),
                child: ScoreGame(),
              ),
            ),
          );
        }
      },
      child: Dismissible(
        key: ObjectKey(games[index]),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          removeGame(index);
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          games[index]['awayTeam'],
                          style: TextStyle(
                            color: AppColors.backgroundGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          games[index]['awayRuns'].toString(),
                          style: TextStyle(
                            color: AppColors.backgroundGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          games[index]['homeTeam'],
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Text(
                              games[index]['homeRuns'].toString(),
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                inning,
                                style: TextStyle(color: AppColors.primaryBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
