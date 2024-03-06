import 'package:abet/Pages/Toast.dart';
import 'package:flutter/material.dart';

class Depodetails extends StatefulWidget {
  const Depodetails({super.key});

  @override
  State<Depodetails> createState() => _DepodetailsState();
}

class _DepodetailsState extends State<Depodetails> {
  int selectetpayment = 0;
  String selectedamount = '';
  List amount = ['5,000', '10,000', '20,000', '50,000', '100,000', '200,000'];
  final TextEditingController txtcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff002bc3),
        appBar: AppBar(
          backgroundColor: Color(0xff002bc3),
          title: Text(
            'ငွေဖြည့်မည်',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ငွေသွင်းမည့်အမျိုးအစား',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (selectetpayment == 1) {
                                setState(() {
                                  selectetpayment = 0;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: selectetpayment == 0
                                      ? Border.all(color: Color(0xff002bc3))
                                      : Border.all(color: Colors.grey.shade400),
                                  color: selectetpayment == 0
                                      ? Colors.lightBlue.shade100
                                      : Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          'lib/Img/Kpay.png',
                                          height: 30,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'KBZ Pay',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
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
                            onTap: () {
                              if (selectetpayment == 0) {
                                setState(() {
                                  selectetpayment = 1;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: selectetpayment == 1
                                      ? Border.all(color: Color(0xff002bc3))
                                      : Border.all(color: Colors.grey.shade400),
                                  color: selectetpayment == 1
                                      ? Colors.lightBlue.shade100
                                      : Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          'lib/Img/wavepay.png',
                                          height: 30,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Wave Pay',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'ငွေသွင်းရမည့်အကောင့်',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff002bc3)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    selectetpayment == 1
                                        ? 'lib/Img/wavepay.png'
                                        : 'lib/Img/Kpay.png',
                                    height: 40,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kyaw Gyi',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    '09777269997',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.copy_rounded,
                                color: Color(0xff002bc3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '(noteတွင်တခုခုဖြည့်ပေးပါရန်)',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Amount',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: txtcon,
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
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Amount ရွေးပါ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 5,
                      children: [
                        ...amount.map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (selectedamount != e) {
                                txtcon.text = e;
                                setState(() {
                                  selectedamount = e;
                                });
                              }
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width -
                                      30 -
                                      10) /
                                  3,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedamount == e
                                      ? Color(0xff002bc3)
                                      : Colors.amber.shade200),
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: selectedamount == e
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (txtcon.text.isEmpty) {
                          showToast('အချက်အလက်များကိုပြည့်စုံအောင်ဖြည့်ပါ။',
                              isError: true);
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                              'ငွေဖြည့်နည်းမသိပါက ဆက်သွယ်ရန်',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
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
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
