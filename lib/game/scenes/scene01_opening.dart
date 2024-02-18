import 'package:flame/game.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_warriors/game/game.dart';

import 'package:plastic_warriors/audio/audio.dart';

import 'package:flutter/material.dart';
import 'package:flame/game.dart' as flame;

class Slide {
  String imagePath;
  String text;

  Slide(this.imagePath, this.text);
}

class Scene01Opening extends FlameGame with TapDetector {
  List<Slide> slides = [
    Slide('Scene01_01.webp', 'Welcome to the slideshow!'),
    Slide('Scene01_02.webp', 'Welcome to the slideshow!'),
    Slide('Scene01_03.webp', 'Welcome to the slideshow!'),
    Slide('Scene01_04.webp', 'Welcome to the slideshow!'),
  ];

  final VoidCallback onGameFinished;

  int currentSlideIndex = 0;
  late TextComponent textComponent;
  late SpriteComponent imageComponent;

  Scene01Opening(
      {required this.gameBloc,
      required this.audioController,
      required this.onGameFinished,
      this.customBundle})
      : super();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera = CameraComponent.withFixedResolution(
      width: _cameraViewport.x,
      height: _cameraViewport.y,
    )..world = world;

    _loadSlide(); // Load the initial slide
  }

  @override
  void onTap() {
    _changeSlide(); // Allow manual changing with a tap
  }

  Future<void> _loadSlide() async {
    imageComponent = SpriteComponent.fromImage(
      await images.load(slides[currentSlideIndex].imagePath),
    );

    textComponent = TextComponent(text: slides[currentSlideIndex].text);
    // Position the text in the bottom center
    textComponent.anchor = Anchor.bottomCenter;

    add(imageComponent);
    add(textComponent);
  }

  void _changeSlide() {
    imageComponent.removeFromParent();
    textComponent.removeFromParent();

    currentSlideIndex = currentSlideIndex + 1;

    if (currentSlideIndex > slides.length) {
      // go to Play_Session01_Screen01
      // gameBloc.add(GameEvent.start);

      // go to Play_Session01_Screen01
      //Navigator.of(context).push(GameView1.route());
      onGameFinished();
    }
    _loadSlide();
  }

  static final _cameraViewport = Vector2(592, 1024);

  final GameBloc gameBloc;
  final AssetBundle? customBundle;
  final AudioController audioController;
}
