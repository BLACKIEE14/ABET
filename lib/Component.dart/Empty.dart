import 'package:abet/Pages/Help.dart';
import 'package:abet/Pages/Home.dart';
import 'package:abet/Pages/Login.dart';

import 'package:abet/Pages/Profile.dart';
import 'package:flutter/material.dart';

class Empty extends StatefulWidget {
  const Empty({super.key});

  @override
  State<Empty> createState() => _EmptyState();
}

class _EmptyState extends State<Empty> with SingleTickerProviderStateMixin {
  TabController? tcon;
  Widget currentPage = const MyHomePage();
  int currentIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        tcon = TabController(length: 3, vsync: this);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff002bc3),
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Colors.white,
          currentIndex: currentIndex,
          backgroundColor: Color(0xff002bc3),
          onTap: (index) {
            switch (index) {
              case 0:
                {
                  setState(() {
                    currentPage = const MyHomePage();
                    currentIndex = index;
                  });
                }
                break;

              case 1:
                {
                  setState(() {
                    currentPage = const Help();
                    currentIndex = index;
                  });
                }
                break;
              case 2:
                {
                  setState(() {
                    currentPage = const Profile();
                    currentIndex = index;
                  });
                }
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    currentIndex == 0
                        ? 'lib/Img/homew.png'
                        : 'lib/Img/home.png',
                    height: 20,
                  )),
              label: 'ပင်မ',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  currentIndex == 1 ? 'lib/Img/helpw.png' : 'lib/Img/help.png',
                  height: 20,
                ),
              ),
              label: 'အကူအညီ',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  currentIndex == 2 ? 'lib/Img/userw.png' : 'lib/Img/user.png',
                  height: 20,
                ),
              ),
              label: 'ပရိုဖိုင်',
            ),
          ],
        ),
      ),
    );
  }
}
