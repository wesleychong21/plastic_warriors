import 'package:bonfire/bonfire.dart';

class NpcSpriteSheet {
  static Future<SpriteAnimation> kidIdleLeft() => SpriteAnimation.load(
        'npc/kid_idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 22),
        ),
      );

  static Future<SpriteAnimation> wizardIdleLeft() => SpriteAnimation.load(
        'npc/scientist_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static Future<SpriteAnimation> girlIdleLeft() => SpriteAnimation.load(
        'npc/lina-idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );
}
