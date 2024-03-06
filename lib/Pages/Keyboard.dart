import 'package:abet/Pages/2Ddetailspage.dart';
import 'package:flutter/material.dart';

class keyborad extends StatefulWidget {
  const keyborad({super.key});

  @override
  State<keyborad> createState() => _keyboradState();
}

class _keyboradState extends State<keyborad> {
  @override
  Widget build(BuildContext context) {
    final txtcon = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          KAMKeyboard(
            con: txtcon,
            enterAction: () {},
            printAction: () {},
            // willInkwell: true,
          ),
          TextField(
            controller: txtcon,
          ),
        ],
      ),
    );
  }
}
