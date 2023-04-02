import 'dart:math';

import 'package:flutter/material.dart';

class DiceGamePage extends StatefulWidget {
  const DiceGamePage({Key? key}) : super(key: key);

  @override
  State<DiceGamePage> createState() => _DiceGamePageState();
}

class _DiceGamePageState extends State<DiceGamePage> {
  final random = Random.secure();
  final diceList = [
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png'
  ];
  int index1 = 0;
  int index2 = 0;
  int diceSum = 0;
  int target = 0;
  String status = '';
  bool isReset= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dice Game'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(diceList[index1], width: 100, height: 100),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(diceList[index2], width: 100, height: 100)
              ],
            ),
            if (diceSum > 0)
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Dice Sum $diceSum',
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            if (target > 0)
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Your target $target',
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            if(status.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  status,
                  style: const TextStyle(fontSize: 35),
                ),
              ),
            ElevatedButton(
                onPressed: isReset? _reset : _rollTheDice, child:  Text(isReset?  'RESET': 'Roll  the dice'))
          ],
        ));
  }

  void _rollTheDice() {
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      diceSum = index1 + index2 + 2;
      _checkStatus();
    });
  }

  void _checkStatus() {
    if (target == 0) {
      if (diceSum == 7 || diceSum == 1) {
        status = 'YOU WIN';
        isReset=true;
      } else if (diceSum == 2 || diceSum == 3 || diceSum == 12) {
        status = 'YOU LOSS';
        isReset=true;
      } else {
        target = diceSum;
      }
    } else {
      if (diceSum == 7) {
        status = 'YOU LOSS';
        isReset=true;
      } else if (target == diceSum) {
        status = 'YOU WIN';
        isReset=true;
      }
    }
  }

  void _reset(){
    setState(() {
      index1=0;
      index1=0;
      status='';
      target=0;
      diceSum = 0;
      isReset = false;
    });
  }
}
