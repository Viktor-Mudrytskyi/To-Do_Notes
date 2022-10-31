import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main.dart';

class CustomFloatButt extends StatelessWidget {
  CustomFloatButt({
    super.key,
  });
  String finalData = '';
  bool isActive = false;
  var box = Hive.box('userbox');

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, setStateLocal) {
                return AlertDialog(
                  title: Text(
                    'Add a note',
                    style: GoogleFonts.akayaTelivigala(
                      fontSize: 20.0,
                    ),
                  ),
                  backgroundColor: Colors.amber.shade200,
                  content: TextField(
                    style: GoogleFonts.akayaTelivigala(
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Your note',
                    ),
                    onChanged: (String value) {
                      finalData = value;
                      if (finalData.isEmpty) {
                        setStateLocal(() {
                          isActive = false;
                        });
                      } else {
                        setStateLocal(() {
                          isActive = true;
                        });
                      }
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: (isActive)
                          ? () {
                              box.add(finalData);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const MyNotes()));
                            }
                          : null,
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        color: Colors.amber,
        size: 30.0,
      ),
    );
  }
}
