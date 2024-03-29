import 'dart:developer' as dev;
import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:leaderboard_repository/leaderboard_repository.dart';
import 'package:plastic_warriors/settings/persistence/local_storage_settings_persistence.dart';
import 'package:plastic_warriors/settings/settings.dart';
import 'package:plastic_warriors/share/share.dart';
import 'package:plastic_warriors/bootstrap.dart';
import 'package:plastic_warriors/app/app.dart';
import 'package:plastic_warriors/utils/sounds.dart';
import 'package:plastic_warriors/utils/localization/my_localizations.dart';
import 'package:plastic_warriors/utils/localization/my_localizations_delegate.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:flame/flame.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio.dart';
import 'player_progress/player_progress.dart';
import 'settings/settings.dart';
import 'style/palette.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plastic_warriors/utils/localization/strings_location.dart';
import 'package:plastic_warriors/firebase_options.dart';
import 'package:plastic_warriors/settings/settings_controller.dart';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

double tileSize = 32;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// web app
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCLuPm-MVv7WdWFsiMNFULq3yavhwjl8M4',
        appId: '1:931860057674:web:f1527b5801417b309f20b3',
        messagingSenderId: '931860057674',
        projectId: 'plastic-warriors-862da',
        authDomain: 'plastic-warriors-862da.firebaseapp.com',
        storageBucket: 'plastic-warriors-862da.appspot.com',
        measurementId: 'G-N6LTCNFDN3',
      ),
    );
  } else {
    // mobile app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  final settings = SettingsController(
    persistence: LocalStorageSettingsPersistence(),
  );

  final audio = AudioController()..attachSettings(settings);

  await audio.initialize();

  final share = ShareController(
    gameUrl: 'flutt/',
  );

  final leaderboardRepository = LeaderboardRepository(
    FirebaseFirestore.instance,
  );

  unawaited(
    bootstrap(
      (firebaseAuth) async {
        final authenticationRepository = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
        );

        return App(
          audioController: audio,
          settingsController: settings,
          shareController: share,
          authenticationRepository: authenticationRepository,
          leaderboardRepository: leaderboardRepository,
        );
      },
    ),
  );
}
