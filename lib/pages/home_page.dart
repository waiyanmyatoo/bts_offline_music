import 'dart:io';

import 'package:bts_offline_music_2021/bloc/player_bloc.dart';
import 'package:bts_offline_music_2021/env.dart';
import 'package:bts_offline_music_2021/main.dart';
import 'package:bts_offline_music_2021/pages/now_playing_page.dart';
import 'package:bts_offline_music_2021/providers.dart';
import 'package:bts_offline_music_2021/utils/AppTheme.dart';
import 'package:bts_offline_music_2021/utils/colors.dart';
import 'package:bts_offline_music_2021/utils/dimens.dart';
import 'package:bts_offline_music_2021/widgets/music_list_item_view.dart';
import 'package:bts_offline_music_2021/widgets/now_playing_buttom_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageWidget extends ConsumerStatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends ConsumerState<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // late BannerAd _banner;

  // bool _isBannerAdReady = false;

  final RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    googlePlayIdentifier: "com.twenty2ages.bts_offline_songs",
    remindDays: 2,
    remindLaunches: 5,
  );

  @override
  void initState() {
    super.initState();
    initialization();
    // createBannerAd();
    _rateMyApp.init().then((_) {
      // TODO: Comment out this if statement to test rating dialog (Remember to uncomment)
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showRateDialog(
          context,
          title: 'Rate this app',
          // The dialog title.
          message:
              'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
          // The dialog message.
          rateButton: 'RATE',
          // The dialog "rate" button text.
          noButton: 'NO THANKS',
          // The dialog "no" button text.
          laterButton: 'MAYBE LATER',
          barrierDismissible: false,
          // The dialog "later" button text.
          listener: (button) {
            // The button click listener (useful if you want to cancel the click event).
            switch (button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          ignoreNativeDialog: Platform.isAndroid,
          // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: const DialogStyle(),
          // Custom dialog styles.
          onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );
      }
    });
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3))
        .then((value) => FlutterNativeSplash.remove());
    print('splash screen removed');
  }

  // void createBannerAd() {
  //   _banner = BannerAd(
  //     adUnitId: Secret.banner_ad_units,
  //     size: AdSize.banner,
  //     request: AdRequest(),
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (Ad ad) {
  //         setState(() {
  //           _isBannerAdReady = true;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         _isBannerAdReady = false;
  //         ad.dispose();
  //       },
  //       // Called when an ad opens an overlay that covers the screen.
  //       // ignore: avoid_print
  //       onAdOpened: (Ad ad) {
  //         print('${ad.runtimeType} opened.');
  //       },
  //       // Called when an ad removes an overlay that covers the screen.
  //       onAdClosed: (Ad ad) {
  //         print('${ad.runtimeType} closed');
  //         ad.dispose();
  //         createBannerAd();
  //         print('${ad.runtimeType} reloaded');
  //       },
  //       // Called when an ad is in the process of leaving the application.
  //       onAdWillDismissScreen: (Ad ad) => print('Left application.'),
  //     ),
  //   )..load();
  // }

  @override
  void dispose() {
    // _banner.dispose();
    super.dispose();
  }

  void showSnack(String text) {
    if (scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // InAppUpdate.checkForUpdate()
    //     .then(
    //   (value) => InAppUpdate.performImmediateUpdate().catchError(
    //     (e) {
    //       print(e.toString());
    //     },
    //   ),
    // )
    //     .catchError(
    //   (err) {
    //     print(err.toString());
    //   },
    // );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final player = ref.read(playerBlocProvider).player;

              return Stack(
                children: [
                  Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.topCenter,
                      //   child: _isBannerAdReady
                      //       ?  SizedBox(
                      //           height: 50,
                      //           child: AdWidget(
                      //             ad: _banner,
                      //           ),
                      //         ) : const SizedBox.shrink(),
                      // ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            top: MARGIN_MEDIUM_2,
                            bottom: MARGIN_SMALL,
                            left: MARGIN_MEDIUM_2),
                        child: Text(
                          "All Tracks",
                          style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            fontWeight: 700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.all(
                                    MARGIN_MEDIUM_2,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StreamBuilder<SequenceState?>(
                                          stream: player.sequenceStateStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final state = snapshot.data;
                                              final sequence =
                                                  state?.sequence ?? [];
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: sequence.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final metadata =
                                                      sequence[index].tag
                                                          as MediaItem;
                                                  return StreamBuilder<bool>(
                                                    stream:
                                                        player.playingStream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return MusicListItemWidget(
                                                        imageUrl: metadata
                                                            .extras!["imgurl"]
                                                            ?.toString(),
                                                        title: metadata.title,
                                                        singer: metadata.artist,
                                                        duration:
                                                            player.duration,
                                                        isPlaying:
                                                            (player.currentIndex ==
                                                                    index) &&
                                                                (snapshot
                                                                        .data ??
                                                                    false),
                                                        icon: (player.currentIndex ==
                                                                    index) &&
                                                                (snapshot
                                                                        .data ??
                                                                    false)
                                                            ? Icons.pause
                                                            : Icons
                                                                .play_circle_fill,
                                                        ontap: () {
                                                          player.seek(
                                                            Duration.zero,
                                                            index: index,
                                                          );
                                                          player.play();
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_80.h,
                      )
                    ],
                  ),
                  Miniplayer(
                    minHeight: MARGIN_70,
                    maxHeight: MediaQuery.of(context).size.height,
                    backgroundColor: Colors.transparent,
                    builder: (height, percentage) {
                      if (height > MARGIN_70) {
                        // ref.read(mainBlocProvider).showAdsAfter24hrs();
                        return const NowPlayingPage();
                      } else {
                        return StreamBuilder<SequenceState?>(
                          stream: player.sequenceStateStream,
                          builder: (context, snapshot) {
                            final state = snapshot.data;
                            if (state?.sequence.isEmpty ?? true) {
                              return const SizedBox();
                            }
                            final metadata =
                                state!.currentSource!.tag as MediaItem;
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MARGIN_70,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE7B2AF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFE7F4FD),
                                  )
                                ],
                              ),
                              child: NowPlayingBottomPanelWidget(
                                imageUrl: metadata.extras!["imgurl"].toString(),
                                songTitle: metadata.title,
                                singer: metadata.artist ?? "-",
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: 70,
      //   decoration: BoxDecoration(
      //     color: Color(0xFFE7B2AF),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Color(0xFFE7F4FD),
      //       )
      //     ],
      //   ),
      //   child: NowPlayingBottomPanelWidget(
      //     imageUrl:
      //         'https://i.pinimg.com/564x/6b/01/4e/6b014e4e4185fa83c4591de0e01b672e.jpg',
      //   ),
      // ),
    );
  }
}
