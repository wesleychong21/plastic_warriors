import 'dart:async' as async;
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:plastic_warriors/game.dart';
import 'package:plastic_warriors/settings/settings_screen.dart';
import 'package:plastic_warriors/util/custom_sprite_animation_widget.dart';
import 'package:plastic_warriors/util/enemy_sprite_sheet.dart';
import 'package:plastic_warriors/util/localization/strings_location.dart';
import 'package:plastic_warriors/util/player_sprite_sheet.dart';
import 'package:plastic_warriors/util/sounds.dart';
import 'package:plastic_warriors/widgets/custom_radio.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;
  int currentPosition = 0;
  late async.Timer _timer;

  List<Future<SpriteAnimation>> sprites = [
    PlayerSpriteSheet.idleRight(),
    EnemySpriteSheet.goblinIdleRight(),
    EnemySpriteSheet.impIdleRight(),
    EnemySpriteSheet.miniBossIdleRight(),
    EnemySpriteSheet.bossIdleRight(),
  ];

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/splash-screen-bg.jpg"), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Plastic Warriors",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (sprites.isNotEmpty)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CustomSpriteAnimationWidget(
                    animation: sprites[currentPosition],
                  ),
                ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  child: Text(
                    getString('play_cap'),
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Normal',
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Game()),
                    );
                  },
                ),
              ),
              _gap,
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  child: Text(
                    getString('settings_cap'),
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Normal',
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 20,
          margin: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Made with ❤️ by Malaysia",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 15.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        setState(() {
          showSplash = false;
        });
        startTimer();
      },
    );
  }

  void startTimer() {
    _timer = async.Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentPosition++;
        if (currentPosition > sprites.length - 1) {
          currentPosition = 0;
        }
      });
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static const _gap = SizedBox(height: 10);
}
