import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/views/new_game.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';

class NavBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final String section;

  NavBar({@required this.title, @required this.section});

  Widget buildBar(BuildContext context) {
    if (section == 'index') {
      return _indexBar(context);
    } else if (section == 'new') {
      return _newBar(context);
    } else if (section == 'scoreGame') {
      return _scoreGameBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: buildBar(context),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);

  Widget _indexBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 45,
            child: Column(
              children: <Widget>[
                Text(
                  title,
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
        Expanded(
          child: Container(
            height: 45,
          ),
        ),
        Expanded(
          child: Container(
            height: 40,
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 25,
              height: 25,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<BaseGameInfo>(
                                create: (context) => BaseGameInfo(),
                                child: NewGame())),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.secondaryBlue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _newBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 45,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 25,
              height: 25,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.secondaryBlue,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 45,
            child: Column(
              children: <Widget>[
                Text(
                  title,
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
        Expanded(
          child: Container(
            height: 45,
          ),
        ),
      ],
    );
  }

  Widget _scoreGameBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 45,
          ),
        ),
        Expanded(
          child: Container(
            height: 45,
          ),
        ),
        Expanded(
          child: Container(
            height: 45,
            child: Column(
              children: <Widget>[
                Text(
                  title,
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
      ],
    );
  }
}
