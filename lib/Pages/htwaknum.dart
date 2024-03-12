import 'dart:math';

import 'package:abet/Component.dart/API.dart';
import 'package:abet/Component.dart/loading.dart';
import 'package:flutter/material.dart';

class htwaknum extends StatefulWidget {
  const htwaknum({super.key});

  @override
  State<htwaknum> createState() => _htwaknumState();
}

class _htwaknumState extends State<htwaknum> {
  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  int currentindex = 0;
  Widget currentPage = TwoD();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff002bc3),
      appBar: AppBar(
        backgroundColor: Color(0xff002bc3),
        title: Text(
          'ထွက်ဂဏန်းများ',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (currentindex == 1) {
                            setState(() {
                              currentindex = 0;
                              currentPage = TwoD();
                            });
                          }
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentindex == 0
                                    ? Color(0xff002bc3)
                                    : Colors.white,
                                border: Border.all(color: Color(0xff002bc3))),
                            child: Center(
                              child: Text(
                                '2D',
                                style: TextStyle(
                                    color: currentindex == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (currentindex == 0) {
                            setState(() {
                              currentindex = 1;
                              currentPage = ThreeD();
                            });
                          }
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentindex == 1
                                    ? Color(0xff002bc3)
                                    : Colors.white,
                                border: Border.all(color: Color(0xff002bc3))),
                            child: Center(
                              child: Text(
                                '3D',
                                style: TextStyle(
                                    color: currentindex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                currentPage,
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class TwoD extends StatefulWidget {
  const TwoD({
    super.key,
  });

  @override
  State<TwoD> createState() => _TwoDState();
}

Map data = {};

List<Widget> TwoDD = [];

class _TwoDState extends State<TwoD> {
  bool isloading = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data = await API.getHtwakNumb2d();
      isloading = false;
      TwoDD.clear();
      data.forEach((key, value) {
        print("aggagga  $value");

        TwoDD.add(TwoDCard(data: value, date: key));
      });

      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: isloading
          ? Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(child: loading()))
          : Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: TwoDD,
              )),
    );
  }
}

class ThreeD extends StatefulWidget {
  const ThreeD({
    super.key,
  });

  @override
  State<ThreeD> createState() => _ThreeDState();
}

List data1 = [];

class _ThreeDState extends State<ThreeD> {
  bool isloading = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data1 = await API.getHtwakNumb3d();
      isloading = false;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: isloading
          ? Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(child: loading()))
          : Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...data1.map((e) => ThreeDCard(
                        e: e,
                      ))
                ],
              )),
    );
  }
}

class ThreeDCard extends StatelessWidget {
  const ThreeDCard({
    required this.e,
    super.key,
  });

  final Map e;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ရက်စွဲ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      e["date"].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ဂဏန်း',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      e["number"] == null ? "---" : e["number"],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            Divider(
              color: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}

class TwoDCard extends StatelessWidget {
  const TwoDCard({
    required this.data,
    required this.date,
    super.key,
  });

  final String date;
  final Map data;

  @override
  Widget build(BuildContext context) {
    print(data);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  data["12:01 PM"][0]['time'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Set',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data["12:01 PM"][0]['set'] == null
                            ? "---"
                            : data["12:01 PM"][0]['set'],
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Value',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data["12:01 PM"][0]['value'] == null
                            ? "---"
                            : data["12:01 PM"][0]['value'],
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Number',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data["12:01 PM"][0]['number'] == null
                            ? "??"
                            : data["12:01 PM"][0]['number'],
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff002bc3),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  data["04:30 PM"][0]['time'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Set',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data["04:30 PM"][0]['set'] == null
                            ? "---"
                            : data["04:30 PM"][0]['set'],
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Value',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data["04:30 PM"][0]['value'] == null
                            ? "---"
                            : data["04:30 PM"][0]['value'],
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Number',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data["04:30 PM"][0]['number'] == null
                            ? "??"
                            : data["04:30 PM"][0]['number'],
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff002bc3),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
