import 'package:abet/Component.dart/API.dart';
import 'package:abet/Component.dart/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepoHistory extends StatefulWidget {
  const DepoHistory({super.key});

  @override
  State<DepoHistory> createState() => _DepoHistoryState();
}

class _DepoHistoryState extends State<DepoHistory> {
  Map data = {};

  bool isloading = true;

  List<Widget> ColumnWidg = [];
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      isloading = false;
      if (mounted) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data = await API.getUserTransction();

      data.forEach((key, value) {
        print(value);
        ColumnWidg.add(Month(data: value, date: key));
      });

      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xff002bc3),
        appBar: AppBar(
          backgroundColor: Color(0xff002bc3),
          title: Text(
            'ငွေသွင်း/ငွေထုတ်မှတ်တမ်း',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: isloading
            ? Center(child: loading())
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: ColumnWidg,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class Month extends StatelessWidget {
  const Month({
    required this.data,
    required this.date,
    super.key,
  });

  final String date;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                date,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ...data.map((e) {
              if (e["type"] == "+") {
                return Depo(data: e);
              } else {
                return withdraw(data: e);
              }
            })
          ],
        ),
      ),
    );
  }
}

class Depo extends StatelessWidget {
  const Depo({
    required this.data,
    super.key,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/trans');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.monetization_on_rounded,
                          color: Color(0xff002bc3),
                          size: 26,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ငွေဖြည့်',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data['date_time'],
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['type'] + data['amount'].toString() + " Ks",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}

class withdraw extends StatelessWidget {
  const withdraw({
    required this.data,
    super.key,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/withdraww');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.coins,
                          color: Color(0xff002bc3),
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ငွေထုတ်',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data["date_time"],
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['type'] + data['amount'].toString() + " Ks",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
