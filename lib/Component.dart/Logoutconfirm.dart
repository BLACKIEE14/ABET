import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Logoutcomfirm extends StatefulWidget {
  const Logoutcomfirm({super.key});

  @override
  State<Logoutcomfirm> createState() => _LogoutcomfirmState();
}

class _LogoutcomfirmState extends State<Logoutcomfirm> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      // backgroundColor: Colors.white,
      // icon: Icon(
      //   Icons.logout,
      //   color: Color(0xff002bc3),
      //   size: 40,
      // ),
      title: Text(
        "အကောင့်ထွက်မည်",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "အကောင့်ထွက်မှာ သေချာပါသလား",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "မထွက်ပါ",
              style: TextStyle(color: Colors.green),
            )),
        TextButton(
            onPressed: () {
              Hive.box("Login").clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: Text(
              "ထွက်မည်",
              style: TextStyle(color: Colors.red),
            ))
      ],
      // actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
