import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/decoration/door.dart';
import 'package:plastic_warriors/decoration/key.dart';
import 'package:plastic_warriors/decoration/potion_life.dart';
import 'package:plastic_warriors/decoration/spikes.dart';
import 'package:plastic_warriors/decoration/torch.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/boss.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/greedy_stone.dart';
import 'package:plastic_warriors/enemies/imp.dart';
import 'package:plastic_warriors/enemies/mini_boss.dart';
import 'package:plastic_warriors/interface/ari_interface.dart';
import 'package:plastic_warriors/main.dart';

import 'package:plastic_warriors/player/ari.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:plastic_warriors/widgets/game_controller.dart';
import 'package:plastic_warriors/widgets/scene1_controller.dart';
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
          Vector2(3 * tileSize, 5 * tileSize),
        ),
        map: WorldMapByTiled(
          TiledReader.asset('tiled/map001b.json'),
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'boss': (p) => Boss(p.position),
            'bagMonster': (p) => BagMonster(p.position),
            'imp': (p) => Imp(p.position),
            'greedyStone': (p) => Greedy_Stone(p.position),
          },
        ),
        components: [GameController(), Scene1Controller()],
        interface: AriInterface(),
        backgroundColor: Colors.grey[900]!,
        cameraConfig: CameraConfig(
          speed: 3,
          zoom: getZoomFromMaxVisibleTile(context, tileSize, 18),
        ),
      ),
    );
  }
}
