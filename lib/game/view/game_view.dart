import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plastic_warriors/audio/audio.dart';
import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/game_intro/game_intro.dart';
import 'package:plastic_warriors/game/scenes/scenes.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const Game(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GameWidget.controlled(
            loadingBuilder: (context) => const GameBackground(),
            backgroundBuilder: (context) => const GameBackground(),
            gameFactory: () => Scene01Opening(
              gameBloc: context.read<GameBloc>(),
              audioController: context.read<AudioController>(),
              onGameFinished: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BattleGameView(level: 1)));
              },
            ),
          ),
          const Positioned(
            top: 12,
            child: ScoreLabel(),
          ),
          const Positioned(
            bottom: 12,
            child: SafeArea(child: AudioButton()),
          ),
        ],
      ),
    );
  }
}
