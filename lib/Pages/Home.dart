import 'package:abet/Component.dart/API.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Map data = {};
final formatter = NumberFormat.decimalPattern();
List Slide = [];
bool isloading = false;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Map User = await API.getUserDetails();

      Slide = await API.getSlide();

      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color(0xff002bc3),
            title: Text(
              'BET',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            )),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xff002bc3),
            width: double.infinity,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.green),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Hive.box('Login').get('image') ==
                                              null
                                          ? Icon(
                                              Icons.person_outline_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            )
                                          : Image.network(
                                              Hive.box('Login').get('image'),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Hive.box('Login').get('name'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Hive.box('Login').get('balance') == null
                                            ? "0" + " Ks"
                                            : formatter
                                                    .format(Hive.box('Login')
                                                        .get('balance'))
                                                    .toString() +
                                                " Ks",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  isloading = true;
                                  setState(() {});
                                  Map User = await API.getUserDetails();

                                  Slide = await API.getSlide();
                                  isloading = false;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color(0xff002bc3)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: isloading == true
                                        ? SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ))
                                        : Icon(
                                            Icons.refresh,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/depodetails');
                                      },
                                      child: Container(
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xff002bc3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.monetization_on_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        'ငွေဖြည့်',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/withdetails');
                                      },
                                      child: Container(
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xff002bc3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            FontAwesomeIcons.coins,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        'ငွေထုတ်',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/depohistory');
                                      },
                                      child: Container(
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xff002bc3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.sticky_note_2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        'မှတ်တမ်း',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            width: double.infinity,
                            height: 200,
                            child: CarouselSlider(
                                items: [
                                  ...Slide.map((e) => Advertisement(
                                        e: e,
                                      ))
                                ],
                                options: CarouselOptions(
                                  height: 200,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: false,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  onPageChanged: (index, reason) {},
                                  scrollDirection: Axis.horizontal,
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xff002bc3)),
                          child: Marquee(
                            text: '"A Bet" မှမိတ်ဆွေများအားကြိုဆိုပါတယ်။',
                            blankSpace: 150,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // Container(
                      //   height: 300,
                      //   child: Image.network(
                      //     "https://backend.kam2d.com/slide/1700974547-3KxNY9tLWn.png",
                      //     fit: BoxFit.fill,
                      //     errorBuilder: (BuildContext context, Object expection,
                      //         StackTrace? stackTrace) {
                      //       return Text(
                      //         'Sorry',
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold),
                      //       );
                      //     },
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor: Color(0xff002bc3),
                                        child: Container(
                                          height: 200,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xff002bc3)),
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/2Ddetailspage');
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white),
                                                      child: Center(
                                                        child: Text(
                                                          '2D (မနက်ပိုင်း) ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/2Devening');
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white),
                                                      child: Center(
                                                        child: Text(
                                                          '2D (ညနေပိုင်း) ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff002bc3), width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        '2D',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff002bc3), width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      '3D',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff002bc3), width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'ဘော်ဒီ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff002bc3), width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'မောင်း',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Color(0xff002bc3),
                      //     ),
                      //     height: 100,
                      //     width: double.infinity,
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             children: [
                      //               Expanded(
                      //                 child: Center(
                      //                   child: Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Icon(
                      //                         Icons.check_circle,
                      //                         size: 20,
                      //                         color: Colors.white,
                      //                       ),
                      //                       SizedBox(
                      //                         width: 2,
                      //                       ),
                      //                       Text(
                      //                         '12:01 PM',
                      //                         style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontWeight: FontWeight.w800,
                      //                             fontSize: 20),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: Center(
                      //                   child: Text(
                      //                     '33',
                      //                     style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontWeight: FontWeight.w800,
                      //                         fontSize: 30),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             children: [
                      //               Expanded(
                      //                 child: Center(
                      //                   child: Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Icon(
                      //                         Icons.check_circle,
                      //                         size: 20,
                      //                         color: Colors.white,
                      //                       ),
                      //                       SizedBox(
                      //                         width: 2,
                      //                       ),
                      //                       Text(
                      //                         '4:30 PM',
                      //                         style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontWeight: FontWeight.w800,
                      //                             fontSize: 20),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: Center(
                      //                   child: Text(
                      //                     '--',
                      //                     style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontWeight: FontWeight.w800,
                      //                         fontSize: 30),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class Advertisement extends StatelessWidget {
  const Advertisement({
    required this.e,
    super.key,
  });

  final Map e;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Image.network(
        e['image'],
        fit: BoxFit.cover,
        errorBuilder: (context, expection, stackTrace) {
          return Center(
              child: Image.asset(
            'lib/Img/placeholderr.jpeg',
            height: double.infinity,
            fit: BoxFit.cover,
          ));
        },
      ),
    );
  }
}
