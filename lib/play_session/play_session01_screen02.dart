import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/decoration/door.dart';
import 'package:plastic_warriors/decoration/key.dart';
import 'package:plastic_warriors/decoration/potion_life.dart';
import 'package:plastic_warriors/decoration/spikes.dart';
import 'package:plastic_warriors/decoration/torch.dart';
import 'package:plastic_warriors/enemies/boss.dart';
import 'package:plastic_warriors/enemies/goblin.dart';
import 'package:plastic_warriors/enemies/imp.dart';
import 'package:plastic_warriors/enemies/mini_boss.dart';
import 'package:plastic_warriors/interface/knight_interface.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/npc/kid.dart';
import 'package:plastic_warriors/npc/wizard_npc.dart';
import 'package:plastic_warriors/player/knight.dart';
import 'package:plastic_warriors/util/sounds.dart';
import 'package:plastic_warriors/widgets/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Play_Session01_Screen02 extends StatefulWidget {
  //static bool useJoystick = true;
  const Play_Session01_Screen02({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Play_Session01_Screen02> {
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
      actions: [
        JoystickAction(
          actionId: 0,
          sprite: Sprite.load('joystick_atack.png'),
          spritePressed: Sprite.load('joystick_atack_selected.png'),
          size: 80,
          margin: EdgeInsets.only(bottom: 50, right: 50),
        ),
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('joystick_atack_range.png'),
          spritePressed: Sprite.load('joystick_atack_range_selected.png'),
          size: 50,
          margin: EdgeInsets.only(bottom: 50, right: 160),
        )
      ],
    );

    return Material(
      color: Colors.transparent,
      child: BonfireWidget(
        joystick: joystick,
        player: Knight(
          Vector2(2 * tileSize, 3 * tileSize),
        ),
        map: WorldMapByTiled(
          TiledReader.asset('tiled/map.json'),
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'door': (p) => Door(p.position, p.size),
            'torch': (p) => Torch(p.position),
            'potion': (p) => PotionLife(p.position, 30),
            'wizard': (p) => WizardNPC(p.position),
            'spikes': (p) => Spikes(p.position),
            'key': (p) => DoorKey(p.position),
            'kid': (p) => Kid(p.position),
            'boss': (p) => Boss(p.position),
            'goblin': (p) => Goblin(p.position),
            'imp': (p) => Imp(p.position),
            'mini_boss': (p) => MiniBoss(p.position),
            'torch_empty': (p) => Torch(p.position, empty: true),
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