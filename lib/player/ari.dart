import 'dart:async' as async;
import 'dart:io';

import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/decoration/potion_life.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/utils/functions.dart';
import 'package:plastic_warriors/utils/game_sprite_sheet.dart';
import 'package:plastic_warriors/player/weapons/lovestone1.dart';
import 'package:plastic_warriors/utils/player_sprite_sheet.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ari extends SimplePlayer with Lighting, BlockMovementCollision {
  static final Ari instance = Ari._privateConstructor();

  Ari._privateConstructor()
      : super(
          animation: PlayerSpriteSheet.playerAnimations(),
          size: Vector2.all(tileSize),
          position: Vector2.zero(),
          life: 200,
          speed: tileSize * 2.5,
        );

  double attack = 25;
  double stamina = 100;
  async.Timer? _timerStamina;
  LoveStone1? lovestone;
  bool containKey = false;
  bool showObserveEnemy = false;
  // Add a timestamp for the last attack
  double lastAttackTime = 0;

  // Add a cooldown period for attacks (in seconds)
  double attackCooldown = 1; //  cooldown

  // add coins
  int coins = 0;

  // add xp
  int xp = 0;

  Ari(Vector2 position)
      : super(
          animation: PlayerSpriteSheet.playerAnimations(),
          size: Vector2.all(tileSize),
          position: position,
          life: 200,
          speed: tileSize * 2.5,
        ) {
    setupMovementByJoystick(

        // intencityEnabled: true,
        );
  }

  @override
  async.Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(valueByTileSize(8), valueByTileSize(8)),
        position: Vector2(
          valueByTileSize(4),
          valueByTileSize(8),
        ),
      ),
    );
    return super.onLoad();
  }

  @override
  void onMount() {
    super.onMount();
  }

  @override
  void die() {
    removeFromParent();
    gameRef.add(
      GameDecoration.withSprite(
        sprite: Sprite.load('player/crypt.png'),
        position: Vector2(
          this.position.x,
          this.position.y,
        ),
        size: Vector2.all(32),
      ),
    );

    super.die();
  }

  void actionAttack() {
    if (stamina < 15) {
      return;
    }

    Sounds.attackPlayerMelee();
    decrementStamina(0);
    this.simpleAttackMelee(
      damage: attack,
      animationRight: PlayerSpriteSheet.attackEffectRight(),
      size: Vector2.all(tileSize * 0.8),
    );
  }

  void actionAttackRange(Enemy closestEnemy) {
    if (stamina < 10) {
      return;
    }

    Sounds.attackRange();

    //decrementStamina(10);

    //get Direction by position of player and enemy

    this.simpleAttackRange(
      animationRight: GameSpriteSheet.fireBallAttackRight(),
      animationDestroy: GameSpriteSheet.fireBallExplosion(),
      size: Vector2(tileSize * 0.65, tileSize * 0.65),
      damage: 20,
      speed: speed * 2.5,
      onDestroy: () {
        Sounds.explosion();
      },
      collision: RectangleHitbox(
        size: Vector2(tileSize / 3, tileSize / 3),
        position: Vector2(10, 5),
      ),
      lightingConfig: LightingConfig(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withOpacity(0.4),
      ),
    );
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _verifyStamina();

    lastAttackTime += dt;
    this.seeEnemy(
      radiusVision: tileSize * 3,
      notObserved: () {
        //showObserveEnemy = false;
      },
      observed: (enemies) {
        //actionAttack();

        //actionAttackRange(enemies.firstWhere((element) => element is Goblin));

        //if class LoveStone1 is added to this player
        if (lastAttackTime > attackCooldown) {
          var enemy = enemies[0];
          ariExecuteAttack(enemy);
          lastAttackTime = 0.0;
        }
      },
    );
    super.update(dt);
  }

  void ariExecuteAttack(Enemy closestEnemy) {
    if (lovestone?.reloading == false) {
      var angle = BonfireUtil.angleBetweenPoints(
        lovestone?.absoluteCenter ?? absoluteCenter,
        closestEnemy.position,
      );
      lovestone?.changeAngle(angle);
      lovestone?.execShoot(attack);
    }
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  void _verifyStamina() {
    if (_timerStamina == null) {
      _timerStamina = async.Timer(Duration(milliseconds: 150), () {
        _timerStamina = null;
      });
    } else {
      return;
    }

    stamina += 2;
    if (stamina > 100) {
      stamina = 100;
    }
  }

  void decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic id) {
    if (isDead) return;
    this.showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.white10,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(attacker, damage, id);
  }

  void showEmote({String emote = 'emote/emote_exclamacao.png'}) {
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
        target: this,
        loop: false,
        size: Vector2.all(tileSize / 2),
        offset: Vector2(18, -6),
      ),
    );
  }

  void increaseCoins(int amount) {
    coins += amount;
  }

  void increaseExperience(int amount) {
    xp += amount;
  }
}
