import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/score/bloc/score_bloc.dart';
import 'package:plastic_warriors/score/game_over/game_over.dart';
import 'package:plastic_warriors/utils/dialogs.dart';
import 'package:flutter/material.dart';

class GameController extends GameComponent {
  bool showGameOver = false;
  late ScoreState scoreState;
  @override
  void update(double dt) {
    if (checkInterval('gameOver', 100, dt)) {
      if (gameRef.player != null && gameRef.player?.isDead == true) {
        if (!showGameOver) {
          showGameOver = true;

          _showDialogGameOver();
          gameRef.pauseEngine();
        }
      }
    }
    super.update(dt);
  }

  void _showDialogGameOver() {
    showGameOver = true;
    Dialogs.showGameOver(
      context,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BattleGameView(level: 1)),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
