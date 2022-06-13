class RiwayatModel {
  late int? id_riwayat;
  late String imunisasi;
  late String tanggal_imunisasi;
  late int id_bayi;

  RiwayatModel({
    this.id_riwayat,
    required this.imunisasi,
    required this.tanggal_imunisasi,
    required this.id_bayi,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id_riwayat': id_riwayat,
      'imunisasi': imunisasi,
      'tanggal_imunisasi': tanggal_imunisasi,
      'id_bayi': id_bayi,
    };
    return map;
  }

  RiwayatModel.fromMap(Map<String, dynamic> map) {
    id_riwayat = map['id_riwayat'];
    imunisasi = map['imunisasi'];
    tanggal_imunisasi = map['tanggal_imunisasi'];
    id_bayi = map['id_bayi'];
  }
}
