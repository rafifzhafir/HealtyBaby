import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mini_project/model/imunisasi/imunisasi_model.dart';

class ImunisasiRepo {
  final _dio = Dio();
  final _baseUrl = "https://623ada282e056d1037e86716.mockapi.io/imunisasi";

  Future<List<ImunisasiModel>> getData() async {
    Response response = await _dio.get(_baseUrl);
    try {
      final catchData = ImunisasiModel.decode(json.encode(response.data));
      return catchData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  static Future<Iterable<ImunisasiModel>> getUserSuggestions(
      String query) async {
    Response response = await Dio()
        .get("https://623ada282e056d1037e86716.mockapi.io/imunisasi");

    try {
      final catchData = ImunisasiModel.decode(json.encode(response.data));
      return catchData.where((user) {
        final nameLower = user.nama_imunisasi.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      });
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
