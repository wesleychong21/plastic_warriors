import 'package:app_ui/app_ui.dart';
import 'package:flame/cache.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/widgets.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:plastic_warriors/game/game.dart';
import 'package:plastic_warriors/game_intro/widgets/widgets.dart';
import 'package:plastic_warriors/gen/assets.gen.dart';
import 'package:plastic_warriors/l10n/l10n.dart';
import 'package:plastic_warriors/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:plastic_warriors/game/view/view.dart';

class GameInfoStory1 extends StatelessWidget {
  const GameInfoStory1({
    super.key,
  });

  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => GameInfoStory1(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWithBackground(
      background: const GameBackground(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            //width: 360,
            child: SlidesWidget(),
          ),
        ],
      ),
    );
  }
}
