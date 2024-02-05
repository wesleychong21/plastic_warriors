import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:plastic_warriors/player/weapons/bullet_capsule.dart';
//import 'package:plastic_warriors/util/player_spritesheet.dart';
import 'package:plastic_warriors/util/player_sprite_sheet.dart';
import 'package:plastic_warriors/util/sounds.dart';

class LoveStone1 extends GameDecoration {
  double dt = 0;
  final double timeToReload = 3;
  final Color flash = const Color(0xFF73eff7).withOpacity(0.5);
  final bool withScreenEffect;
  final AttackFromEnum attackFrom;

  final bool blockShootWithoutBullet;
  SpriteAnimation? _normalAnimation;
  SpriteAnimation? _reloadAnimation;
  int _countBullet = 10;
  bool reloading = false;
  double currentTimeReload = 0;
  LoveStone1(
    Vector2 position, {
    this.withScreenEffect = true,
    this.blockShootWithoutBullet = false,
    this.attackFrom = AttackFromEnum.PLAYER_OR_ALLY,
  }) : super.withAnimation(
          animation: PlayerSpriteSheet.lovestone1(),
          position: position,
          size: Vector2.all(16),
        );

  @override
  void update(double dt) {
    this.dt = dt;

    if (reloading) {
      currentTimeReload += dt;
      if (currentTimeReload >= timeToReload) {
        reloading = false;
        _countBullet = 10;
        setAnimation(_normalAnimation);
      }
    }
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    _reloadAnimation = await PlayerSpriteSheet.gunReload();
    _normalAnimation = await PlayerSpriteSheet.lovestone1();
    anchor = Anchor.center;
    return super.onLoad();
  }

  void execShoot(double damage) {
    if (_countBullet <= 0 && blockShootWithoutBullet) {
      return;
    }
    playSpriteAnimationOnce(
      PlayerSpriteSheet.lovestone1Shooting(),
    );
    simpleAttackRangeByAngle(
      animation: PlayerSpriteSheet.bullet,
      size: Vector2.all(24),
      angle: radAngle,
      damage: damage,
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
      BulletCapsule(
        absoluteCenter,
        _getAnglecapsule(radAngle),
      ),
    );
    _countBullet--;
    if (_countBullet == 0) {
      currentTimeReload = 0;
      reloading = true;
      setAnimation(_reloadAnimation);
    }
  }

  double radAngle = 0;

  void changeAngle(double radAngle) {
    this.radAngle = radAngle;
    //angle = calculeNewAngle(radAngle);
  }

  double calculeNewAngle(double radAngle) {
    return radAngle + ((isFlippedVertically && radAngle != 0) ? pi : 0);
  }

  double _getAnglecapsule(double radAngle) {
    double angle = radAngle + pi / 2;
    Direction angleDirection = BonfireUtil.getDirectionFromAngle(angle);
    if (angleDirection == Direction.down ||
        angleDirection == Direction.downLeft ||
        angleDirection == Direction.downRight) {
      angle += pi;
    }
    return angle;
  }

  void reload() {
    playSpriteAnimationOnce(
      PlayerSpriteSheet.gunReload(),
    );
  }

  void addBullet(int count) {
    _countBullet = count;
  }

  int get countBullet => _countBullet;
}
