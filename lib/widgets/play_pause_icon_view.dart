import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:bts_offline_music_2021/widgets/controllers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayPauseIconView extends StatelessWidget {
   PlayPauseIconView({ Key? key, this.processingState, this.playing = false, this.onPlay, this.onPause, this.onRePlay }) : super(key: key);

  final ProcessingState? processingState;
  final bool playing;
  final Function? onPlay;
  final Function? onPause;
  final Function? onRePlay;

  @override
  Widget build(BuildContext context) {
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return SizedBox.shrink();
    } else if (playing != true) {
      return ControllerIcon(
        iconData: Icons.play_arrow,
        onpress: () {
          onPlay!();
        },
        iconColor: Colors.black,
        size: MARGIN_30,
      );
    } else if (processingState != ProcessingState.completed) {
      return ControllerIcon(
        iconData: Icons.pause,
        onpress: () {
          onPause!();
        },
        size: MARGIN_30,
        iconColor: Colors.black,
      );
    } else {
      return ControllerIcon(
        iconData: Icons.replay,
        onpress: () {
          onRePlay!();
        },
        iconColor: Colors.black,
        size: MARGIN_30,
      );
    }
  }
}