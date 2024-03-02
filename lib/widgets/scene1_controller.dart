import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/game_intro/view/game_win_dialog.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:plastic_warriors/player/weapons/lovestone1.dart';
import 'package:plastic_warriors/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

import 'package:plastic_warriors/utils/custom_sprite_animation_widget.dart';
import 'package:plastic_warriors/utils/localization/my_localizations.dart';
import 'package:plastic_warriors/utils/localization/strings_location.dart';
import 'package:plastic_warriors/utils/npc_sprite_sheet.dart';
import 'package:plastic_warriors/utils/enemy_sprite_sheet.dart';
import 'package:plastic_warriors/utils/player_sprite_sheet.dart';
import 'package:plastic_warriors/npc/scientist_npc.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Scene1Controller extends GameComponent {
  bool showGScene1Story1 = true;
  bool showGScene1Story1B = false;
  bool showGScene1Story2 = false;
  bool showDrK = false;
  bool showGameWin = false;
  final double _fontSize = 25;
  var positionScientist = Vector2(50, 150);
  late LoveStone1 gun;
  late Ari ari;

  @override
  void update(double dt) {
    if (checkInterval('gameOver', 100, dt)) {
      if (gameRef.enemies().isEmpty) {
        if (!showGameWin) {
          _showDialogGameWin();
          gameRef.pauseEngine();
        }
      }
    }

    if (showGScene1Story1) {
      _showDialogGScene1Story1();

      // _showDialogGScene1Story1B();

      showGScene1Story1 = false;
    }

    if (showDrK) {
      ScientistNPC scientist = ScientistNPC(
          positionScientist); // replace x, y with the desired coordinates
      gameRef.add(scientist);
      showDrK = false;
      showGScene1Story1B = true;
    }

    if (showGScene1Story1B) {
      _showDialogGScene1Story1B();
      showGScene1Story1B = false;
    }

    ari = gameRef.player as Ari;
    //when ari kill first enemy
    if (ari.xp > 0) {
      if (!showGScene1Story2) {
        _showDialogGScene1Story2();
        showGScene1Story2 = true;
      }
    }

    super.update(dt);
  }

  void _showDialogGScene1Story1() {
    if (gameRef.player != null) {
      ari = gameRef.player as Ari;
      ari.showEmote();
    }
    Sounds.interaction();
    gameRef.pauseEngine();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
                text: "What is this?", style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/Ari-expression1.webp'),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text: "hehehehehehehheheheh",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: CustomSpriteAnimationWidget(
            animation: EnemySpriteSheet.bagMonsterTalkAnimation(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
        gameRef.resumeEngine();
        showDrK = true;
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }

  void _showDialogGScene1Story1B() {
    Sounds.interaction();
    gameRef.pauseEngine();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
                text: "Young man! Danger!",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(text: "Catch this!", style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-heart.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(text: "Huh?!", style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/Ari-heart.webp'),
          personSayDirection: PersonSayDirection.LEFT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
        gameRef.resumeEngine();
        _addLoveStone1();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }

  void _showDialogGameWin() {
    Navigator.of(context).push(GameWinDialog.route());
    showGameWin = false;
  }

  void _addLoveStone1() {
    if (gameRef.player != null) {
      Ari ari = gameRef.player as Ari;
      var stone1 = LoveStone1(Vector2(14, -2));
      ari.lovestone = stone1;
      //mount the gun to the player
      ari.add(stone1);
    }
  }

  void _showDialogGScene1Story2() {
    // player stop moving
    if (gameRef.player != null) {
      gameRef.player?.stopMove();
    }
    Sounds.interaction();
    gameRef.pauseEngine();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
                text: "What just happened..?",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/Ari-expression1.webp'),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text: "The stone actually worked!",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/girl-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text: "Please found the greedy stone and destory it!",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/girl-stone.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
        gameRef.resumeEngine();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
