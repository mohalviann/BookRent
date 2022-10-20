import 'package:flutter/material.dart';
import 'data_base.dart';
import 'peminjam.dart';

class FormPeminjam extends StatefulWidget {
  final Peminjam? peminjam;

  FormPeminjam({this.peminjam});

  @override
  _FormPeminjam createState() => _FormPeminjam();
}

class _FormPeminjam extends State<FormPeminjam> {
  DataBaseKu db = DataBaseKu();

  TextEditingController? nama;
  TextEditingController? namaPanggilan;
  TextEditingController? nik;
  TextEditingController? alamat;
  TextEditingController? noHp;
  TextEditingController? buku;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.peminjam == null ? '' : widget.peminjam!.nama);

    nik = TextEditingController(
        text: widget.peminjam == null ? '' : widget.peminjam!.nik);

    alamat = TextEditingController(
        text: widget.peminjam == null ? '' : widget.peminjam!.alamat);

    noHp = TextEditingController(
        text: widget.peminjam == null ? '' : widget.peminjam!.nohp);

    buku = TextEditingController(
        text: widget.peminjam == null ? '' : widget.peminjam!.buku);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORM PEMINJAMAN BUKU📑',
            style: TextStyle(fontFamily: 'Roboto')),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey.shade400,
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 22,
            ),
            child: TextField(
              controller: nik,
              decoration: InputDecoration(
                  labelText: 'NIK',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 22,
            ),
            child: TextField(
              controller: alamat,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 22,
            ),
            child: TextField(
              controller: noHp,
              decoration: InputDecoration(
                  labelText: 'No HP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 22,
            ),
            child: TextField(
              controller: buku,
              decoration: InputDecoration(
                  labelText: 'Judul Buku',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: (widget.peminjam == null)
                  ? Text(
                      'Simpan💾',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Perbarui Data🔃',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () async {
                await intPeminjam();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> intPeminjam() async {
    if (widget.peminjam != null) {
      //update
      await db.updatePeminjam(Peminjam.fromMap({
        'id': widget.peminjam!.id,
        'nama': nama!.text,
        'Nik': nik!.text,
        'alamat': alamat!.text,
        'noHp': noHp!.text,
        'buku': buku!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      // insert
      await db.insertPeminjam(Peminjam(
          nama: nama!.text,
          nik: nik!.text,
          alamat: alamat!.text,
          nohp: noHp!.text,
          buku: buku!.text));
      Navigator.pop(context, 'save');
    }
  }
}
