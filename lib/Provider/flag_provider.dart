import 'package:flutter/cupertino.dart';
import 'package:front_sena/Data/flag_http_service.dart';
import 'package:front_sena/models/flag_model.dart';

class FlagProvider extends ChangeNotifier {
  List<Flags> flagsModel = [];
  FlagHttpService flagHttpService = FlagHttpService();

  void getFlagsData() async {
    flagsModel = await flagHttpService.getFlagsByLanguage();
    notifyListeners();
  }
}