import 'dart:convert';

import 'package:flutter/material.dart';

void showMyDialog(BuildContext context, int index, _deleteUser) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to close dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hapus Data ?'),
        content: Text('Apakah anda yakin ingin menghapus data ini ?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Ya'),
            onPressed: () {
              _deleteUser(index);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(onPressed: () {}, child: Text('Tidak')),
        ],
      );
    },
  );
}
