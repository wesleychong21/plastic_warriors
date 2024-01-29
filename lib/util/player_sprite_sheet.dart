import 'package:bonfire/bonfire.dart';

enum PlayerColor {
  blue,
  green,
  red;

  factory PlayerColor.fromName(String? name) {
    if (name == null) {
      return PlayerColor.blue;
    }
    return PlayerColor.values.firstWhere((element) => element.name == name);
  }

  Color getColor() {
    switch (this) {
      case PlayerColor.blue:
        return const Color(0xFF3b5dc9);
      case PlayerColor.green:
        return const Color(0xFF257179);
      case PlayerColor.red:
        return const Color(0xFFb13e53);
    }
  }
}

class PlayerSpriteSheet {
  static Future<SpriteAnimation> idleRight() => SpriteAnimation.load(
        'player/ari_idle.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static Future<SpriteAnimation> attackEffectBottom() => SpriteAnimation.load(
        'player/atack_effect_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static Future<SpriteAnimation> attackEffectLeft() => SpriteAnimation.load(
        'player/atack_effect_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );
  static Future<SpriteAnimation> attackEffectRight() => SpriteAnimation.load(
        'player/atack_effect_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );
  static Future<SpriteAnimation> attackEffectTop() => SpriteAnimation.load(
        'player/atack_effect_top.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static SimpleDirectionAnimation playerAnimations() =>
      SimpleDirectionAnimation(
        idleLeft: SpriteAnimation.load(
          'player/ari_idle.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        idleRight: idleRight(),
        runLeft: SpriteAnimation.load(
          'player/ari_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        runRight: SpriteAnimation.load(
          'player/ari_run_right.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        runUp: SpriteAnimation.load(
          'player/ari_run_up.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        runDown: SpriteAnimation.load(
          'player/ari_run_down.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
      );

  static Future<SpriteAnimation> gun() => SpriteAnimation.load(
        'player/gun.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2.all(32),
        ),
      );

  static Future<SpriteAnimation> gunShot() => SpriteAnimation.load(
        'player/gun.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2.all(32),
          texturePosition: Vector2(0, 64),
        ),
      );

  static Future<SpriteAnimation> gunReload() => SpriteAnimation.load(
        'player/gun.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2.all(32),
          texturePosition: Vector2(0, 32),
        ),
      );

  static Future<SpriteAnimation> get bullet => SpriteAnimation.load(
        'player/bullet_blue.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2.all(16),
        ),
      );

  static Future<Sprite> get bulletCapsule => Sprite.load(
        'player/bullet_blue.png',
        srcSize: Vector2.all(16),
        srcPosition: Vector2(0, 16),
      );
}
