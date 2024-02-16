import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/utils/enemy_sprite_sheet.dart';
import 'package:plastic_warriors/utils/functions.dart';
import 'package:plastic_warriors/utils/game_sprite_sheet.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:flutter/material.dart';

class BagMonsterNPC extends SimpleEnemy
    with BlockMovementCollision, UseLifeBar {
  final Vector2 initPosition;
  double attack = 25;

  BagMonsterNPC(this.initPosition)
      : super(
          animation: EnemySpriteSheet.bagmonsterAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 0.8),
          speed: tileSize * 1.5,
          life: 120,
        );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(
      size: Vector2(
        valueByTileSize(7),
        valueByTileSize(7),
      ),
      position: Vector2(valueByTileSize(3), valueByTileSize(4)),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      radiusVision: tileSize * 4,
      // i want play once the sound when the enemy see the player

      observed: () => Sounds.bagMonsterDiscoverPlayer(),
    );
  }

  @override
  void die() {
    gameRef.add(
      AnimatedGameObject(
        animation: GameSpriteSheet.smokeExplosion(),
        position: this.position,
        size: Vector2(32, 32),
        loop: false,
      ),
    );
    removeFromParent();
    super.die();
  }

  void execAttack() {
    this.simpleAttackMelee(
      size: Vector2.all(tileSize * 0.62),
      damage: attack,
      interval: 800,
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic id) {
    this.showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(attacker, damage, id);
  }
}
