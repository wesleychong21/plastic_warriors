import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plastic_warriors/constants/constants.dart';
import 'package:plastic_warriors/game/view/battle_game_view.dart';
import 'package:plastic_warriors/gen/assets.gen.dart';
import 'package:plastic_warriors/l10n/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GameWinDialog2 extends StatelessWidget {
  const GameWinDialog2({super.key});

  static PageRoute<void> route() {
    return HeroDialogRoute(
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: const GameWinDialog2(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bodyStyle = AppTextStyles.bodyLarge;
    const highlightColor = Color(0xFF9CECCD);
    final linkStyle = AppTextStyles.bodyLarge.copyWith(
      color: highlightColor,
      decoration: TextDecoration.underline,
      decorationColor: highlightColor,
    );
    return AppDialog(
      border: Border.all(color: Colors.white24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  "Congratutions! Please collect your card!",
                  style: bodyStyle,
                ),
                const SizedBox(height: 24),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                  onPressed: () => launchUrlString(Urls.card2Link),
                  icon: Icon(Icons.card_giftcard),
                  label: Text("Get My Card"),
                ),
                const SizedBox(height: 24),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    iconColor: Colors.white,
                  ),
                  onPressed: () => launchUrlString(Urls.howWeBuilt),
                  icon: Icon(Icons.next_plan),
                  label: Text("Know more about the game"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
