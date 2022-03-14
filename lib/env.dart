import 'package:envify/envify.dart';

part 'env.g.dart';


@Envify(name: 'Secret')
abstract class Secret {
   static const banner_ad_units = _Secret.banner_ad_units;
  
}
