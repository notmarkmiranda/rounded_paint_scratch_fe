import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';

class LabelWithCounter extends StatelessWidget {
  final String labelText;
  final String tag;

  const LabelWithCounter({@required this.labelText, @required this.tag});

  @override
  Widget build(BuildContext context) {
    final baseGameInfo = Provider.of<BaseGameInfo>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 24,
                height: 24,
                child: FlatButton(
                  onPressed: () {
                    baseGameInfo.changeTag(tag, Direction.down);
                  },
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Text(
                baseGameInfo.state[tag].toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 24,
                height: 24,
                child: FlatButton(
                  onPressed: () {
                    baseGameInfo.changeTag(tag, Direction.up);
                  },
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.keyboard_arrow_up),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
