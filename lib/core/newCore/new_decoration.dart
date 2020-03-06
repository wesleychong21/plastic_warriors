import 'dart:ui';

import 'package:darkness_dungeon/core/AnimationGameObject.dart';
import 'package:darkness_dungeon/core/newCore/rpg_game.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart';

class NewDecoration extends AnimatedGameObject with HasGameRef<RPGGame> {
  final double height;
  final double width;
  final String spriteImg;
  final bool frontFromPlayer;
  final bool collision;
  final double sizeTileMap;
  final FlameAnimation.Animation animation;
  final Position initPosition;
  Sprite _sprite;
  Rect positionInWorld;

  NewDecoration(
    this.spriteImg, {
    this.initPosition,
    @required this.height,
    @required this.width,
    this.frontFromPlayer,
    this.animation,
    this.collision = false,
    this.sizeTileMap = 32,
  }) {
    this.animation = animation;
    if (spriteImg.isNotEmpty) _sprite = Sprite(spriteImg);
    position = Rect.fromLTWH(
      (initPosition != null ? initPosition.x : 0.0) * sizeTileMap,
      (initPosition != null ? initPosition.y : 0.0) * sizeTileMap,
      width,
      height,
    );
    positionInWorld = position;
  }

  @override
  void update(double dt) {
    position = Rect.fromLTWH(
      positionInWorld.left + gameRef.mapCamera.x,
      positionInWorld.top + gameRef.mapCamera.y,
      width,
      height,
    );
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (position.top < (gameRef.size.height + height) &&
        position.top > (height * -1) &&
        position.left > (width * -1) &&
        position.left < (gameRef.size.width + width)) {
      super.render(canvas);
      if (_sprite != null && _sprite.loaded())
        _sprite.renderRect(canvas, position);
    }
  }
}
