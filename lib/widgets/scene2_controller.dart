import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/game_intro/view/game_intro_page.dart';
import 'package:plastic_warriors/game_intro/view/game_win_dialog.dart';
import 'package:plastic_warriors/game_intro/view/game_win_dialog2.dart';
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

class Scene2Controller extends GameComponent {
  bool showGScene1Story1 = true;
  bool showGScene1Story1B = false;
  bool showGScene1Story2 = false;
  bool showDrK = false;
  bool showGameWin = false;
  bool showLastDialog = false;
  final double _fontSize = 25;
  var positionScientist = Vector2(50, 150);
  late LoveStone1 gun;
  late Ari ari;

  @override
  void update(double dt) {
    if (checkInterval('gameOver', 100, dt)) {
      if (gameRef.enemies().isEmpty) {
        if (!showLastDialog) {
          _showLastDialog();
        }

        if (showLastDialog) {
          gameRef.pauseEngine();
          _showDialogGameWin();
        }
      }
    }

    if (showGScene1Story1) {
      _showDialogGScene1Story1();

      showGScene1Story1 = false;
    }

    if (gameRef.player != null) {
      ari = gameRef.player as Ari;
      var stone1 = LoveStone1(Vector2(14, -2));
      ari.lovestone = stone1;
      //mount the gun to the player
      ari.add(stone1);
    }

    super.update(dt);
  }

  void _showDialogGScene1Story1() {
    if (gameRef.player != null) {
      ari = gameRef.player as Ari;
    }
    Sounds.interaction();
    gameRef.pauseEngine();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
                text: "Dr. K, why does the Stone of Love react to me?",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/Ari-expression1.webp'),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    "It's because you share a special connection with the Stone of Love; there might even be deeper reasons we've yet to discover. But right now, only you can unlock its full potential, which is why we need you.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text: "Then, where do these monsters come from?",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/Ari-expression1.webp'),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    "The Stone of Greed are devices placed on our planet by aliens. They turn the plastic waste into living entities to create chaos, but we're still unsure of their purpose.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    "These monsters are formed from plastic waste manipulated by the Stone of Greed.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    "Our mission is to find and destroy the Stone of Greed in this area to restore the ecological balance.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/girl-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    "The Stone of Greed is hidden in places that can cause the greatest environmental damage. I'm certain it's located at the very depths.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text: "Got it. Let's get moving!",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/Ari-expression1.webp'),
          personSayDirection: PersonSayDirection.LEFT,
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

  void _showDialogGameWin() {
    Navigator.of(context).push(GameWinDialog2.route()).then((value) {
      return GameIntroPage();
    });
    showGameWin = true;
  }

  void _showLastDialog() {
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
                text:
                    "Look, Ari, you're learning how to use the Stone of Love. Every time you use it, you're helping to restore the balance of our world.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/DrK-expression1.webp'),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text:
                    "Right, we'll turn these plastic monsters back to their original form, then find that Stone of Greed and bring peace to this place.",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: Image.asset('assets/images/ari-expression1.webp'),
          personSayDirection: PersonSayDirection.LEFT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
        showLastDialog = true;
        gameRef.resumeEngine();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
