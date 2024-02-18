import 'package:flame/game.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
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

  final style1 = TextStyle(
    color: BasicPalette.white.color,
    fontSize: 20.0, // Change the font size here
  );
  TextPaint? regular;

  Scene01Opening(
      {required this.gameBloc,
      required this.audioController,
      required this.onGameFinished,
      this.customBundle})
      : super();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    regular = TextPaint(style: style1);

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
    textComponent.textRenderer = regular!;
    textComponent.anchor = Anchor.bottomCenter;

    // ...

    // Position the image in the center
    imageComponent.anchor = Anchor.center;
    imageComponent.position = size / 2;
    add(imageComponent);
    add(textComponent);
  }

  void _changeSlide() {
    currentSlideIndex = currentSlideIndex + 1;

    if (currentSlideIndex == 3) {
      onGameFinished();
    }
    imageComponent.removeFromParent();
    textComponent.removeFromParent();

    _loadSlide();
  }

  static final _cameraViewport = Vector2(592, 1024);

  final GameBloc gameBloc;
  final AssetBundle? customBundle;
  final AudioController audioController;
}
