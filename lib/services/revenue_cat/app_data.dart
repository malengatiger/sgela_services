import 'package:sgela_services/data/subscription.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  bool entitlementIsActive = false;
  String appUserID = '';
  late Subscription currentData;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
