import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ktp_03/datasource.dart';
import 'package:ktp_03/repositories.dart';
import 'package:ktp_03/widget.dart';

class Usecase {
  Repository? _repository = Repository(DataSource());

  Future loadProvinces() async {
    List<String> provinces = [];
    var a = await _repository!.loadProvinces();
    var data = jsonDecode(a) as List<dynamic>;
    data.forEach((element) {
      provinces.add(element['name']);
    });

    return provinces;
  }

  Future loadCities() async {
    List<String> cities = [];
    var a = await _repository!.loadCities();
    var data = jsonDecode(a) as List<dynamic>;
    data.forEach((element) {
      cities.add(element['name']);
    });
    return cities;
  }
}
