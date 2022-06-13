import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'imunisasi_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ImunisasiModel {
  final String id;
  final String nama_imunisasi;
  final String deskripsi;

  ImunisasiModel({
    required this.id,
    required this.nama_imunisasi,
    required this.deskripsi,
  });

  factory ImunisasiModel.fromJson(Map<String, dynamic> jsonData) =>
      _$ImunisasiModelFromJson(jsonData);

  static Map<String, dynamic> toJson(ImunisasiModel imunisasiModel) =>
      _$ImunisasiModelToJson(imunisasiModel);

  static List<ImunisasiModel> decode(String cModel) =>
      (json.decode(cModel) as List<dynamic>)
          .map((item) => ImunisasiModel.fromJson(item))
          .toList();
}
