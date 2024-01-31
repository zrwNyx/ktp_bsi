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
