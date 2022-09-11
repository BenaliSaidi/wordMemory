import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:my_words/views/defToWord.dart';
import 'package:my_words/views/myWordList.dart';
import 'package:my_words/views/wordToDef.dart';

class MyStats extends StatefulWidget {
  const MyStats({Key? key}) : super(key: key);

  @override
  State<MyStats> createState() => _MyStatsState();
}

int getTotalWord() {
  return Hive.box("myWord").values.length;
}

int getSavedWord(bool status) {
  return Hive.box("myWord")
      .values
      .where((element) => element.wordToDef == status)
      .toList()
      .length;
}

int getSavedDef(bool status) {
  return Hive.box("myWord")
      .values
      .where((element) => element.defToWord == status)
      .toList()
      .length;
}

class _MyStatsState extends State<MyStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff7FB77E),
        title: const Text(
          "Word Memory",
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff7FB77E),
            ),
            curve: Curves.ease,
            child: Center(
              child: Text(
                'Word Memory',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyWordList()),
              );
            },
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.list),
              title: Text(
                "My words",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WordToDef()),
              );
            },
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.keyboard_arrow_right),
              title: Text(
                "Word To Definition",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DefToWord()),
              );
            },
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.keyboard_arrow_left),
              title: Text(
                "Definition To Word",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.star),
              title: Text(
                "My Stats",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),
            ),
          ),
        ]),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Total Words",
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Nunito"),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                getTotalWord().toString(),
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Comfortaa"),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Saved Words",
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Nunito"),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                getSavedWord(true).toString(),
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Comfortaa"),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Unsaved Words",
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Nunito"),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                getSavedWord(false).toString(),
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Comfortaa"),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Saved Definitions",
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Nunito"),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                getSavedDef(true).toString(),
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Comfortaa"),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Unsaved Definitions",
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Nunito"),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                getSavedDef(false).toString(),
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontFamily: "Comfortaa"),
              )
            ],
          )
        ],
      ),
    );
  }
}
