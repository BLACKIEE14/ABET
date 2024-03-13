import 'package:abet/Component.dart/API.dart';
import 'package:abet/Component.dart/loading.dart';
import 'package:abet/Pages/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Depodetails extends StatefulWidget {
  const Depodetails({super.key});

  @override
  State<Depodetails> createState() => _DepodetailsState();
}

List incomedata = [];
bool isloading = true;

class _DepodetailsState extends State<Depodetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      incomedata = await API.getPaymentMethod();

      selectetpayment = incomedata[0]['id'];
      selectetpaymentmethod = incomedata[0];
      isloading = false;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  int currentpage = 0;
  int? selectetpayment;
  Map? selectetpaymentmethod;
  String selectedamount = '';
  List amount = ['5,000', '10,000', '20,000', '50,000', '100,000', '200,000'];
  final TextEditingController txtconamount = TextEditingController();
  final TextEditingController txtcontransit = TextEditingController();

  Widget Depostep2() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 200,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  selectetpaymentmethod!['image'],
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectetpaymentmethod!['name'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "  နှင့်ငွေဖြည့်မည်",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'လုပ်ငန်းစဥ်နံပါတ် ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                '(နောက်ဆုံးဂဏန်း ၆ လုံး)',
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: txtcontransit,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "လုပ်ငန်းစဥ်နံပါတ်၏ နောက်ဆုံးဂဏန်း ၆လုံး ထည့်ပါ",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Row(
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
                    if (txtcontransit.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              height: 150,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff002bc3)),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'လုပ်ငန်းစဥ်နံပါတ် ရိုက်ထည့်ပါ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      Map response = await API.postPayment(
                        selectetpaymentmethod!['id'],
                        txtcontransit.text,
                        txtconamount.text,
                      );
                      showToast("ငွေဖြည့်ခြင်းအောင်မြင်ပါသည်။");
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
                        'ငွေဖြည့်နည်းမသိပါက ဆက်သွယ်ရန်',
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

  Widget Depostep1() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ငွေသွင်းမည့်အမျိုးအစား',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: selectetpayment == null
                ? Placeholder(
                    child: Image.asset(
                      'lib/Img/placeholderr.jpg',
                      height: 30,
                      width: 30,
                    ),
                  )
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
                          child: selectetpaymentmethod == null
                              ? Placeholder(
                                  child: Image.asset(
                                    'lib/Img/placeholderr.jpg',
                                    height: 30,
                                    width: 30,
                                  ),
                                )
                              : Image.network(
                                  selectetpaymentmethod!['image'],
                                  height: 30,
                                  width: 30,
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
                          selectetpaymentmethod == null
                              ? CircularProgressIndicator()
                              : Text(
                                  selectetpaymentmethod!['account_name'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                          selectetpaymentmethod == null
                              ? CircularProgressIndicator()
                              : Text(
                                  selectetpaymentmethod!['account_number'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(
                              text: selectetpaymentmethod!['account_number']));
                          showToast("Copied to clipboard");
                        },
                        child: Icon(
                          Icons.copy_rounded,
                          color: Color(0xff002bc3),
                        ),
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
                  color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
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
              controller: txtconamount,
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
                        txtconamount.text = e;
                        setState(() {
                          selectedamount = e;
                        });
                      }
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 30 - 10) / 3,
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
                if (txtconamount.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff002bc3)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Amount ရိုက်ထည့်ပါ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
                      'ငွေဖြည့်နည်းမသိပါက ဆက်သွယ်ရန်',
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
          child: isloading
              ? Center(child: loading())
              : SingleChildScrollView(
                  child: currentpage == 0 ? Depostep1() : Depostep2(),
                ),
        ),
      ),
    );
  }
}
