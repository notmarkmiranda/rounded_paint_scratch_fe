import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';
import 'package:rounded_paint_scratch_fe/views/score_game.dart';
import 'package:rounded_paint_scratch_fe/widgets/custom_raised_button.dart';
import 'package:rounded_paint_scratch_fe/widgets/label_with_counter.dart';
import 'package:rounded_paint_scratch_fe/widgets/nav_bar.dart';
import 'package:rounded_paint_scratch_fe/widgets/team_text_form_field.dart';

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> with SingleTickerProviderStateMixin {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  TextEditingController _awayTeamController;
  TextEditingController _homeTeamController;
  FocusNode _homeTeamFocusNode;
  AnimationController _animationController;
  Animation<Offset> offset;
  Animation<Offset> otherOffset;
  Uuid uuid = Uuid();

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _awayTeamController = TextEditingController();
    _homeTeamController = TextEditingController();
    _homeTeamFocusNode = FocusNode();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    offset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.5, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    otherOffset = Tween<Offset>(
      begin: Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  Future<Null> _saveNewGame(gameInfo) async {
    final p = await prefs;
    var gamesJson = p.getString('allGames');
    List existingGames = gamesJson == null ? [] : jsonDecode(gamesJson);
    existingGames.insert(0, gameInfo);
    p.setString('allGames', jsonEncode(existingGames));
  }

  void buttonPressed(BaseGameInfo baseGameInfo) {
    baseGameInfo.updateTeam(
      _awayTeamController.text,
      'awayTeam',
    );
    baseGameInfo.updateTeam(
      _homeTeamController.text,
      'homeTeam',
    );
    baseGameInfo.updateTag(uuid.v1(), 'gameUuid');
    String now = DateTime.now().toString();
    baseGameInfo.updateTag(now, 'createdAt');
    baseGameInfo.updateTag(now, 'updatedAt');
    _saveNewGame(baseGameInfo.state);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ChangeNotifierProvider<BaseGameInfo>(
          create: (context) => BaseGameInfo(
            initialState: baseGameInfo.state,
          ),
          child: ScoreGame(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseGameInfo = Provider.of<BaseGameInfo>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: NavBar(
        title: 'NEW GAME',
        section: 'new',
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: GestureDetector(
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
              height: (MediaQuery.of(context).size.height - 110),
              margin: EdgeInsets.only(top: 25),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TeamTextFormField(
                      hintText: 'Away Team',
                      controller: _awayTeamController,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      onEditingComplete: () =>
                          _homeTeamFocusNode.requestFocus(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TeamTextFormField(
                      hintText: 'Home Team',
                      controller: _homeTeamController,
                      focusNode: _homeTeamFocusNode,
                      autofocus: false,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    LabelWithCounter(
                      labelText: 'Number Of Innings',
                      tag: 'numberOfInnings',
                    ),
                    LabelWithCounter(
                      labelText: 'Outs Per Inning',
                      tag: 'outsPerInning',
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CheckboxListTile(
                        checkColor: Colors.white,
                        activeColor: AppColors.primaryBlue,
                        value: baseGameInfo.state['combineFoulsStrikes'],
                        onChanged: (newValue) {
                          if (newValue == false) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                          baseGameInfo.toggleFoulsStrikes(newValue);
                        },
                        title: Text('Fouls & Strikes Combined?'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Stack(
                      children: [
                        SlideTransition(
                          position: otherOffset,
                          child: LabelWithCounter(
                            labelText: 'Fouls Per Out',
                            tag: 'foulsPerOut',
                          ),
                        ),
                        SlideTransition(
                          position: offset,
                          child: LabelWithCounter(
                            labelText: 'Fouls & Strikes Per Out',
                            tag: 'foulsStrikesPerOut',
                          ),
                        ),
                      ],
                    ),
                    LabelWithCounter(
                      labelText: 'Balls Per Walk',
                      tag: 'ballsPerWalk',
                    ),
                    Stack(
                      children: [
                        SlideTransition(
                          position: otherOffset,
                          child: LabelWithCounter(
                            labelText: 'Strikes Per Out',
                            tag: 'strikesPerOut',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 40,
                      child: CustomRaisedButton(
                        buttonText: "LET'S GO!",
                        buttonPressed: () {
                          buttonPressed(baseGameInfo);
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
