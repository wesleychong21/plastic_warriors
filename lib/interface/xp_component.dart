import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:flutter/material.dart';

class XPComponent extends InterfaceComponent {
  double padding = 25;
  double widthBar = 120;
  double strokeWidth = 18;

  int coins = 0;
  int xp = 0;
  Ari _ari;

  XPComponent(Ari ari)
      : _ari = ari,
        super(
          id: 2,
          position: Vector2(220, 20),
          size: Vector2(160, 41),
        );

  @override
  void update(double t) {
    if (this.gameRef.player != null) {
      coins = _ari.coins;
      xp = _ari.xp;
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      // display coins amount
      _drawCoins(c);
    } catch (e) {}
    super.render(c);
  }

//_drawCoins(c)
  void _drawCoins(Canvas canvas) {
    final textSpan = TextSpan(
      text: 'Coins: $coins',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final offset = Offset(20, 30);
    textPainter.paint(canvas, offset);
  }
}
