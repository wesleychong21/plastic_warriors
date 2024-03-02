import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plastic_warriors/constants/constants.dart';
import 'package:plastic_warriors/gen/assets.gen.dart';
import 'package:plastic_warriors/l10n/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GameInfoDialog extends StatelessWidget {
  const GameInfoDialog({super.key});

  static PageRoute<void> route() {
    return HeroDialogRoute(
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: const GameInfoDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bodyStyle = AppTextStyles.bodyLarge;
    const highlightColor = Color.fromARGB(255, 199, 233, 220);
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
          const SizedBox(height: 24),
          Assets.images.gameLogo.image(width: 230),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: bodyStyle,
                    children: [
                      TextSpan(text: l10n.learn),
                      TextSpan(
                        text: l10n.howWeBuiltPlasticWarriors,
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrlString(Urls.howWeBuilt),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Team",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: bodyStyle,
                    children: [
                      TextSpan(
                        text: "Wesley Chong (Game Producer & Lead Developer)",
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrlString(Urls.wesleyLink),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: bodyStyle,
                    children: [
                      TextSpan(
                        text: "Zace Leong Kah Yan (Project Manager)",
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrlString(Urls.kahyanLink),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: bodyStyle,
                    children: [
                      TextSpan(
                        text: "Tan Eng Hao Louis (Developer - Google wallet)",
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrlString(Urls.louistanLink),
                      ),
                    ],
                  ),
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
