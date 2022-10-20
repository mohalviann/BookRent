import 'package:aplikasi_bookrent/peminjam.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseKu {
  static final DataBaseKu _dataBaseKu = DataBaseKu.intern();
  static Database? _database;

  //Menginisialisasi dan membaca beberapa variabel yang diperlukan didalamnya
  final String tabelNama = 'tablePeminjam';
  final String kolomId = 'id';
  final String kolomNama = 'nama';
  final String kolomNik = 'Nik';
  final String kolomAlamat = 'alamat';
  final String kolomNohp = 'noHp';
  final String KolomBuku = 'buku';

  DataBaseKu.intern();
  factory DataBaseKu() => _dataBaseKu;

  //Mengecek apakah sebuah database telah tersedia dan siap untuk digunakan
  Future<Database?> get _data async {
    if (_database != null) {
      return _database;
    }
    _database = await storageDb();
    return _database;
  }

  Future<Database?> storageDb() async {
    String databasePlot = await getDatabasesPath();
    String plot = join(databasePlot, 'peminjam-2.db');

    return await openDatabase(plot, version: 2, onCreate: create);
  }

  //Membuat tabel dan fields yang telah ditentukan
  Future<void> create(Database data, int version) async {
    var db_Sql = "CREATE TABLE $tabelNama($kolomId INTEGER PRIMARY KEY, "
        "$kolomNama TEXT,"
        "$kolomNik TEXT,"
        "$kolomAlamat TEXT,"
        "$kolomNohp TEXT,"
        "$KolomBuku TEXT)";

    await data.execute(db_Sql);
  }

  //Memasukkan (insert) ke database
  Future<int?> insertPeminjam(Peminjam kontak) async {
    var dbServer = await _data;
    return await dbServer!.insert(tabelNama, kontak.toMap());
  }

  //Membaca tampilan yang dimasukkan pada sebuah database
  Future<List?> tampilPeminjam() async {
    var dbServer = await _data;
    var hasil = await dbServer!.query(tabelNama, columns: [
      kolomId,
      kolomNama,
      kolomNik,
      kolomAlamat,
      kolomNohp,
      KolomBuku
    ]);

    return hasil.toList();
  }

  //Melakukan update pada sebuah database
  Future<int?> updatePeminjam(Peminjam peminjam) async {
    var dbServer = await _data;
    return await dbServer!.update(tabelNama, peminjam.toMap(),
        where: '$kolomId = ?', whereArgs: [peminjam.id]);
  }

  //Menghapus sebuah data base
  Future<int?> hapusPeminjam(int id) async {
    var dbServer = await _data;
    return await dbServer!
        .delete(tabelNama, where: '$kolomId = ?', whereArgs: [id]);
  }
}
