import 'dart:io';

class Connectivity {
  Connectivity._();

  static final Connectivity _instance = Connectivity._();

  factory Connectivity() => _instance;

  Future<bool> hasConnection() async {
    try {
      final foo = await InternetAddress.lookup('google.com');
      return foo.isNotEmpty && foo[0].rawAddress.isNotEmpty ? true : false;
    } catch (e) {
      return false;
    }
  }
}
