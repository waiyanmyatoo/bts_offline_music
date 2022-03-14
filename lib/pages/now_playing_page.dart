import 'dart:ui';
import 'package:bts_offline_music_2021/bloc/player_bloc.dart';
import 'package:bts_offline_music_2021/common.dart';
import 'package:bts_offline_music_2021/pages/home_page.dart';
import 'package:bts_offline_music_2021/providers.dart';
import 'package:bts_offline_music_2021/utils/AppTheme.dart';
import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:bts_offline_music_2021/utils/duration.dart';
import 'package:bts_offline_music_2021/widgets/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.read(playerBlocProvider);
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Now Playing",
          style: AppTheme.getTextStyle(themeData.textTheme.headline6,
              fontWeight: 600),
        ),
        leading: Icon(
          MdiIcons.chevronDown,
          size: MARGIN_30.r,
          color: blackColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<SequenceState?>(
                        stream: bloc.player.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (state?.sequence.isEmpty ?? true)
                            return SizedBox();
                          final metadata =
                              state!.currentSource!.tag as MediaItem;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(MARGIN_10.r)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        metadata.extras!["imgurl"].toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MARGIN_MEDIUM_2.h,
                              ),
                              Container(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        metadata.title.toUpperCase(),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: AppTheme.getTextStyle(
                                          themeData.textTheme.headline6,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      Text(
                                        metadata.artist!,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.getTextStyle(
                                          themeData.textTheme.caption,
                                          fontWeight: 400,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        // color: Colors.red,
                        height: 220,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MARGIN_MEDIUM_2.h,
                            ),
                            StreamBuilder<PositionData>(
                              stream: bloc.positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      parseDuration(positionData
                                              ?.position.inMilliseconds
                                              .toDouble() ??
                                          0.0),
                                      style: AppTheme.getTextStyle(
                                        themeData.textTheme.caption,
                                        fontWeight: 500,
                                      ),
                                    ),
                                    Expanded(
                                      child: SeekBar(
                                        duration: positionData?.duration ??
                                            Duration.zero,
                                        position: positionData?.position ??
                                            Duration.zero,
                                        bufferedPosition:
                                            positionData?.bufferedPosition ??
                                                Duration.zero,
                                        onChangeEnd: (newPosition) {
                                          bloc.player.seek(newPosition);
                                        },
                                      ),
                                    ),
                                    Text(
                                      parseDuration(positionData
                                              ?.duration.inMilliseconds
                                              .toDouble() ??
                                          0.0),
                                      style: AppTheme.getTextStyle(
                                        themeData.textTheme.caption,
                                        fontWeight: 500,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: MARGIN_LARGE.h),
                            ControlButtons(bloc.player),
                            SizedBox(height: MARGIN_CARD_MEDIUM_2.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
