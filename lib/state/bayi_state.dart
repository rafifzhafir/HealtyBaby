import 'package:flutter/cupertino.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/bayi/bayi_model.dart';
import 'package:mini_project/state/enum_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BayiState extends ChangeNotifier {
  List<BayiModel> _bayiModel = [];
  DbHelper dbHelper = DbHelper();
  StateType stateType = StateType.loading;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  List<BayiModel> get bayiModel => _bayiModel;

  StateType get getStatetype => stateType;

  void changeState(StateType value) {
    stateType = value;
    notifyListeners();
  }

  Future getDataBayi() async {
    changeState(StateType.loading);
    try {
      final SharedPreferences sp = await _pref;
      String getEmail = sp.getString("email")!;
      _bayiModel = await dbHelper.showDataBayi(getEmail);
      changeState(StateType.success);
    } catch (e) {
      print(e);
      changeState(StateType.error);
    }
  }
}
