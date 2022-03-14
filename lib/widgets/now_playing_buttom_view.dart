import 'package:auto_size_text/auto_size_text.dart';
import 'package:bts_offline_music_2021/bloc/player_bloc.dart';
import 'package:bts_offline_music_2021/providers.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:bts_offline_music_2021/widgets/play_pause_icon_view.dart';
import 'package:bts_offline_music_2021/widgets/song_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';


class NowPlayingBottomPanelWidget extends ConsumerWidget {
  const NowPlayingBottomPanelWidget({
    Key? key,
    this.imageUrl,
    this.icon,
    required this.songTitle,
    required this.singer,
  }) : super(key: key);

  final String? imageUrl;
  final Widget? icon;
  final String songTitle;
  final String singer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.read(playerBlocProvider);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: Color(0xFFFDB0A8),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.white,
            offset: Offset(0, 3),
            spreadRadius: MARGIN_10,
          )
        ],
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            MARGIN_MEDIUM_2, 0, MARGIN_MEDIUM_2, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(MARGIN_6),
              child: Image(
                image: AssetImage(imageUrl ?? ""),
                fit: BoxFit.cover,
                height: MARGIN_56.h,
                width: MARGIN_56.w,
              ),
            ),
            SongInfosView(
              songName: songTitle,
              singer: singer,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<SequenceState?>(
                    stream: bloc.player.sequenceStateStream,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          bloc.player.hasPrevious
                              ? bloc.player.seekToPrevious()
                              : bloc.player.seek(Duration.zero,index: ((snapshot.data?.effectiveSequence.length)! - 1));
                        },
                        child: Icon(
                          Icons.skip_previous,
                          color: Colors.black,
                          size: MARGIN_30,
                        ),
                      );
                    }),
                StreamBuilder<PlayerState>(
                    stream: bloc.player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;

                      return PlayPauseIconView(
                        processingState: processingState,
                        playing: playing ?? false,
                        onPlay: () {
                          bloc.player.play();
                        },
                        onPause: (){
                          bloc.player.pause();
                        },
                        onRePlay: (){
                          bloc.player.seek(Duration.zero, index: bloc.player.effectiveIndices!.first);
                        },
                      );
                    }),
                StreamBuilder<SequenceState?>(
                    stream: bloc.player.sequenceStateStream,
                    builder: (context, snapshot) {
                      return Visibility(
                        visible: bloc.player.hasNext,
                        child: GestureDetector(
                          onTap: () {
                            bloc.player.hasNext
                                ? bloc.player.seekToNext()
                                : () {};
                          },
                          child: Icon(
                            Icons.skip_next,
                            color: Colors.black,
                            size: MARGIN_30,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
