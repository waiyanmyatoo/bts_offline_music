import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:bts_offline_music_2021/common.dart';
import 'package:bts_offline_music_2021/data/vos/playlist_vo.dart';
import 'package:bts_offline_music_2021/persistence/share_preference.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class PlayerBloc extends ChangeNotifier {
  static int _nextMediaId = 0;
  late AudioPlayer player;
  int _addedCount = 0;
  late ConcatenatingAudioSource audioSource;

  StreamController<double?> dragValue = StreamController<double?>.broadcast();

  late PanelController controller;

  bool hideBottomPanel = false;

  int? timeStemp;

  PlayerBloc() {
    player = AudioPlayer();
    controller = PanelController();
    
    _init();
    notifyListeners();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    audioSource = ConcatenatingAudioSource(
        children: btsPlaylist.map((e) {
      return AudioSource.uri(
        e.uri ?? Uri.parse(''),
        tag: e.mediaItem,
      );
    }).toList());

    try {
      await player.setAudioSource(this.audioSource);
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }

    notifyListeners();
  }

  Stream<double?> get getDragValue => dragValue.stream;

  void onFinishSlider() {
    dragValue.add(null);
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

 

  void onChangeBottomPanelView() {
    hideBottomPanel = !hideBottomPanel;
    notifyListeners();
  }

  @override
  void dispose() {
    print("dispose");
    player.stop();
    player.dispose();
    
    super.dispose();
  }


}
