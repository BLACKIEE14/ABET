import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                'Service ဖုန်းနံပါတ်များ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'နေ့စဉ်(၂၄)နာရီ ၊ ပိတ်ရက်မရှိ ဝန်ဆောင်ပေးနေပါသည်။',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: Column(children: [
                          Row(
                            children: [
                              Image.asset(
                                'lib/Img/viber.png',
                                height: 60,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Viber ဖြင့်ဆက်သွယ်ရန်',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '2D Winner',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        '09777269997',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.phone,
                                    size: 28,
                                    color: Color(0xff002bc3),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider()
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: Column(children: [
                          Row(
                            children: [
                              Image.asset(
                                'lib/Img/tele.png',
                                height: 60,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Telegram ဖြင့်ဆက်သွယ်ရန်',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '2D Winner',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        '09777269997',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.phone,
                                    size: 28,
                                    color: Color(0xff002bc3),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider()
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: Column(children: [
                          Row(
                            children: [
                              Image.asset(
                                'lib/Img/phone.png',
                                height: 60,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Mobile ဖြင့်ဆက်သွယ်ရန်',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '2D Winner',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        '09777269997',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.phone,
                                    size: 28,
                                    color: Color(0xff002bc3),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
