import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:bts_offline_music_2021/bloc/main_bloc.dart';
import 'package:bts_offline_music_2021/bloc/player_bloc.dart';
import 'package:bts_offline_music_2021/pages/home_page.dart';
import 'package:bts_offline_music_2021/pages/now_playing_page.dart';
import 'package:bts_offline_music_2021/providers.dart';
import 'package:bts_offline_music_2021/utils/AppTheme.dart';
import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'common.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // MobileAds.instance.initialize();

  await GetStorage.init();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: false,
  );

  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final bloc = ref.watch(mainBlocProvider);
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          home: HomePageWidget(),
        );
      },
    );
  }
}
