

import 'package:bts_offline_music_2021/bloc/main_bloc.dart';
import 'package:bts_offline_music_2021/bloc/player_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final mainBlocProvider = ChangeNotifierProvider<MainBloc>((_) {
  return MainBloc();
});

final playerBlocProvider = ChangeNotifierProvider<PlayerBloc>((ref) {
  return PlayerBloc();
});

final audioPlayerProvider = StreamProvider.autoDispose<AudioPlayer>((ref) async* {
  final player = ref.watch(playerBlocProvider.select((value) => value.player));
  yield player;
});

// final bannerProvider = FutureProvider.autoDispose<BannerAd>((ref) async {
//   final banner = ref.watch(mainBlocProvider.select((value) => value.banner));

//   return Future.value(banner);
// });