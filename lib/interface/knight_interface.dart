import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/interface/bar_life_component.dart';
import 'package:plastic_warriors/player/ari.dart';

class KnightInterface extends GameInterface {
  late Sprite key;

  @override
  Future<void> onLoad() async {
    key = await Sprite.load('items/key_silver.png');
    add(MyBarLifeComponent());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawKey(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Ari).containKey) {
      key.renderRect(c, Rect.fromLTWH(150, 20, 35, 30));
    }
  }
}
