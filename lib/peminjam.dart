import 'package:flutter/material.dart';
import 'form_peminjam.dart';
import 'data_base.dart';

class Peminjam {
  int? id;
  String? nama;
  String? nik;
  String? alamat;
  String? nohp;
  String? buku;

  Peminjam({this.id, this.nama, this.nik, this.alamat, this.nohp, this.buku});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['nik'] = nik;
    map['alamat'] = alamat;
    map['nohp'] = nohp;
    map['buku'] = buku;

    return map;
  }

  factory Peminjam.fromMap(Map<String, dynamic> map) {
    return Peminjam(
      id: map['id'],
      nama: map['nama'],
      nik: map['Nik'],
      alamat: map['alamat'],
      nohp: map['noHp'],
      buku: map['buku'],
    );
  }
}

class ListPeminjam extends StatefulWidget {
  const ListPeminjam({Key? key}) : super(key: key);

  @override
  _ListPeminjamState createState() => _ListPeminjamState();
}

class _ListPeminjamState extends State<ListPeminjam> {
  List<Peminjam> listPeminjam = [];
  DataBaseKu sql = DataBaseKu();

  @override
  void initState() {
    //menjalankan fungsi _tampil peminjam saat pertama kali aplikasi dijalankan
    _tampilPeminjam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("DAFTAR PEMINJAM BUKU📝       ",
              style: TextStyle(fontFamily: 'Roboto')),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey.shade400,
      body: ListView.builder(
          itemCount: listPeminjam.length,
          itemBuilder: (context, index) {
            Peminjam peminjam = listPeminjam[index];
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                leading: Icon(
                  Icons.badge,
                  size: 50,
                ),
                title: Text('${peminjam.nama}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text("NIK: ${peminjam.nik}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text("Alamat: ${peminjam.alamat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text("No Hp: ${peminjam.nohp}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text("Judul Buku: ${peminjam.buku}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // Tombol edit
                      IconButton(
                          onPressed: () {
                            Edit(peminjam);
                          },
                          icon: Icon(Icons.edit)),
                      // Tombol hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat notifikasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Peringatan"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Apakah anda ingin menghapus data ${peminjam.nama}?")
                                ],
                              ),
                            ),
                            //Membuat 2 buah pilihan tombol
                            //(ya) maka aplikasi akan menjalankan _hapuspeminjam() untuk menghapus data dan notifikasi akan tertutup
                            //(tidak) maka aplikasi akan menutup langsung notifikasi dan data tidak terhapus
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _hapusPeminjam(peminjam, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),

      //Membuat tombol add pada bagian pojok kanan bawah yang berfungsi untuk menambahkan data
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_comment_outlined),
        onPressed: () {
          openForm();
        },
      ),
    );
  }

  //Mengambil semua data peminjam buku
  Future<void> _tampilPeminjam() async {
    //menampilkan list yang memuat data dari database
    var list = await sql.tampilPeminjam();

    //Jika terdapat perubahan data pada state
    setState(() {
      //Aplikasi menghapus data pada list peminjam buku
      listPeminjam.clear();

      //melakukan perulangan yang terdapat pada variabel list
      list!.forEach((peminjam) {
        //memasukan data ke list peminjam buku
        var tmp = Peminjam.fromMap(peminjam);
        listPeminjam.add(tmp);
      });
    });
  }

  //Menghapus data peminjam buku
  Future<void> _hapusPeminjam(Peminjam peminjam, int position) async {
    await sql.hapusPeminjam(peminjam.id!);
    setState(() {
      listPeminjam.removeAt(position);
    });
  }

  //Membuka dan menampilkan data peminjam buku
  Future<void> openForm() async {
    var hasil = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormPeminjam()));
    if (hasil == 'save') {
      await _tampilPeminjam();
    }
  }

  //Membuka dan menampilkan halaman edit peminjam buku
  Future<void> Edit(Peminjam peminjam) async {
    var hasil = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormPeminjam(peminjam: peminjam)));
    if (hasil == 'update') {
      await _tampilPeminjam();
    }
  }
}
