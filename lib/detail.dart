import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ktp_03/datasource.dart';
import 'package:ktp_03/entities.dart';
import 'package:ktp_03/repositories.dart';
import 'package:ktp_03/widget.dart';
import 'package:ktp_03/usecase.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Person> person =
        ModalRoute.of(context)!.settings.arguments as List<Person>;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Nama       : ${person[0].nama}',
                  style: TextStyle(fontSize: 20)),
              Text(
                'TTL        : ${person[0].tempatLahir}',
                style: TextStyle(fontSize: 20),
              ),
              Text('Pekerjaan  : ${person[0].pekerjaan}',
                  style: TextStyle(fontSize: 20)),
              Text('Pendidikan : ${person[0].pendidikan}',
                  style: TextStyle(fontSize: 20)),
              Text('Provinsi   : ${person[0].provinsi}',
                  style: TextStyle(fontSize: 20)),
              Text('Kota       : ${person[0].kota}',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ));
  }
}
