import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';
import 'package:rounded_paint_scratch_fe/widgets/count_stat.dart';
import 'package:rounded_paint_scratch_fe/widgets/custom_raised_button.dart';
import 'package:rounded_paint_scratch_fe/widgets/nav_bar.dart';

class ScoreGame extends StatelessWidget {
  String _inningNumber(Map state) {
    String topOrBottom = state['topInning'] ? 'TOP' : 'BOTTOM';
    String inningNumber = state['inning'].toString();
    return "$topOrBottom $inningNumber";
  }

  @override
  Widget build(BuildContext context) {
    final baseGameInfo = Provider.of<BaseGameInfo>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: NavBar(
          title: 'GAME',
          section: 'scoreGame',
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 65,
                child: DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'NAVIGATE',
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: AppColors.primaryBlue,
                        thickness: 3,
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.bubble_chart),
                title: Text('ALL SCORES'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.loupe),
                title: Text('NEW GAME'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          baseGameInfo.state['awayTeam'],
                          style: TextStyle(
                            color: AppColors.secondaryBlue,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: AppColors.backgroundGrey,
                            width: 1.0,
                          ),
                          right: BorderSide(
                            color: AppColors.backgroundGrey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        baseGameInfo.state['awayRuns'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryBlue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: AppColors.backgroundGrey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        baseGameInfo.state['homeRuns'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          baseGameInfo.state['homeTeam'],
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            _inningNumber(baseGameInfo.state),
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.secondaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CountStat(
                          stat: 'B',
                          number: baseGameInfo.state['balls'],
                        ),
                        CountStat(
                          stat: 'S',
                          number: baseGameInfo.state['strikes'],
                        ),
                        CountStat(
                          stat: 'F',
                          number: baseGameInfo.state['fouls'],
                        ),
                        CountStat(
                          stat: '0',
                          number: baseGameInfo.state['outs'],
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: CustomRaisedButton(
                              buttonText: 'EDIT COUNT',
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CustomRaisedButton(
                              buttonText: 'EDIT SCORE',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            child: MaterialButton(
                              padding: EdgeInsets.all(0),
                              splashColor: AppColors.primaryBlue,
                              shape: CircleBorder(),
                              child: Icon(Icons.undo),
                              color: AppColors.backgroundGrey,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            child: MaterialButton(
                              padding: EdgeInsets.all(0),
                              splashColor: AppColors.primaryBlue,
                              shape: CircleBorder(),
                              child: Icon(Icons.redo),
                              color: AppColors.backgroundGrey,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 20,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CustomRaisedButton(
                          buttonText: 'IN PLAY',
                          color: AppColors.secondaryBlue,
                          splashColor: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomRaisedButton(
                          buttonText: 'RUN',
                          color: AppColors.secondaryBlue,
                          splashColor: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomRaisedButton(
                          buttonText: 'OUT',
                          color: AppColors.secondaryBlue,
                          splashColor: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CustomRaisedButton(
                          buttonText: 'BALL',
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomRaisedButton(
                          buttonText: 'STRIKE',
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: CustomRaisedButton(
                          buttonText: 'FOUL',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
