import 'package:flutter/cupertino.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/riwayat/riwayat_model.dart';
import 'package:mini_project/state/enum_state.dart';

class RiwayatState extends ChangeNotifier {
  DbHelper dbHelper = DbHelper();

  late List<RiwayatModel> _riwayatModel;
  List<RiwayatModel> get riwayatModel => _riwayatModel;

  StateType stateType = StateType.loading;
  StateType get getStatetype => stateType;

  // RiwayatState() {
  //   getDataRiwayat(0);
  // }

  void changeState(StateType value) {
    stateType = value;
    notifyListeners();
  }

  Future getDataRiwayat(int id) async {
    changeState(StateType.loading);
    try {
      _riwayatModel = await dbHelper.showDataRiwayat(id);
      changeState(StateType.success);
    } catch (e) {
      print(e);
      changeState(StateType.error);
    }
  }
}
