import 'dart:convert';

import 'package:ktp_03/datasource.dart';

class Repository {
  final DataSource _dataSource;

  Repository(this._dataSource);

  Future loadProvinces() async {
    var path = 'assets/provinces.json';
    return _dataSource.loadProvinces(path);
  }

  Future loadCities() async {
    var path = 'assets/regencies.json';
    return _dataSource.loadProvinces(path);
  }
}

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
