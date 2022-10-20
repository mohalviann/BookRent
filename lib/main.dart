import 'package:aplikasi_bookrent/Tampilan_awal.dart';
import 'package:flutter/material.dart';
import 'data_base.dart';
import 'form_peminjam.dart';
import 'peminjam.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOOKRENT📚',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: tampil(),
    );
  }
}
