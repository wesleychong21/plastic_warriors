import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:flutter/material.dart';

class MyBarLifeComponent extends InterfaceComponent {
  double padding = 25;
  double widthBar = 120;
  double strokeWidth = 18;

  double maxLife = 0;
  double life = 0;

  int coins = 0;
  int xp = 0;

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
      coins = (this.gameRef.player as Ari).coins;
      xp = (this.gameRef.player as Ari).xp;
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    try {
      _drawLife(c);
      _drawCoins(c);
      _drawXPs(c);
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

  //_drawCoins(c)
  void _drawCoins(Canvas canvas) {
    final textSpan = TextSpan(
      text: 'Coins: ' + coins.toString(),
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
    final offset = Offset(200, 10);
    textPainter.paint(canvas, offset);
  }

  void _drawXPs(Canvas canvas) {
    final textSpan = TextSpan(
      text: 'XP: ' + xp.toString(),
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
    final offset = Offset(200, 30);
    textPainter.paint(canvas, offset);
  }
}
