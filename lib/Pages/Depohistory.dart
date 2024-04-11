import 'package:abet/Component.dart/API.dart';
import 'package:abet/Component.dart/loading.dart';
import 'package:abet/Pages/Home.dart';
import 'package:abet/Pages/transistdetails.dart';
import 'package:abet/Pages/withdraww.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DepoHistory extends StatefulWidget {
  const DepoHistory({super.key});

  @override
  State<DepoHistory> createState() => _DepoHistoryState();
}

class _DepoHistoryState extends State<DepoHistory> {
  Map data = {};
  final formatter = NumberFormat.decimalPattern();
  bool isloading = true;

  List<Widget> ColumnWidg = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data = await API.getUserTransction();

      isloading = false;
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
        backgroundColor: Color(0xff002bc3),
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white),
          child: isloading
              ? Center(child: loading())
              : data.isEmpty
                  ? Center(
                      child: Text(
                      'No Transaction History',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ))
                  : SingleChildScrollView(
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return transdetials(
                      id: data['id'],
                    );
                  },
                ));
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
                      data['type'] + formatter.format(data['amount']) + " Ks",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: data['status'] == 1
                              ? Colors.yellow.shade800
                              : Colors.green,
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Withdraww(
                      id: data['id'],
                    );
                  },
                ));
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
                      data['type'] + formatter.format(data['amount']) + " Ks",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: data['status'] == 1
                              ? Colors.yellow.shade800
                              : Colors.red,
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
