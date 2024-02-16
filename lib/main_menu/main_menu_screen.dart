import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio.dart';
import '../settings/settings.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    final screenSize = MediaQuery.of(context).size; // Get the screen size

    return Scaffold(
        backgroundColor: palette.backgroundMain,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/splash-screen-bg.jpg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 540.0, // Max width
                maxHeight: 960.0, // Max height
              ),
              child: ResponsiveScreen(
                squarishMainArea: Center(
                  child: Transform.rotate(
                    angle: -0.1,
                  ),
                ),
                rectangularMenuArea: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                      onPressed: () {
                        audioController.playSfx(Sfx.buttonTap);
                        GoRouter.of(context).go('/game');
                      },
                      child: const Text('Play'),
                    ),
                    _gap,
                    MyButton(
                      onPressed: () => GoRouter.of(context).push('/settings'),
                      child: const Text('Settings'),
                    ),
                    _gap,
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  static const _gap = SizedBox(height: 10);
}
