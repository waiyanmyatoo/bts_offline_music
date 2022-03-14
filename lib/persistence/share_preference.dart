
import 'package:get_storage/get_storage.dart';

const String adsTime = "ADS_TIME";

class SharePreference {
  
  static final SharePreference _singleton = SharePreference._internal();

  factory SharePreference() {
    return _singleton;
  }

  SharePreference._internal();

  GetStorage box = GetStorage();

  Future saveAdsShowTime(String time) async{
    box.write(adsTime, time);
    
  }

  Future<String?> getAdsShowTime() async {
    return box.read(adsTime);
  }


}