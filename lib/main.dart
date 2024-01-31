import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ktp_03/datasource.dart';
import 'package:ktp_03/detail.dart';
import 'package:ktp_03/entities.dart';
import 'package:ktp_03/repositories.dart';
import 'package:ktp_03/widget.dart';
import 'package:ktp_03/usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('users');
  runApp(const MyApp());
}

var usecase =
    Usecase(); // Replace Usecase with the actual type of the variable.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar KTP',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => DetailPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _jobPlaceController = TextEditingController();
  final _educationPlaceController = TextEditingController();
  String? selectedCities;
  String? selectedProvince;
  List<String> provinces = [];
  List<String> cities = [];
  String dropdownValue = 'Item 1';

  @override
  void dispose() {
    _nameController.dispose();
    _birthPlaceController.dispose();
    super.dispose();
  }

  void add() {
    if (_formKey.currentState!.validate()) {
      final user = {
        'name': _nameController.text,
        'birthPlace': _birthPlaceController.text,
        'occupation': _jobPlaceController.text,
        'education': _educationPlaceController.text,
        'province': selectedProvince,
        'city': selectedCities,
      };
      final usersBox = Hive.box('users');
      usersBox.add(user);
      _nameController.clear();
      _birthPlaceController.clear();
      setState(() {});
    }
  }

  void delete(int index) {
    var _box = Hive.box('users');
    _box.deleteAt(index);
    setState(() {});
  }

  void loadProvinces() async {
    var x = await usecase.loadProvinces();
    var b = await usecase.loadCities();

    setState(() {
      provinces = x;
      cities = b;
    });
    print(cities);
  }

  @override
  initState() {
    print('masuk ke init');
    loadProvinces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar KTP'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _birthPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'Tempat Lahir',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tempat Lahir tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _jobPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'Pekerjaan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pekerjaan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _educationPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'Pendidikan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pendidikan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: selectedProvince,
                  hint: Text('Pilih Provinsi'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProvince = newValue!;
                    });
                  },
                  items: provinces.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: selectedCities,
                  hint: Text('Pilih Kota'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCities = newValue!;
                    });
                  },
                  items: cities.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: add,
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box('users').listenable(),
              builder: (context, Box usersBox, _) {
                return ListView.builder(
                  itemCount: usersBox.length,
                  itemBuilder: (context, index) {
                    final user = usersBox.getAt(index);
                    return ListTile(
                      title: Text(user['name']),
                      onTap: () {
                        List<Person> persons = [
                          Person(
                            nama: user['name'],
                            tempatLahir: user['birthPlace'],
                            pekerjaan: user['occupation'],
                            pendidikan: user['education'],
                            provinsi: user['province'],
                            kota: user['city'],
                          ),
                        ];

                        Navigator.pushNamed(context, '/second',
                            arguments: persons);
                      },
                      subtitle: Text(user['province']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showMyDialog(context, index, delete);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
