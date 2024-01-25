import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

class Play_Session01_Screen03 extends StatefulWidget {
  const Play_Session01_Screen03({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Play_Session01_Screen03> {
  int currentSlide = 0;
  final List<String> slideImages = [
    'assets/images/scene1_image1.png',
    'assets/images/scene1_image2.png',
    'assets/images/scene1_image3.png',
    'assets/images/scene1_image4.png',
    'assets/images/scene1_image5.png',
  ];
  final List<String> slideTexts = [
    'Slide 1',
    'Slide 2',
    'Slide 3',
    'Slide 4',
    'Slide 5',
  ];

  @override
  void initState() {
    super.initState();
  }

  void goToNextSlide() {
    setState(() {
      currentSlide = (currentSlide + 1) % slideImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
