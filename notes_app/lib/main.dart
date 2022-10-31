import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'floating_action_butt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('userinfo');
  var box = await Hive.openBox('userbox');
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNotes(),
    ),
  );
}

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  var box = Hive.box('userbox');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.grey.shade900,
          title: const Text(
            'Notes',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: CustomFloatButt(),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key("$index"),
              onDismissed: (direction) {
                setState(
                  () {
                    box.deleteAt(index);
                  },
                );
              },
              background: Container(
                color: Colors.amber.shade400,
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.black,
                ),
              ),
              secondaryBackground: Container(
                color: Colors.amber.shade900,
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.black,
                ),
              ),
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    box.getAt(index),
                    style: GoogleFonts.akayaTelivigala(
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever_sharp,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          box.deleteAt(index);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
