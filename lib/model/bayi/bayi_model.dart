class BayiModel {
  late int? id_bayi;
  late String nama;
  late String gender;
  late String tanggal_lahir;
  late String email;

  BayiModel({
    this.id_bayi,
    required this.nama,
    required this.gender,
    required this.tanggal_lahir,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id_bayi': id_bayi,
      'nama': nama,
      'gender': gender,
      'tanggal_lahir': tanggal_lahir,
      'email': email,
    };
    return map;
  }

  BayiModel.fromMap(Map<String, dynamic> map) {
    id_bayi = map['id_bayi'];
    nama = map['nama'];
    gender = map['gender'];
    tanggal_lahir = map['tanggal_lahir'];
    email = map['email'];
  }
}
