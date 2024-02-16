import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/utils/custom_sprite_animation_widget.dart';
import 'package:plastic_warriors/utils/localization/strings_location.dart';
import 'package:plastic_warriors/utils/npc_sprite_sheet.dart';
import 'package:plastic_warriors/utils/player_sprite_sheet.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScientistNPC extends SimpleNpc {
  bool _showConversation = false;
  ScientistNPC(
    Vector2 position,
  ) : super(
          animation: SimpleDirectionAnimation(
            idleRight: NpcSpriteSheet.wizardIdleLeft(),
            runRight: NpcSpriteSheet.wizardIdleLeft(),
          ),
          position: position,
          size: Vector2(
            tileSize,
            tileSize,
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    /*
    if (gameRef.player != null) {
      this.seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_showConversation) {
            gameRef.player!.idle();
            _showConversation = true;
            _showEmote(emote: 'emote/emote_interregacao.png');
            _showIntroduction();
          }
        },
        radiusVision: (3 * tileSize),
      );
    }
    */
  }

  void _showEmote({String emote = 'emote/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerGameObject(
        animation: SpriteAnimation.load(
          emote,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        loop: false,
        target: this,
        offset: Vector2(18, -6),
        size: Vector2.all(tileSize / 2),
      ),
    );
  }

  void _showIntroduction() {
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
                text: getString('talk_wizard_1'),
                style: TextStyle(fontSize: 20))
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            TextSpan(
                text: getString('talk_player_1'),
                style: TextStyle(fontSize: 24))
          ],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [
            TextSpan(
                text: getString('talk_wizard_2'),
                style: TextStyle(fontSize: 30))
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_player_2'))],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_wizard_3'))],
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
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
