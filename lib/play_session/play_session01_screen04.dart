import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:plastic_warriors/util/sounds.dart';
import 'package:plastic_warriors/play_session/play_session01_screen02.dart';

class play_session01_screen04 extends StatefulWidget {
  const play_session01_screen04({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<play_session01_screen04> {
  int currentSlide = 0;
  final List<String> slideImages = [
    'assets/images/scene1_image1.png',
    'assets/images/scene1_image2.png',
    'assets/images/scene1_image3.png',
    'assets/images/scene1_image4.png',
    'assets/images/scene1_image5.png',
  ];
  final List<String> slideTexts = [
    'Slide 1 Slide 1 Slide 1 Slide 1 Slide 1 Slide 1',
    'Slide 2',
    'Slide 3',
    'Slide 4',
    'Slide 5',
  ];

  @override
  void initState() {
    Sounds.playScene1Sound();
    super.initState();
  }

  void goToNextSlide() {
    setState(() {
      currentSlide = (currentSlide + 1) % slideImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Define what happens when the screen is tapped
        // For example, you can change the slide when the screen is tapped
        setState(() {
          currentSlide = (currentSlide + 1) % slideImages.length;
        });

        if (currentSlide == 4) {
          Sounds.stopBackgroundSound();
          // go to play_session01_screen02.dart

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Play_Session01_Screen02(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    slideImages[currentSlide],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  slideTexts[currentSlide],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
