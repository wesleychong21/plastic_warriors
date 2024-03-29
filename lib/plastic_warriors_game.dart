import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/decoration/door.dart';
import 'package:plastic_warriors/decoration/key.dart';
import 'package:plastic_warriors/decoration/potion_life.dart';
import 'package:plastic_warriors/decoration/spikes.dart';
import 'package:plastic_warriors/decoration/torch.dart';
import 'package:plastic_warriors/enemies/boss.dart';
import 'package:plastic_warriors/enemies/bag_monster.dart';
import 'package:plastic_warriors/enemies/imp.dart';
import 'package:plastic_warriors/enemies/mini_boss.dart';
import 'package:plastic_warriors/interface/ari_interface.dart';
import 'package:plastic_warriors/main.dart';
import 'package:plastic_warriors/npc/kid.dart';
import 'package:plastic_warriors/npc/scientist_npc.dart';
import 'package:plastic_warriors/player/ari.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:plastic_warriors/widgets/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plastic_warriors/play_session/play_session01_screen01.dart';

class PlasticWarriorsGame extends StatefulWidget {
  //static bool useJoystick = true;
  const PlasticWarriorsGame({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<PlasticWarriorsGame> {
  @override
  Widget build(BuildContext context) {
    return Play_Session01_Screen01();
  }
}
