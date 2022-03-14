import 'package:bts_offline_music_2021/common.dart';
import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      // color: Colors.red,
      // width: 0.8.sw,

      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<LoopMode>(
            stream: player.loopModeStream,
            builder: (context, snapshot) {
              final loopMode = snapshot.data ?? LoopMode.off;
              var icons = [
                Icon(Icons.repeat, color: themeData.colorScheme.onBackground),
                Icon(Icons.repeat, color: Color(0xFFFDB0A8)),
                Icon(Icons.repeat_one, color: Color(0xFFFDB0A8)),
              ];
              const cycleModes = [
                LoopMode.off,
                LoopMode.all,
                LoopMode.one,
              ];
              final index = cycleModes.indexOf(loopMode);

              return InkWell(
                onTap: () {
                  player.setLoopMode(cycleModes[
                      (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
                },
                child: Icon(
                  icons[index].icon,
                  color: icons[index].color,
                ),
              );
            },
          ),
          StreamBuilder<SequenceState?>(
            stream: player.sequenceStateStream,
            builder: (context, snapshot) {
              return ControllerIcon(
                iconData: Icons.skip_previous,
                iconColor: lightPinkColor,
                size: MARGIN_30.r,
                onpress: () {
                  player.hasPrevious
                      ? player.seekToPrevious()
                      : player.seek(Duration.zero,
                          index:
                              ((snapshot.data?.effectiveSequence.length)! - 1));
                },
              );
            },
          ),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;

              return Container(
                decoration: BoxDecoration(
                  color: secondaryWhiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: lightPinkColor,
                      offset: Offset(0, 0),
                      spreadRadius: 1,
                    )
                  ],
                ),
                height: MARGIN_56.h,
                width: MARGIN_56.w,
                child: Center(
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: getPlayerIcon(processingState, playing: playing),
                  ),
                ),
              );
            },
          ),
          StreamBuilder<SequenceState?>(
            stream: player.sequenceStateStream,
            builder: (context, snapshot) {
              return Visibility(
                visible: player.hasNext,
                replacement: SizedBox(
                  height: MARGIN_30.h,
                  width: MARGIN_30.w,
                ),
                child: ControllerIcon(
                  iconData: Icons.skip_next,
                  iconColor: lightPinkColor,
                  size: MARGIN_30.r,
                  onpress: () {
                    player.hasNext ? player.seekToNext() : (){};
                  },
                ),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: player.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              final shuffleModeEnabled = snapshot.data ?? false;
              return InkWell(
                onTap: () async {
                  final enable = !shuffleModeEnabled;
                  if (enable) {
                    await player.shuffle();
                  }
                  await player.setShuffleModeEnabled(enable);
                },
                child: Icon(
                  shuffleModeEnabled ? Icons.shuffle : Icons.shuffle,
                  color: shuffleModeEnabled
                      ? Color(0xFFFDB0A8)
                      : themeData.colorScheme.onBackground,
                ),
              );
            },
          ),
          // StreamBuilder<double>(
          //   stream: player.speedStream,
          //   builder: (context, snapshot) => IconButton(
          //     icon: Text(
          //       "${snapshot.data?.toStringAsFixed(1)}x",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //     onPressed: () {
          //       showSliderDialog(
          //         context: context,
          //         title: "Adjust speed",
          //         divisions: 10,
          //         min: 0.5,
          //         max: 1.5,
          //         stream: player.speedStream,
          //         onChanged: player.setSpeed,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget getPlayerIcon(ProcessingState? processingState,
      {bool? playing = false}) {
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        height: MARGIN_50.h,
        width: MARGIN_50.w,
        margin: const EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
        child: CircularProgressIndicator(
          color: secondaryBlackColor,
        ),
      );
    } else if (playing != true) {
      return ControllerIcon(
        iconData: Icons.play_arrow,
        onpress: () {
          player.play();
        },
        iconColor: lightPinkColor,
        size: MARGIN_40.r,
      );
    } else if (processingState != ProcessingState.completed) {
      return ControllerIcon(
        iconData: Icons.pause,
        onpress: () {
          player.pause();
        },
        size: MARGIN_40.r,
        iconColor: lightPinkColor,
      );
    } else {
      return ControllerIcon(
        iconData: Icons.replay,
        onpress: () {
          player.seek(Duration.zero, index: player.effectiveIndices!.first);
        },
        iconColor: lightPinkColor,
        size: MARGIN_40.r,
      );
    }
  }
}

class ControllerIcon extends StatelessWidget {
  const ControllerIcon({
    Key? key,
    this.iconColor,
    required this.iconData,
    this.onpress,
    this.size,
  }) : super(key: key);

  final Color? iconColor;
  final IconData iconData;
  final Function? onpress;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      iconSize: size ?? MARGIN_60.r,
      onPressed: () {
        onpress!();
      },
      color: iconColor ?? Colors.black,
    );
  }
}
