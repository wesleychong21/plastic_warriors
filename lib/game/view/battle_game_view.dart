import 'package:app_ui/app_ui.dart';
import 'package:flame/game.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plastic_warriors/audio/audio.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/game_intro/game_intro.dart';
import 'package:plastic_warriors/game/scenes/scenes.dart';
import 'package:plastic_warriors/play_session/play_session01_screen01.dart';
import 'package:plastic_warriors/play_session/play_session01_screen02.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:plastic_warriors/widgets/game_controller.dart';
import 'package:plastic_warriors/widgets/scene1_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/boss.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/imp.dart';
import 'package:plastic_warriors/enemies/mini_boss.dart';
import 'package:plastic_warriors/interface/ari_interface.dart';
import 'package:plastic_warriors/game/widgets/widgets.dart' as gameWidgets;
import 'package:provider/provider.dart';

class BattleGameView extends StatefulWidget {
  final int level;

  BattleGameView({required this.level});

  static PageRoute<void> route(int level) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => BattleGameView(level: level),
    );
  }

  @override
  _BattleGameViewState createState() => _BattleGameViewState();
}

class _BattleGameViewState extends State<BattleGameView> {
  @override
  Widget build(BuildContext context) {
    int level = widget.level;
    return PageWithBackground(
      background: const gameWidgets.GameBackground(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            //width: 360,
            child: level == 1
                ? Play_Session01_Screen01()
                : Play_Session01_Screen02(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of your controllers and any other cleanup code here
    Sounds.stopBackgroundSound();
    super.dispose();
  }
}
