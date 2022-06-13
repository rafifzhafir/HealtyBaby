// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imunisasi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImunisasiModel _$ImunisasiModelFromJson(Map<String, dynamic> json) =>
    ImunisasiModel(
      id: json['id'] as String,
      nama_imunisasi: json['nama_imunisasi'] as String,
      deskripsi: json['deskripsi'] as String,
    );

Map<String, dynamic> _$ImunisasiModelToJson(ImunisasiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama_imunisasi': instance.nama_imunisasi,
      'deskripsi': instance.deskripsi,
    };
