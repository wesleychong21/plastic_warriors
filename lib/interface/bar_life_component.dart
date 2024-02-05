import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:flutter/material.dart';

class MyBarLifeComponent extends InterfaceComponent {
  double padding = 25;
  double widthBar = 120;
  double strokeWidth = 16;

  double maxLife = 0;
  double life = 0;

  MyBarLifeComponent()
      : super(
          id: 1,
          position: Vector2(20, 20),
          spriteUnselected: Sprite.load('health_ui.png'),
          size: Vector2(160, 41),
        );

  @override
  void update(double t) {
    if (this.gameRef.player != null) {
      life = this.gameRef.player!.life;
      maxLife = this.gameRef.player!.maxLife;
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      _drawLife(c);
    } catch (e) {}
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 31;
    double yBar = 15;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
