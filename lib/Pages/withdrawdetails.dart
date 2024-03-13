import 'package:abet/Component.dart/API.dart';
import 'package:abet/Pages/Toast.dart';
import 'package:flutter/material.dart';

class Withdrawdetials extends StatefulWidget {
  const Withdrawdetials({super.key});

  @override
  State<Withdrawdetials> createState() => _WithdrawdetialsState();
}

List incomedata = [];
bool isloading = true;

class _WithdrawdetialsState extends State<Withdrawdetials> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      incomedata = await API.getPaymentMethod();
      selectetpayment = incomedata[0]['id'];
      selectetpaymentmethod = incomedata[0];
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  final txtrecivername = TextEditingController();
  final txtrecivernum = TextEditingController();
  final txtreciverenum = TextEditingController();
  final txtamount = TextEditingController();
  final txtpin = TextEditingController();
  int selectetpayment = 0;
  int currentpage = 0;
  Map? selectetpaymentmethod;

  Widget withdrawdetails1() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ငွေထုတ်မည့်အမျိုးအစား',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: selectetpayment == null
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...incomedata.map(
                        (e) => GestureDetector(
                          onTap: () {
                            if (selectetpayment != e['id']) {
                              setState(() {
                                selectetpayment = e['id'];
                              });
                            }

                            selectetpaymentmethod = e;
                          },
                          child: Container(
                            width:
                                (MediaQuery.of(context).size.width - 30 - 10) /
                                    2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: selectetpayment == e['id']
                                    ? Border.all(color: Color(0xff002bc3))
                                    : Border.all(color: Colors.grey.shade400),
                                color: selectetpayment == e['id']
                                    ? Colors.lightBlue.shade100
                                    : Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        e['image'],
                                        height: 30,
                                        width: 30,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    e["name"],
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 55, 46, 46),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'ငွေလက်ခံမည့်အကောင့်နာမည်',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: txtrecivername,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "ငွေလက်ခံမည့်အကောင့်နာမည်ရိုက်ထည့်ပါ",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff002bc3)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'ငွေလက်ခံမည့်အကောင့်နံပါတ်',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: txtrecivernum,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "ငွေလက်ခံမည့်အကောင့်နံပါတ်ရိုက်ထည့်ပါ",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff002bc3)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'ငွေလက်ခံမည့်အကောင့်နံပါတ်',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: txtreciverenum,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "ငွေလက်ခံမည့်အကောင့်နံပါတ်ပြန်ရိုက်ထည့်ပါ ",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff002bc3)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          Text(
            'Amount',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: txtamount,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Amount ရိုက်ထည့်ပါ",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff002bc3)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: () {
                if (txtrecivername.text.isEmpty ||
                    txtrecivernum.text.isEmpty ||
                    txtreciverenum.text.isEmpty ||
                    txtamount.text.isEmpty) {
                  showToast('အချက်အလက်များကိုပြည့်စုံအောင်ဖြည့်ပါ။',
                      isError: true);
                } else {
                  setState(() {
                    currentpage = 1;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff002bc3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'ဆက်သွားမည်',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(
                    0xff002bc3,
                  ),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Color(0xff002bc3),
                  ),
                  child: Center(
                    child: Text(
                      'ငွေထုတ်နည်းမသိပါက ဆက်သွယ်ရန်',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Viber',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Color(0xff002bc3),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '09777269997',
                              style: TextStyle(
                                  color: Color(0xff002bc3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Telegram',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Color(0xff002bc3),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '09777269997',
                              style: TextStyle(
                                  color: Color(0xff002bc3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Phone',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Color(0xff002bc3),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '09777269997',
                              style: TextStyle(
                                  color: Color(0xff002bc3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget withdrawdetails2() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ငွေထုတ်ရန် စကားဝှက် ရိုက်ထည့်ပါ',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              controller: txtpin,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "စကားဝှက် ရိုက်ထည့်ပါ",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff002bc3)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot your PIN?',
                  style: TextStyle(color: Color(0xff002bc3)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentpage = 0;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xff002bc3),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'ရှေ့သို့ ',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (txtpin.text.isEmpty) {
                        showToast('စကားဝှက်ဖြည့်ပါ။', isError: true);
                      } else {
                        setState(() {
                          isloading = true;
                        });
                        Map response = await API.postWithdraw(
                          selectetpaymentmethod!['id'],
                          txtrecivername.text,
                          txtreciverenum.text,
                          txtreciverenum.text,
                          txtamount.text,
                          txtpin.text,
                        );
                        setState(() {
                          isloading = false;
                        });
                        if (response['errors'] == null) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff002bc3),
                          ),
                          color: Color(0xff002bc3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'တင်ပြမည်  ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(
                      0xff002bc3,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: Color(0xff002bc3),
                    ),
                    child: Center(
                      child: Text(
                        'ငွေထုတ်နည်းမသိပါက ဆက်သွယ်ရန်',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Viber',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff002bc3),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '09777269997',
                                style: TextStyle(
                                    color: Color(0xff002bc3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Telegram',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff002bc3),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '09777269997',
                                style: TextStyle(
                                    color: Color(0xff002bc3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Phone',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xff002bc3),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '09777269997',
                                style: TextStyle(
                                    color: Color(0xff002bc3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff002bc3),
        appBar: AppBar(
          backgroundColor: Color(0xff002bc3),
          title: Text(
            'ငွေထုတ်မည်',
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
              child:
                  currentpage == 0 ? withdrawdetails1() : withdrawdetails2()),
        ),
      ),
    );
  }
}
