import 'package:flame/game.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plastic_warriors/audio/audio.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/game_intro/game_intro.dart';
import 'package:plastic_warriors/game/scenes/scenes.dart';
import 'package:plastic_warriors/play_session/play_session01_screen01.dart';
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

class BattleGameView extends StatefulWidget {
  const BattleGameView({Key? key}) : super(key: key);

  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const BattleGameView(),
    );
  }

  _BattleGameViewState createState() => _BattleGameViewState();
}

class _BattleGameViewState extends State<BattleGameView> {
  @override
  void initState() {
    Sounds.playScene1Sound();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 32;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 12,
            child: ScoreLabel(),
          ),
          const Positioned(
            bottom: 12,
            child: SafeArea(child: AudioButton()),
          ),
        ],
      ),
    );
  }
}
