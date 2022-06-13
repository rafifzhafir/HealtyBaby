import 'package:mini_project/model/bayi/bayi_model.dart';
import 'package:mini_project/model/riwayat/riwayat_model.dart';
import 'package:mini_project/model/user/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'imunisasi.db';
  static const int Version = 1;

  // Tabel user
  static const String Table_User = 'user';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  // Tabel Bayi
  static const String Table_bayi = 'bayi';
  static const String C_Id_Bayi = 'id_bayi';
  static const String C_Nama = 'nama';
  static const String C_Gender = 'gender';
  static const String C_Tanggal = 'tanggal_lahir';

  // Tabel Riwayat
  static const String Table_riwayat = 'riwayat';
  static const String C_Id_Riwayat = 'id_riwayat';
  static const String C_Imunisasi = 'imunisasi';
  static const String C_Tanggal_Imunisasi = 'tanggal_imunisasi';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " PRIMARY KEY ($C_Email)"
        ")");

    await db.execute("CREATE TABLE $Table_bayi ("
        " $C_Id_Bayi INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_Nama TEXT,"
        " $C_Gender TEXT, "
        " $C_Tanggal TEXT, "
        " $C_Email TEXT, "
        " FOREIGN KEY ($C_Email) REFERENCES $Table_User ($C_Email) "
        ")");

    await db.execute("CREATE TABLE $Table_riwayat ("
        " $C_Id_Riwayat INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_Imunisasi TEXT,"
        " $C_Tanggal_Imunisasi TEXT, "
        " $C_Id_Bayi INTEGER, "
        " FOREIGN KEY ($C_Id_Bayi) REFERENCES $Table_bayi ($C_Id_Bayi) "
        ")");
  }

  // Tabel User
  Future<int> saveDataUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$email' AND "
        "$C_Password = '$password'");

    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_Email = ?', whereArgs: [user.email]);
    return res;
  }

  // Tabel Bayi
  Future<int> saveDataBayi(BayiModel data) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_bayi, data.toMap());
    return res;
  }

  Future<List<BayiModel>> showDataBayi(String data) async {
    var dbClient = await db;
    final res = await dbClient
        .rawQuery("SELECT * FROM $Table_bayi WHERE $C_Email = '$data'");
    return res.map((value) => BayiModel.fromMap(value)).toList();
  }

  // Tabel Riwayat
  Future<int> saveDataRiwayat(RiwayatModel data) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_riwayat, data.toMap());
    return res;
  }

  Future<List<RiwayatModel>> showDataRiwayat(int data) async {
    var dbClient = await db;
    final res = await dbClient
        .rawQuery("SELECT * FROM $Table_riwayat WHERE $C_Id_Bayi = '$data'");
    return res.map((value) => RiwayatModel.fromMap(value)).toList();
  }
}
