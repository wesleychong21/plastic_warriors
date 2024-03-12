import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/score/game_over/game_over.dart';
import 'package:plastic_warriors/utils/dialogs.dart';
import 'package:flutter/material.dart';

class GameController extends GameComponent {
  bool showGameOver = false;
  @override
  void update(double dt) {
    if (checkInterval('gameOver', 100, dt)) {
      if (gameRef.player != null && gameRef.player?.isDead == true) {
        if (!showGameOver) {
          showGameOver = true;
          //_showDialogGameOver();
          //MaterialPageRoute(builder: (context) => GameOverPage());
          Navigator.of(context).push(GameOverPage.route());
        }
      }
    }
    super.update(dt);
  }
}
