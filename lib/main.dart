import 'package:abet/Component.dart/Audio.dart';
import 'package:abet/Component.dart/Empty.dart';
import 'package:abet/Component.dart/utils.dart';
import 'package:abet/Pages/2Ddetailspage.dart';
import 'package:abet/Pages/2Devening.dart';
import 'package:abet/Pages/CreateAccount.dart';

import 'package:abet/Pages/Depohistory.dart';
import 'package:abet/Pages/Depositdetails.dart';
import 'package:abet/Pages/Depositdetails2.dart';
import 'package:abet/Pages/Help.dart';
import 'package:abet/Pages/Home.dart';
import 'package:abet/Pages/Keyboard.dart';
import 'package:abet/Pages/Login.dart';
import 'package:abet/Pages/Notifi.dart';
import 'package:abet/Pages/Profile.dart';
import 'package:abet/Pages/ProfileUpdate.dart';
import 'package:abet/Pages/htwaknum.dart';
import 'package:abet/Pages/transistdetails.dart';
import 'package:abet/Pages/withdrawdetails.dart';
import 'package:abet/Pages/withdraww.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Login');
  await Hive.openBox('Number');

  getNumAndPrice("69R500");
  print(getNumAndPrice("69R500"));

  if (Hive.box("Login").get("remember") == false) {
    Hive.box("Login").clear();
  }

  WidgetsFlutterBinding.ensureInitialized();
  // Audio.initAud();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Bet',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Color(0xff7360f2)),
      initialRoute:
          Hive.box("Login").get("token") == null ? "/login" : "/empty",
      routes: {
        "/empty": (context) => const Empty(),
        "/home": (context) => const MyHomePage(),
        "/help": (context) => const Help(),
        "/profile": (context) => const Profile(),
        "/noti": (context) => const Notifi(),
        "/depohistory": (context) => const DepoHistory(),
        "/trans": (context) => const transdetials(id: ""),
        "/withdraww": (context) => const Withdraww(id: ""),
        "/htwaknum": (context) => const htwaknum(),
        "/createaccount": (context) => const CreateAccount(),
        "/profileupdate": (context) => const ProfileUpdate(),
        "/depodetails": (context) => const Depodetails(),
        "/depodetails2": (context) => const Depositdetails2(),
        "/withdetails": (context) => const Withdrawdetials(),
        "/login": (context) => const Login(),
        // "/2Ddetailspage": (context) => const TwoDDetails(),
        "/keyboard": (context) => const keyborad(),
        // "/2Devening": (context) => const TwoDevening(),
      },
    );
  }
}
