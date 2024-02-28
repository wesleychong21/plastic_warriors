import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/interface/bar_life_component.dart';
import 'package:plastic_warriors/interface/xp_component.dart';
import 'package:plastic_warriors/player/ari.dart';

class AriInterface extends GameInterface {
  //late ComponentKey? key;

  @override
  Future<void> onLoad() async {
    //key = await ComponentKey.('items/key_silver.png');
    add(MyBarLifeComponent());

    //add(XPComponent(_ari));

    //WESLEY TODO: add Weapon UI

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
      //key.renderRect(c, Rect.fromLTWH(150, 20, 35, 30));
    }
  }
}
