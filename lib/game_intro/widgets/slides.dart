import 'package:flutter/material.dart';
import 'package:plastic_warriors/game/game.dart';

class SlidesWidget extends StatefulWidget {
  @override
  _SlidesWidgetState createState() => _SlidesWidgetState();
}

class _SlidesWidgetState extends State<SlidesWidget> {
  late PageController _pageController;
  int _currentIndex = 0;
  final List<String> _imagePaths = [
    'assets/images/Scene01_01.webp',
    'assets/images/Scene01_02.webp',
    'assets/images/Scene01_03.webp',
    'assets/images/Scene01_04.webp',
  ];
  final List<String> _slideTexts = [
    '"In a peaceful fishing village, the setting sun casts its glow over the azure sea..."​',
    '"Ari, a lively 12-year-old boy, standing on the shore, eyes following the flight of seagulls..."',
    '"Suddenly, the sea begins to churn unusually..."​',
    '"The boy notices strange objects emerging in the water..."​',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextSlide() {
    setState(() {
      if (_currentIndex < _imagePaths.length - 1) {
        _currentIndex++;
      } else {
        // Navigate to another page when slides are complete
        // go to BattleGameView
        // Navigator.pushReplacementNamed(context, '/battle_game_view');
        Navigator.of(context).push(BattleGameView.route());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _nextSlide,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  _imagePaths[_currentIndex],
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Text(
                    _slideTexts[_currentIndex],
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
