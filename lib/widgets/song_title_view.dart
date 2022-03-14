import 'package:auto_size_text/auto_size_text.dart';
import 'package:bts_offline_music_2021/utils/AppTheme.dart';
import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongInfosView extends StatelessWidget {
  const SongInfosView({
    Key? key,
    this.songName,
    this.singer,
    this.isPlayig = false,
  }) : super(key: key);

  final String? songName;
  final String? singer;
  final bool? isPlayig;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: MARGIN_CARD_MEDIUM_2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 0.6.sw,
              height: 20.h,
           
              child: (isPlayig ?? false)
                  ? Marquee(
                      text: songName ?? '-',
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.subtitle2,
                        fontWeight: 600,
                        letterSpacing: 0.2,
                      ),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: MARGIN_50,
                      velocity: MARGIN_75,
                      pauseAfterRound: Duration(seconds: 1),
                      startPadding: 0.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    )
                  : Text(
                      songName ?? '-',
                      style: AppTheme.getTextStyle(
                        themeData.textTheme.subtitle2,
                        fontWeight: 600,
                        letterSpacing: 0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            Text(
              singer ?? "-",
              style: themeData.textTheme.caption!.merge(
                TextStyle(color: secondaryBlackColor, letterSpacing: 0.10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
