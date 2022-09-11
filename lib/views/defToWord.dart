import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_words/model_db/wordModel.dart';
import 'package:my_words/views/myStats.dart';
import 'package:my_words/views/myWordList.dart';
import 'package:my_words/views/wordToDef.dart';
import 'package:scratcher/scratcher.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:toast/toast.dart';

class DefToWord extends StatefulWidget {
  const DefToWord({Key? key}) : super(key: key);

  @override
  State<DefToWord> createState() => _DefToWordState();
}

ValueNotifier<int> count = ValueNotifier(0);
List<Card> notSavedWordsCard = [];
List notSavedWords = [];
List notSavedDefinition = [];
List myStatusList = [];

getNotSavedWord() {
  notSavedDefinition.clear();
  notSavedWordsCard.clear();
  notSavedWords.clear();
  myStatusList.clear();
  var myValues = Hive.box("myWord")
      .values
      .where((element) => element.defToWord == false)
      .toList()
      .forEach((element) {
    notSavedWordsCard.add(Card(
      color: const Color(0xffF7F6DC),
      child: Container(
          alignment: Alignment.center,
          height: 150,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              element.definition,
              style: const TextStyle(
                  fontSize: 27,
                  color: Color.fromARGB(255, 68, 68, 68),
                  fontFamily: "Comfortaa"),
            ),
          )),
    ));
    notSavedDefinition.add(element.definition);
    notSavedWords.add(element.word);
    myStatusList.add(element.wordToDef);
  });
}

editSavedStatus(String word, String definition, bool status) {
  Hive.box("myWord").delete(word);
  Hive.box("myWord").put(word, MyWord(word, definition, status, true));
}

class _DefToWordState extends State<DefToWord> {
  void initState() {
    super.initState();
    getNotSavedWord();
  }

  final scratchKey = GlobalKey<ScratcherState>();
  @override
  Widget build(BuildContext context) {
    print(notSavedWordsCard.length);
    print("+++++++++++++++++");
    print(notSavedDefinition.length);
    print("+++++++++++++++++");
    print(count.value);
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
              count.value = 0;
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
              count.value = 0;
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Card(
              child: Container(
                color: const Color.fromARGB(255, 250, 220, 197),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: const Text(
                  "Swipe right for the words you know , Swipe left for the words you don't know , and scratch below to see the definition",
                  style: TextStyle(fontFamily: "Nunito"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Container(
            child: SwipingCardDeck(
              cardDeck: notSavedWordsCard,
              onDeckEmpty: () => debugPrint("Card deck empty"),
              onLeftSwipe: (Card card) {
                debugPrint("Swiped left!");
                if (count.value < notSavedDefinition.length) {
                  count.value++;
                  print(count.value);
                } else {
                  count.value = 0;
                }

                // if (count.value == notSavedDefinition.length) {
                //   Toast.show("super End List",
                //       duration: Toast.lengthShort, gravity: Toast.center);
                // }

                scratchKey.currentState!
                    .reset(duration: const Duration(milliseconds: 200));
              },
              onRightSwipe: (Card card) {
                debugPrint("Swiped right!");
                if (count.value < notSavedDefinition.length) {
                  editSavedStatus(
                      notSavedWords[count.value],
                      notSavedDefinition[count.value],
                      myStatusList[count.value]);
                  count.value++;

                  print(count.value);
                } else {
                  count.value = 0;
                  editSavedStatus(
                      notSavedWords[count.value],
                      notSavedDefinition[count.value],
                      myStatusList[count.value]);
                }

                // if (count.value == notSavedDefinition.length) {
                //   Toast.show("super End List",
                //       duration: Toast.lengthShort, gravity: Toast.center);
                // }

                scratchKey.currentState!
                    .reset(duration: const Duration(milliseconds: 200));
              },
              swipeThreshold: MediaQuery.of(context).size.width / 4,
              minimumVelocity: 1000,
              cardWidth: 200,
              rotationFactor: 0.8 / 3.14,
              swipeAnimationDuration: const Duration(milliseconds: 200),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Spacer(),
          Scratcher(
            key: scratchKey,
            rebuildOnResize: false,
            color: const Color(0xff7FB77E),
            brushSize: 30,
            onScratchEnd: () {
              print("end end");
            },
            child: Container(
                color: const Color.fromARGB(255, 177, 245, 175),
                alignment: Alignment.center,
                height: 60,
                width: double.infinity,
                child: ValueListenableBuilder<int>(
                    valueListenable: count,
                    builder: (context, value, child) {
                      return (value > notSavedDefinition.length - 1)
                          ? const Text(
                              "kmlt a cherif(a)",
                              style: TextStyle(fontSize: 22),
                            )
                          : Text(
                              notSavedWords[value],
                              style: const TextStyle(
                                  fontSize: 22, fontFamily: "Nunito"),
                            );
                    })),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
          // backgroundColor: Color(0xff7FB77E),
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              count.value = 0;
              getNotSavedWord();
              scratchKey.currentState!
                  .reset(duration: const Duration(milliseconds: 200));
            });
          },
          child: const Icon(
            Icons.refresh,
            color: Color(0xff7FB77E),
          ),
        ),
      ),
    );
  }
}
