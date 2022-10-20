import 'package:aplikasi_bookrent/peminjam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class tampil extends StatefulWidget {
  const tampil({super.key});

  @override
  State<tampil> createState() => _tampilState();
}

// membuat splash screen (tampilan awal program)
class _tampilState extends State<tampil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListPeminjam()));
            },
            child: Text(
              'BOOKRENT📚',
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
            )),
      ),
    );
  }
}
