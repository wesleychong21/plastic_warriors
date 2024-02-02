import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/decoration/door.dart';
import 'package:plastic_warriors/decoration/key.dart';
import 'package:plastic_warriors/decoration/potion_life.dart';
import 'package:plastic_warriors/decoration/spikes.dart';
import 'package:plastic_warriors/decoration/torch.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/boss.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/imp.dart';
import 'package:plastic_warriors/enemies/mini_boss.dart';
import 'package:plastic_warriors/interface/knight_interface.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/npc/kid.dart';
import 'package:plastic_warriors/npc/scientist_npc.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:plastic_warriors/util/sounds.dart';
import 'package:plastic_warriors/widgets/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Play_Session01_Screen01 extends StatefulWidget {
  //static bool useJoystick = true;
  const Play_Session01_Screen01({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Play_Session01_Screen01> {
  @override
  void initState() {
    Sounds.playScene1Sound();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var joystick = Joystick(
      keyboardConfig: KeyboardConfig(
        directionalKeys: KeyboardDirectionalKeys.arrows(),
        acceptedKeys: [
          LogicalKeyboardKey.space,
          LogicalKeyboardKey.keyZ,
        ],
      ),
      directional: JoystickDirectional(
        spriteBackgroundDirectional: Sprite.load('joystick_background.png'),
        spriteKnobDirectional: Sprite.load('joystick_knob.png'),
        size: 100,
        isFixed: false,
      ),
    );

    return Material(
      color: Colors.transparent,
      child: BonfireWidget(
        joystick: joystick,
        player: Ari(
          Vector2(2 * tileSize, 3 * tileSize),
        ),
        map: WorldMapByTiled(
          TiledReader.asset('tiled/map001b.json'),
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'scientist': (p) => ScientistNPC(p.position),
            'boss': (p) => Boss(p.position),
            'bagMonster': (p) => BagMonster(p.position),
            'imp': (p) => Imp(p.position),
          },
        ),
        components: [GameController()],
        interface: KnightInterface(),
        lightingColorGame: Colors.black.withOpacity(0.6),
        backgroundColor: Colors.grey[900]!,
        cameraConfig: CameraConfig(
          speed: 3,
          zoom: getZoomFromMaxVisibleTile(context, tileSize, 18),
        ),
      ),
    );
  }
}
