import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class DataSource {
  Future<String?> loadProvinces(String path) async {
    final String response = await rootBundle.loadString(path);

    return response;
  }
}
