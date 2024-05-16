import 'package:flutter/material.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  List<String> currentPin = ["", "", "", "", "", ""];
  TextEditingController pinController = TextEditingController();
  int pinIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("간편 비밀번호 입력"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "간편 비밀번호를 입력해 주세요",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            buildPinRow(),
            SizedBox(height: 40),
            buildNumberPad(),
          ],
        ),
      ),
    );
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        PinNumber(isFilled: currentPin[0].isNotEmpty),
        SizedBox(width: 10), // 간격 추가
        PinNumber(
          isFilled: currentPin[1].isNotEmpty,
        ),
        SizedBox(width: 10), // 간격 추가
        PinNumber(
          isFilled: currentPin[2].isNotEmpty,
        ),
        SizedBox(width: 10), // 간격 추가
        PinNumber(
          isFilled: currentPin[3].isNotEmpty,
        ),
        SizedBox(width: 10), // 간격 추가
        PinNumber(
          isFilled: currentPin[4].isNotEmpty,
        ),
        SizedBox(width: 10), // 간격 추가
        PinNumber(
          isFilled: currentPin[5].isNotEmpty,
        ),
      ],
    );
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            buildNumberRow("1", "2", "3"),
            buildNumberRow("4", "5", "6"),
            buildNumberRow("7", "8", "9"),
            buildNumberRow("", "0", Icons.backspace),
          ],
        ),
      ),
    );
  }

  buildNumberRow(String first, String second, [dynamic? third]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        KeyboardNumber(
          number: first,
          onPressed: () {
            pinIndexSetup(first);
          },
        ),
        KeyboardNumber(
          number: second,
          onPressed: () {
            pinIndexSetup(second);
          },
        ),
        if (third is String && third.isNotEmpty)
          KeyboardNumber(
            number: third,
            onPressed: () {
              pinIndexSetup(third);
            },
          )
        else if (third is IconData)
          KeyboardNumber(
            icon: third,
            onPressed: () {
              pinIndexSetup("<");
            },
          )
        else
          SizedBox(width: 80.0),
      ],
    );
  }

  void pinIndexSetup(String text) {
    if (text == "<") {
      if (pinIndex == 0) {
        pinIndex = 0;
      } else {
        pinIndex--;
        currentPin[pinIndex] = "";
      }
    } else {
      if (pinIndex == 6) {
        pinIndex = 6;
      } else {
        currentPin[pinIndex] = text;
        pinIndex++;
      }
    }
    setState(() {});
  }

  OutlineInputBorder get outlineInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
  }
}

class PinNumber extends StatelessWidget {
  final bool isFilled;

  PinNumber({required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? Colors.black : Colors.transparent,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final String? number;
  final IconData? icon;
  final VoidCallback onPressed;

  KeyboardNumber({this.number, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: number != null
          ? Text(
              number!,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            )
          : Icon(icon, size: 24.0),
      padding: EdgeInsets.all(16.0),
      shape: CircleBorder(),
    );
  }
}
