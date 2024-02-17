import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:plastic_warriors/audio/audio.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/score/score.dart';

class Scene01Opening extends FlameGame {
  late Sprite _background;

  Scene01Opening(
      {required this.gameBloc,
      required this.audioController,
      this.customBundle})
      : super();

  @override
  Future<void> onLoad() async {
    //load the assets
    _background = await Sprite.load('Scene01_01.webp');
    camera = CameraComponent.withFixedResolution(
      width: _cameraViewport.x,
      height: _cameraViewport.y,
    )..world = world;

    add(SpriteComponent(
      sprite: _background,
      size: Vector2(_cameraViewport.x, _cameraViewport.y),
    ));

    //build the slide show
    _buildSlideShow();

    return super.onLoad();
  }

//build method
  @override
  void update(double dt) {
    //build a slide show

    super.update(dt);
  }

  static final _cameraViewport = Vector2(592, 1024);

  final GameBloc gameBloc;
  final AssetBundle? customBundle;
  final AudioController audioController;
  final List<VoidCallback> _inputListener = [];

  _buildSlideShow() {
    //build the slide show
  }
}
