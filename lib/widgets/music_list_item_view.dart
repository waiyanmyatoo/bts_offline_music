import 'package:auto_size_text/auto_size_text.dart';
import 'package:bts_offline_music_2021/utils/AppTheme.dart';
import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:bts_offline_music_2021/utils/duration.dart';
import 'package:bts_offline_music_2021/utils/music_title.dart';
import 'package:bts_offline_music_2021/utils/utils.dart';
import 'package:bts_offline_music_2021/widgets/song_title_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class MusicListItemWidget extends StatelessWidget {
  const MusicListItemWidget({
    Key? key,
    this.imageUrl,
    this.icon,
    this.ontap,
    this.title,
    this.singer,
    this.onTapPlay,
    this.isPlaying = false,
    this.duration,
  }) : super(key: key);

  final String? imageUrl;
  final IconData? icon;
  final Function? ontap;
  final Function? onTapPlay;
  final String? title;
  final String? singer;
  final bool? isPlaying;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        ontap!();
      },
      child: Container(
        margin: EdgeInsets.only(top: MARGIN_10, bottom: MARGIN_SMALL),
        // height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: (isPlaying ?? false) ? secondaryWhiteColor : primaryColor,
          // boxShadow: (isPlaying ?? false)
          //     ? [
          //         BoxShadow(
          //           blurRadius: 9,
          //           color: Colors.white,
          //           offset: Offset(3, 0),
          //           spreadRadius: 1,
          //         ),
          //         BoxShadow(
          //           blurRadius: 9,
          //           color: secondaryBlackColor,
          //           offset: Offset(0, 1),
          //           spreadRadius: 0,
          //         )
          //       ]
          //     : [],
          borderRadius: BorderRadius.circular(MARGIN_6),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(MARGIN_6),
              child: Image(
                image: AssetImage(imageUrl ?? "assets/images/black_swan.jpg"),
                fit: BoxFit.cover,
                height: MARGIN_56.h,
                width: MARGIN_56.w,
              ),
            ),
            SongInfosView(
              songName: title,
              singer: singer,
              isPlayig: isPlaying,
            ),
            Visibility(
              visible: isPlaying ?? false,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  // color: Colors.green,
                  width: MARGIN_80,
                  height: MARGIN_60,
                  child: Lottie.network(
                    "https://assets9.lottiefiles.com/packages/lf20_YEZz8Y.json",
                    fit: BoxFit.contain,
                    animate: isPlaying,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            // Container(
            //   child: Text(
            //     parseDuration(duration?.inMilliseconds
            //                     .toDouble() ??
            //                 0.0),
            //     style: AppTheme.getTextStyle(
            //       themeData.textTheme.bodyText1,
            //       fontWeight: 600,
            //       letterSpacing: 0.2,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
