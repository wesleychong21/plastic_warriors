import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:plastic_warriors/util/game_sprite_sheet.dart';

class Spikes extends GameDecoration with Sensor<Ari> {
  final double damage;
  Ari? player;

  Spikes(Vector2 position, {this.damage = 0})
      : super.withAnimation(
          animation: GameSpriteSheet.spikes(),
          position: position,
          size: Vector2(tileSize, tileSize),
        );

  @override
  void onContact(Ari collision) {
    player = collision;
  }

  @override
  void update(double dt) {
    if (isAnimationLastFrame) {
      player?.receiveDamage(AttackFromEnum.ENEMY, damage, 0);
    }
    super.update(dt);
  }

  @override
  int get priority => LayerPriority.getComponentPriority(1);

  @override
  void onContactExit(Ari component) {
    player = null;
  }
}
