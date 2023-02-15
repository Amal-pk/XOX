import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    color: Colors.white,
    home: Scaffold(
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
/////////////////players

  int player = 1;
  int winner = 0;
  bool winnerfound = false;
  List list = [];

////////////////////////List

  @override
  void initState() {
    super.initState();
    resetList();
  }

////////////////////ResetList

  resetList() {
    List newList = [
      {"pos": 1, "checked": ""},
      {"pos": 2, "checked": ""},
      {"pos": 3, "checked": ""},
      {"pos": 4, "checked": ""},
      {"pos": 5, "checked": ""},
      {"pos": 6, "checked": ""},
      {"pos": 7, "checked": ""},
      {"pos": 8, "checked": ""},
      {"pos": 9, "checked": ""},
    ];
    setState(() {
      list = newList;
      winner = 0;
      player = 1;
      winnerfound = false;
    });
  }

////////////////////onBoxTapped

  onBoxTapped(item, index) {
    // print(item);
    // resetList();
    String mark = player == 1 ? "X"  : "O";
    if (item['checked'] == "") {
      setState(() {
        list[index]['checked'] = mark;
        player = player == 1 ? 2 : 1;
      });
      onValidateGrid();
    }
  }
///////////////////////////ValidGrid

  onValidateGrid() {
    if (list[0]['checked'] != "" &&
        list[0]['checked'] == list[1]['checked'] &&
        list[1]['checked'] == list[2]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[0]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[3]['checked'] != "" &&
        list[3]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[5]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[3]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[6]['checked'] != "" &&
        list[6]['checked'] == list[7]['checked'] &&
        list[7]['checked'] == list[8]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[6]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[0]['checked'] != "" &&
        list[0]['checked'] == list[3]['checked'] &&
        list[3]['checked'] == list[6]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[0]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[1]['checked'] != "" &&
        list[1]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[7]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[1]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[2]['checked'] != "" &&
        list[2]['checked'] == list[5]['checked'] &&
        list[5]['checked'] == list[8]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[2]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[0]['checked'] != "" &&
        list[0]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[8]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[0]['checked'] == "X" ? 1 : 2;
      });
    }
    if (list[2]['checked'] != "" &&
        list[2]['checked'] == list[4]['checked'] &&
        list[4]['checked'] == list[6]['checked']) {
      setState(() {
        winnerfound = true;
        winner = list[2]['checked'] == "X" ? 1 : 2;
      });
    }
  }
///////////////////////////GridView

  Widget gridView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(list.length, (index) {
          var item = list[index];
          return boxView(item, index);
        }),
      ),
    );
  }

///////////////////////BoxView

  Widget boxView(item, index) {
    return InkWell(
      onTap: () {
        onBoxTapped(item, index);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Text(
          item['checked'],
          style: const TextStyle(
            fontSize: 45,
          ),
        ),
      ),
    );
  }

///////////////////RestButton
  Widget restButton() {
    return InkWell(
      onTap: () {
        resetList();
      },
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: const Text("Reset"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        gridView(),
        const SizedBox(
          height: 20,
        ),
        winner == 0 ? Container() : Text("Player $winner win"),

        restButton(),

      ],
    );
  }
}
