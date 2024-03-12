import 'package:abet/Component.dart/API.dart';
import 'package:abet/Component.dart/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notifi extends StatefulWidget {
  const Notifi({super.key});

  @override
  State<Notifi> createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  bool isloading = true;
  Map data = {};

  List<Widget> ColumnWidg = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data = await API.getUserNoti();
      isloading = false;
      data.forEach((key, value) {
        print(value);
        ColumnWidg.add(ColWig(data: value, date: key));
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
            'အသိပေးချက်များ',
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
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: ColumnWidg,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class ColWig extends StatelessWidget {
  const ColWig({
    required this.data,
    required this.date,
    super.key,
  });

  final String date;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              date,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          ...data.map((e) {
            if (e["type"] == "admin") {
              return depositdetails(data: e);
            } else if (e["type"] == "withdraw") {
              return withdrawdetails(data: e);
            } else {
              return rewardetails(data: e);
            }
          })
          // depositdetails(),
          // rewardetails(),
          // withdrawdetails(),
        ],
      )),
    );
  }
}

class rewardetails extends StatelessWidget {
  const rewardetails({
    required this.data,
    super.key,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.award,
              color: Color(0xff002bc3),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data['content'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 1,
            color: Colors.grey.shade200,
          ),
        )
      ],
    );
  }
}

class withdrawdetails extends StatelessWidget {
  const withdrawdetails({
    required this.data,
    super.key,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Icon(
                FontAwesomeIcons.moneyBillTransfer,
                size: 18,
                color: Color(0xff002bc3),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                data['content'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 1,
            color: Colors.grey.shade200,
          ),
        )
      ],
    );
  }
}

class depositdetails extends StatelessWidget {
  const depositdetails({
    required this.data,
    super.key,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.circleExclamation,
              color: Colors.yellow.shade700,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data['content'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 1,
            color: Colors.grey.shade200,
          ),
        )
      ],
    );
  }
}
