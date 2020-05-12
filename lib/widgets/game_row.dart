import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';
import 'package:rounded_paint_scratch_fe/views/score_game.dart';

class GameRow extends StatelessWidget {
  final Map game;
  final int index;
  final String inning;
  final Function removeGame;

  GameRow({this.game, this.index, this.inning, this.removeGame});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (game['finalized'] == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ChangeNotifierProvider<BaseGameInfo>(
                create: (context) => BaseGameInfo(
                  initialState: game,
                ),
                child: ScoreGame(),
              ),
            ),
          );
        }
      },
      child: Dismissible(
        key: ObjectKey(game),
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
            padding: EdgeInsets.only(top: 25, left: 20, right: 25),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          game['awayTeam'],
                          style: TextStyle(
                            color: AppColors.backgroundGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          game['awayRuns'].toString(),
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
                        flex: 3,
                        child: Text(
                          game['homeTeam'],
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
                              game['homeRuns'].toString(),
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                inning,
                                style: TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 12,
                                ),
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
