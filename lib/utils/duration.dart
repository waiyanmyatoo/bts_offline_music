String parseDuration(x) {
  final double _temp = x / 1000;
  final int _minutes = (_temp / 60).floor();
  final int _seconds = (((_temp / 60) - _minutes) * 60).round();
  if (_seconds.toString().length != 1) {
    return _minutes.toString() + ":" + _seconds.toString();
  } else {
    return _minutes.toString() + ":0" + _seconds.toString();
  }
}
