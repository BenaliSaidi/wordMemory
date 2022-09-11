import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_words/model_db/wordModel.dart';
import 'package:my_words/views/defToWord.dart';
import 'package:my_words/views/myStats.dart';
import 'package:my_words/views/wordToDef.dart';

import 'package:toast/toast.dart';

class MyWordList extends StatefulWidget {
  const MyWordList({Key? key}) : super(key: key);

  @override
  State<MyWordList> createState() => _MyWordListState();
}

String? myWord, myDefinition;
List mywordsList = [];

getWord() {
  mywordsList.clear();
  mywordsList = Hive.box('myWord').values.toList();
  return mywordsList;
}

addWord(String key, MyWord word) {
  Hive.box('myWord').put(key, word);
}

final _formKey = GlobalKey<FormState>();

class _MyWordListState extends State<MyWordList> {
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
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          Hive.box("myWord")
                              .values
                              .where((element) => element.wordToDef == true)
                              .toList()
                              .forEach((element) {
                            Hive.box("myWord").put(
                                element.word,
                                MyWord(element.word, element.definition, false,
                                    element.defToWord));
                          });
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("Reset word"),
                        )),
                    PopupMenuItem(
                        onTap: () {
                          Hive.box("myWord")
                              .values
                              .where((element) => element.defToWord == true)
                              .toList()
                              .forEach((element) {
                            Hive.box("myWord").put(
                                element.word,
                                MyWord(element.word, element.definition,
                                    element.wordToDef, false));
                          });
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("Reset Definition"),
                        ))
                  ])
        ],
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
            onPressed: () {},
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
                MaterialPageRoute(builder: (context) => DefToWord()),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyStats()),
              );
            },
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
            itemCount: Hive.box("myWord").length,
            itemBuilder: ((context, index) {
              final words = Hive.box("myWord").getAt(index) as MyWord;
              return ListTile(
                title: Text(words.word),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: (words.wordToDef == false)
                              ? Colors.red
                              : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: (words.defToWord == false)
                              ? Colors.red
                              : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(words.definition),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Hive.box("myWord").deleteAt(index);
                    setState(() {});
                  },
                ),
              );
            })),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xff7FB77E),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: 220,
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                                // height: 10,
                                ),
                            const Text(
                              'Please add Your Word',
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white10,
                                        labelText: 'My word',
                                        labelStyle: const TextStyle(
                                            color: Colors.black, fontSize: 11),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 2,
                                            color: Color(0xff2980B9),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      onSaved: (newValue) {
                                        myWord = newValue;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          Toast.show("please add a valid word",
                                              duration: Toast.lengthShort,
                                              gravity: Toast.bottom);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white10,
                                        labelText: 'Definition',
                                        labelStyle: const TextStyle(
                                            color: Colors.black, fontSize: 11),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 2,
                                            color: Color(0xff2980B9),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      onSaved: (newValue) {
                                        myDefinition = newValue;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          Toast.show(
                                              "please add a valid definition",
                                              duration: Toast.lengthShort,
                                              gravity: Toast.bottom);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xff7FB77E),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              final savingWord = MyWord(myWord!,
                                                  myDefinition!, false, false);
                                              addWord(myWord!, savingWord);
                                              _formKey.currentState!.reset();
                                              setState(() {});
                                            }
                                          },
                                          child: const Text(
                                            'Save',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          label: const Text("Add Word")),
    );
  }
}
