import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/game/game.dart';
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
  bool showDrK = false;
  final double _fontSize = 25;
  var positionScientist = Vector2(50, 150);
  late LoveStone1 gun;

  @override
  void update(double dt) {
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
    super.update(dt);
  }

  void _showDialogGScene1Story1() {
    if (gameRef.player != null) {
      Ari ari = gameRef.player as Ari;
      ari.showEmote();
    }
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [TextSpan(text: "Hehe", style: TextStyle(fontSize: _fontSize))],
          person: CustomSpriteAnimationWidget(
            animation: EnemySpriteSheet.bagMonsterTalkAnimation(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text: "What is this?", style: TextStyle(fontSize: _fontSize))
          ],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
        showDrK = true;
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }

  void _showDialogGScene1Story1B() {
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
                text: "Young man! Danger!",
                style: TextStyle(fontSize: _fontSize))
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(text: "Catch this!", style: TextStyle(fontSize: _fontSize))
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();

        _addLoveStone1();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }

  void _addLoveStone1() {
    if (gameRef.player != null) {
      Ari ari = gameRef.player as Ari;
      var stone1 = LoveStone1(Vector2(14, -2));
      ari.gun = stone1;
      //mount the gun to the player
      ari.add(stone1);
    }
  }
}
