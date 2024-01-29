import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:plastic_warriors/player/weapons/bullet_capsule.dart';
//import 'package:plastic_warriors/util/player_spritesheet.dart';
import 'package:plastic_warriors/util/player_sprite_sheet.dart';

class VacuumWeapon extends GameDecoration with ChangeNotifier {
  double dt = 0;
  final double timeToReload = 5;
  final Color flash = const Color(0xFF73eff7).withOpacity(0.5);
  final bool withScreenEffect;
  final AttackFromEnum attackFrom;
  final PlayerColor color;
  final bool blockShootWithoutBullet;
  SpriteAnimation? _normalAnimation;
  SpriteAnimation? _reloadAnimation;
  int _countBullet = 10;
  bool reloading = false;
  double currentTimeReload = 0;
  VacuumWeapon(
    Vector2 position,
    this.color, {
    this.withScreenEffect = true,
    this.blockShootWithoutBullet = true,
    this.attackFrom = AttackFromEnum.PLAYER_OR_ALLY,
  }) : super.withAnimation(
          animation: PlayerSpriteSheet.gun(),
          position: position,
          size: Vector2.all(32),
        );

  @override
  void update(double dt) {
    this.dt = dt;

    if ((parent as Movement).lastDirectionHorizontal != Direction.down) {
      if (!isFlippedVertically) {
        flipVertically();
      }
    } else {
      if (isFlippedVertically) {
        flipVertically();
      }
    }

    if (reloading) {
      currentTimeReload += dt;
      if (currentTimeReload >= timeToReload) {
        reloading = false;
        _countBullet = 10;
        setAnimation(_normalAnimation);
      }
      notifyListeners();
    }
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    _reloadAnimation = await PlayerSpriteSheet.gunReload();
    _normalAnimation = await PlayerSpriteSheet.gun();
    anchor = Anchor.center;
    return super.onLoad();
  }

  void execShoot(double damage) {
    if (_countBullet <= 0 && blockShootWithoutBullet) {
      return;
    }
    playSpriteAnimationOnce(
      PlayerSpriteSheet.gunShot(),
    );
    simpleAttackRangeByAngle(
      animation: PlayerSpriteSheet.bullet,
      size: Vector2.all(24),
      angle: radAngle,
      damage: damage,
      speed: 300,
      collision: RectangleHitbox(
        size: Vector2.all(16),
        position: Vector2.all(16) / 2,
      ),
      marginFromOrigin: -3,
      attackFrom: attackFrom,
    );
    if (withScreenEffect) {
      gameRef.camera.shake(
        intensity: 1,
        duration: const Duration(milliseconds: 200),
      );
      gameRef.colorFilter?.config.color = flash;
      gameRef.colorFilter?.animateTo(Colors.transparent);
    }

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
    notifyListeners();
  }

  double radAngle = 0;

  void changeAngle(double radAngle) {
    this.radAngle = radAngle;
    angle = calculeNewAngle(radAngle);
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
