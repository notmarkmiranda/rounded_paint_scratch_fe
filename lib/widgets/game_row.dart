import 'package:flutter/material.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';

class GameRow extends StatelessWidget {
  final List games;
  final int index;
  final String inning;

  GameRow({this.games, this.index, this.inning});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(games[index]),
      onDismissed: (direction) {
        var game = games.elementAt(index);
        // TODO: Remove item from games?
        // do we need to do this^?
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
    );
  }
}
