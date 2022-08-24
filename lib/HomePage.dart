// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // import images
  AssetImage circle = const AssetImage("images/circle.png");
  AssetImage lucky = const AssetImage("images/rupee.png");
  AssetImage unlucky = const AssetImage("images/sadFace.png");

  //get an array
  late List<String> itemArray;
  late int luckyNumber;

  // init array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //define a getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

  // play game method
  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  // showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  // Reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }

//if Lucky is found End the game

  ifLucky() {
    if (itemArray.contains("lucky")) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("ScratchWin"),
                content: const Text("You won!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        resetGame();
                      },
                      child: const Text("Play Again"))
                ],
              ));
    }
  }

//if Unlucky is found continue the game if array has 20 elements empty

  ifUnlucky() {
    if (itemArray.contains("unlucky")) {
      if (itemArray.where((element) => element == "empty").length == 20) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("ScratchWin"),
                  content: const Text("You lost!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          resetGame();
                        },
                        child: const Text("Play Again"))
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scratch and win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    playGame(i);
                    ifLucky();
                    ifUnlucky();
                  },
                  child: Image(
                    image: getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {
                showAll();
              },
              child: const Text(
                'Show All',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {
                resetGame();
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          //branding LCO
          Container(
            margin: const EdgeInsets.all(15.0),
            child: const Text(
              'Developed by Akai07',
              style: TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
