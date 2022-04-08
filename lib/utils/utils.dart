final String songPath = "asset:///assets/audios/";
final String imgPath = "assets/images/";

extension FileName on String {

  String get songFile {
    return songPath + this + ".mp3";
  }

  String get imgFile {
    return imgPath + "playstore" + ".png";
  }
}
