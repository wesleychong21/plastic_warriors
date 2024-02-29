import 'dart:async';
import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/enemies/imp.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/utils/custom_sprite_animation_widget.dart';
import 'package:plastic_warriors/utils/enemy_sprite_sheet.dart';
import 'package:plastic_warriors/utils/functions.dart';
import 'package:plastic_warriors/utils/game_sprite_sheet.dart';
import 'package:plastic_warriors/utils/localization/strings_location.dart';
import 'package:plastic_warriors/utils/npc_sprite_sheet.dart';
import 'package:plastic_warriors/utils/player_sprite_sheet.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:plastic_warriors/enemies/greedy_stone_bullet.dart';
import 'package:flutter/material.dart';

class Greedy_Stone extends SimpleEnemy with BlockMovementCollision, UseLifeBar {
  final Vector2 initPosition;
  double attack = 40;

  bool addChild = false;
  final bool withScreenEffect;
  final AttackFromEnum attackFrom;

  final bool blockShootWithoutBullet;

  List<Enemy> childrenEnemy = [];

  // Add a timestamp for the last attack
  double lastAttackTime = 0;

  // Add a cooldown period for attacks (in seconds)
  double attackCooldown = 0.5; //  cooldown

  Greedy_Stone(
    this.initPosition, {
    this.withScreenEffect = true,
    this.blockShootWithoutBullet = false,
    this.attackFrom = AttackFromEnum.ENEMY,
  }) : super(
          animation: EnemySpriteSheet.greedyStoneAnimations(),
          position: initPosition,
          size: Vector2(tileSize, tileSize),
          speed: tileSize * 1.5,
          life: 200,
        );

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(valueByTileSize(14), valueByTileSize(16)),
        position: Vector2(valueByTileSize(5), valueByTileSize(11)),
      ),
    );
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    drawBarSummonEnemy(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    lastAttackTime += dt;
    this.seePlayer(
      observed: (player) {
        if (lastAttackTime > attackCooldown) {
          execAttack(player);
          lastAttackTime = 0.0;
        }
      },
      radiusVision: tileSize * 8,
    );

    super.update(dt);
  }

  @override
  void die() {
    gameRef.add(
      AnimatedGameObject(
        animation: GameSpriteSheet.explosion(),
        position: this.position,
        size: Vector2(32, 32),
        loop: false,
      ),
    );
    childrenEnemy.forEach((e) {
      if (!e.isDead) e.die();
    });
    removeFromParent();
    super.die();
  }

  void execAttack(Player player) {
    /*
    this.simpleAttackMelee(
      size: Vector2.all(tileSize * 0.62),
      damage: attack,
      interval: 1500,
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
    */

    Vector2 direction =
        player.position - this.position; // this refers to the GreedyStone
    double angle = direction.angleTo(Vector2(0, -1));

    simpleAttackRangeByAngle(
      animation: EnemySpriteSheet.greedyStoneBulletAnimation(),
      size: Vector2.all(23),
      angle: angle,
      damage: 10,
      speed: 300,
      onDestroy: () {
        Sounds.explosion();
      },
      collision: RectangleHitbox(
        size: Vector2.all(16),
        position: Vector2.all(16) / 2,
      ),
      marginFromOrigin: -3,
      attackFrom: attackFrom,
    );

    gameRef.add(
      GreedyStoneBullet(
        absoluteCenter,
        angle,
      ),
    );
  }

  double radAngle = 0;

  void changeAngle(double radAngle) {
    this.radAngle = radAngle;
    //angle = calculeNewAngle(radAngle);
  }

  double calculeNewAngle(double radAngle) {
    return radAngle + ((isFlippedVertically && radAngle != 0) ? pi : 0);
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

  void drawBarSummonEnemy(Canvas canvas) {
    double yPosition = 0;
    double widthBar = (width - 10) / 3;
    if (childrenEnemy.length < 1)
      canvas.drawLine(
          Offset(0, yPosition),
          Offset(widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);

    double lastX = widthBar + 5;
    if (childrenEnemy.length < 2)
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);

    lastX = lastX + widthBar + 5;
    if (childrenEnemy.length < 3)
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);
  }
}
