import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/utils/game_sprite_sheet.dart';

class GreedyStoneBullet extends GameDecoration
    with Movement, BlockMovementCollision, HandleForces {
  bool removing = false;

  GreedyStoneBullet(Vector2 p, double angle)
      : super.withAnimation(
            animation: GameSpriteSheet.fireBallAttackRight(),
            position: p,
            size: Vector2(20.8, 20.8)) {
    this.angle = angle;

    speed = 300;
    movementOnlyVisible = false;
    addForce(
      ResistanceForce2D(
        id: 'id',
        value: Vector2.all(23),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await add(
      RectangleHitbox(
        size: Vector2(23, 23),
        position: Vector2.all(0),
      ),
    );
    moveFromAngle(angle);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!removing && isStopped()) {
      removing = true;
      _removeCapsule();
    }

    super.update(dt);
  }

  @override
  bool onBlockMovement(Set<Vector2> intersectionPoints, GameComponent other) {
    if (other is GreedyStoneBullet) {
      return false;
    }
    return super.onBlockMovement(intersectionPoints, other);
  }

  @override
  int get priority => LayerPriority.MAP + 1;

  void _removeCapsule() {
    removing = true;
    add(
      OpacityEffect.fadeOut(
        EffectController(
          duration: 0.1,
          alternate: true,
          repeatCount: 3,
          startDelay: 1,
        ),
        onComplete: removeFromParent,
      ),
    );
  }
}
