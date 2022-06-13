import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mini_project/api/api_imunisasi.dart';
import 'package:mini_project/model/imunisasi/imunisasi_model.dart';
import 'package:mini_project/state/enum_state.dart';

class ImunisasiState extends ChangeNotifier {
  ImunisasiRepo repo = ImunisasiRepo();
  String _searchKeyword = "";

  StateType stateType = StateType.loading;
  StateType get getStatetype => stateType;

  late List<ImunisasiModel> _imunisasiList;
  UnmodifiableListView<ImunisasiModel> get getDataList => _searchKeyword.isEmpty
      ? UnmodifiableListView(_imunisasiList)
      : UnmodifiableListView(_imunisasiList.where((value) {
          final titleLower = value.nama_imunisasi.toLowerCase();
          final titleUpper = value.nama_imunisasi.toUpperCase();
          return titleLower.contains(_searchKeyword) ||
              titleUpper.contains(_searchKeyword);
        }));

  ImunisasiState() {
    getDataRepo();
  }

  void changeState(StateType value) {
    stateType = value;
    notifyListeners();
  }

  Future getDataRepo() async {
    changeState(StateType.loading);
    try {
      final getData = await repo.getData();
      _imunisasiList = getData;
      changeState(StateType.success);
    } catch (e) {
      changeState(StateType.error);
    }
  }

  void changeSearchString(String searchString) {
    _searchKeyword = searchString;
    notifyListeners();
  }
}
