import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';
import 'package:rounded_paint_scratch_fe/widgets/nav_bar.dart';

class ScoreGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseGameInfo = Provider.of<BaseGameInfo>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: NavBar(
        title: 'LIVE GAME',
        section: 'scoreGame',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
              height: 50,
              color: Colors.white,
              child: Row(
                children: [],
              )),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Text(
                'Hello',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
