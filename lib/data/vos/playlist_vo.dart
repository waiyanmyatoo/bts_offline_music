import 'package:bts_offline_music_2021/utils/music_title.dart';
import 'package:bts_offline_music_2021/utils/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class PlaylistVO {
  Uri? uri;
  MediaItem? mediaItem;

  PlaylistVO({this.uri, this.mediaItem});
}

final List<PlaylistVO> btsPlaylist = [
  PlaylistVO(
    uri: Uri.parse(blackSwan.songFile),
    mediaItem: MediaItem(
      id: '1',
      album: "Not Your Business",
      title: "Black Swan",
      artist: "BTS",
      extras: {"imgurl": blackSwan.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(bloodSweat.songFile),
    mediaItem: MediaItem(
      id: '2',
      album: "Science Friday",
      title: "Blood Sweat & Tears",
      artist: "BTS",
      extras: {"imgurl": bloodSweat.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(boyWithLuv.songFile),
    mediaItem: MediaItem(
      id: '3',
      album: "Boy With Luv",
      title: "Boy With Luv",
      artist: "BTS",
      extras: {"imgurl": boyWithLuv.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(butter.songFile),
    mediaItem: MediaItem(
      id: '4',
      album: "Science Friday",
      title: "Butter",
      artist: "BTS",
      extras: {"imgurl": butter.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(dna.songFile),
    mediaItem: MediaItem(
      id: '5',
      album: "Science Friday",
      title: "DNA",
      artist: "BTS",
      extras: {"imgurl": dna.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(dope.songFile),
    mediaItem: MediaItem(
      id: '6',
      album: "Science Friday",
      title: "Dope",
      artist: "BTS",
      extras: {"imgurl": dope.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(dynamite.songFile),
    mediaItem: MediaItem(
      id: '7',
      album: "Science Friday",
      title: "Dynamite",
      artist: "BTS",
      extras: {"imgurl": dynamite.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(fake_love.songFile),
    mediaItem: MediaItem(
      id: '8',
      album: "Science Friday",
      title: "Fake Love",
      artist: "BTS",
      extras: {"imgurl": fake_love.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(fire.songFile),
    mediaItem: MediaItem(
      id: '9',
      album: "Science Friday",
      title: "Fire",
      artist: "BTS",
      extras: {"imgurl": fire.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(i_need_u.songFile),
    mediaItem: MediaItem(
      id: '10',
      album: "Science Friday",
      title: "I Need U",
      artist: "BTS",
      extras: {"imgurl": i_need_u.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(idol.songFile),
    mediaItem: MediaItem(
      id: '11',
      album: "Science Friday",
      title: "Idol",
      artist: "BTS",
      extras: {"imgurl": idol.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(life_goes_on.songFile),
    mediaItem: MediaItem(
      id: '12',
      album: "Science Friday",
      title: "Life Goes On",
      artist: "BTS",
      extras: {"imgurl": life_goes_on.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(mic_drop.songFile),
    mediaItem: MediaItem(
      id: '13',
      album: "Science Friday",
      title: "MIC Drop",
      artist: "BTS",
      extras: {"imgurl": mic_drop.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(my_universe.songFile),
    mediaItem: MediaItem(
      id: '14',
      album: "Science Friday",
      title: "My Universe",
      artist: "BTS",
      extras: {"imgurl": my_universe.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(no_more_dream.songFile),
    mediaItem: MediaItem(
      id: '15',
      album: "Science Friday",
      title: "No More Dream",
      artist: "BTS",
      extras: {"imgurl": no_more_dream.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(not_today.songFile),
    mediaItem: MediaItem(
      id: '16',
      album: "Science Friday",
      title: "Not Today",
      artist: "BTS",
      extras: {"imgurl": not_today.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(on.songFile),
    mediaItem: MediaItem(
      id: '17',
      album: "Science Friday",
      title: "ON",
      artist: "BTS",
      extras: {"imgurl": on.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(permission_to_dance.songFile),
    mediaItem: MediaItem(
      id: '18',
      album: "Science Friday",
      title: "Permission to Dance",
      artist: "BTS",
      extras: {"imgurl": permission_to_dance.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(run.songFile),
    mediaItem: MediaItem(
      id: '19',
      album: "Science Friday",
      title: "Run",
      artist: "BTS",
      extras: {"imgurl": run.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(save_me.songFile),
    mediaItem: MediaItem(
      id: '20',
      album: "Science Friday",
      title: "Save Me",
      artist: "BTS",
      extras: {"imgurl": save_me.imgFile},
    ),
  ),
  PlaylistVO(
    uri: Uri.parse(spring_day.songFile),
    mediaItem: MediaItem(
      id: '21',
      album: "Science Friday",
      title: "Spring Day",
      artist: "BTS",
      extras: {"imgurl": spring_day.imgFile},
    ),
  ),
];
