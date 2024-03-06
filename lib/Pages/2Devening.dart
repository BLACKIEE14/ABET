import 'dart:async';

import 'package:abet/Component.dart/colors.dart';
import 'package:flutter/material.dart';

class TwoDevening extends StatefulWidget {
  const TwoDevening({super.key});

  @override
  State<TwoDevening> createState() => _TwoDeveningState();
}

class _TwoDeveningState extends State<TwoDevening> {
  final TextEditingController txtcontroller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  void _insertText(String myText) {
    final text = txtcontroller.text;
    final textSelection = txtcontroller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    txtcontroller.text = newText;
    txtcontroller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace(String text) {
    final text = txtcontroller.text;
    final textSelection = txtcontroller.selection;
    final selectionLength =
        textSelection.end - textSelection.start; // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      txtcontroller.text = newText;
      txtcontroller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    } // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    } // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    txtcontroller.text = newText;
    txtcontroller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff002bc3),
          title: Text(
            '2D (ညနေပိုင်း)',
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
            ),
            child: Container(
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Headline(),
                          Headline(),
                          Headline(),
                        ],
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Voucher(),
                            Voucher(),
                            Voucher(),
                            Voucher(),
                            // Voc2(),
                            // Voc2(),
                            // Voc2(),
                            // Voc2(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLines: null,
                                  // expands: true,
                                  focusNode: _focusNode,
                                  showCursor: true,
                                  controller: txtcontroller,
                                  readOnly: true,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText:
                                        "ဂဏန်းရိုက် - ငွေရိုက် - ENTERခေါက်",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  print('gwenchana');
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: KAMColors.red),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                        child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          KAMKeyboard(
                            con: txtcontroller,
                            enterAction: () {
                              txtcontroller.text += "\n";
                            },
                            printAction: () {},
                            // willInkwell: true,
                          ),
                        ],
                      ),
                    ),
                  )
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: SizedBox(
                  //     child: TextField(
                  //       focusNode: _focusNode,
                  //       showCursor: true,
                  //       controller: txtcontroller,
                  //       readOnly: true,
                  //       style: TextStyle(color: Colors.black),
                  //       decoration: InputDecoration(
                  //         hintText: "ဂဏန်းရိုက် - ငွေရိုက် - ENTERခေါက်",
                  //         hintStyle: TextStyle(color: Colors.grey.shade400),
                  //         contentPadding:
                  //             EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //           borderSide: BorderSide(color: Colors.black),
                  //         ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //           borderSide: BorderSide(color: Colors.black),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  //   child: Container(
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         IntrinsicHeight(
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('0');
                  //                   },
                  //                   child: Container(
                  //                     height: 35,
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "0",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('1');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "1",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('2');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "2",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('3');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "3",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('4');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "4",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('5');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "5",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('6');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "6",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('7');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "7",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('8');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "8",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 3,
                  //               ),
                  //               Expanded(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     _insertText('9');
                  //                   },
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "9",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 3),
                  //           child: IntrinsicHeight(
                  //             child: Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "R",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "အခွေ",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "ညီကို",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "နက္ခတ်",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 3),
                  //           child: IntrinsicHeight(
                  //             child: Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "အခွေ(ပူးပါ)",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "ပါဝါ",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "မပိတ်",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                         border:
                  //                             Border.all(color: Colors.black38),
                  //                         borderRadius: BorderRadius.circular(8),
                  //                         color: Color(0xff002bc3)),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "စုံပိတ်",
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 3),
                  //           child: IntrinsicHeight(
                  //             child: Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       Container(
                  //                         decoration: BoxDecoration(
                  //                             border: Border.all(
                  //                                 color: Colors.black38),
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8),
                  //                             color: Color(0xff002bc3)),
                  //                         child: Center(
                  //                           child: Text(
                  //                             "စုံစုံ",
                  //                             style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.only(top: 3),
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                               border: Border.all(
                  //                                   color: Colors.black38),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(8),
                  //                               color: Color(0xff002bc3)),
                  //                           child: Center(
                  //                             child: Text(
                  //                               "စုံမ",
                  //                               style: TextStyle(
                  //                                   color: Colors.white,
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.bold),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       Container(
                  //                         decoration: BoxDecoration(
                  //                             border: Border.all(
                  //                                 color: Colors.black38),
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8),
                  //                             color: Color(0xff002bc3)),
                  //                         child: Center(
                  //                           child: Text(
                  //                             "မမ",
                  //                             style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.only(top: 3),
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                               border: Border.all(
                  //                                   color: Colors.black38),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(8),
                  //                               color: Color(0xff002bc3)),
                  //                           child: Center(
                  //                             child: Text(
                  //                               "မစုံ",
                  //                               style: TextStyle(
                  //                                   color: Colors.white,
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.bold),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       GestureDetector(
                  //                         onTap: () {
                  //                           _backspace("");
                  //                         },
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                               border: Border.all(
                  //                                   color: Colors.black38),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(8),
                  //                               color: Colors.red),
                  //                           child: Center(
                  //                               child: Padding(
                  //                             padding: const EdgeInsets.symmetric(
                  //                                 vertical: 4),
                  //                             child: Icon(
                  //                               Icons.backspace,
                  //                               color: Colors.white,
                  //                               size: 23,
                  //                             ),
                  //                           )),
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.only(top: 3),
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                               border: Border.all(
                  //                                   color: Colors.black38),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(8),
                  //                               color: Colors.blueGrey.shade600),
                  //                           child: Center(
                  //                             child: Padding(
                  //                               padding:
                  //                                   const EdgeInsets.symmetric(
                  //                                       vertical: 4),
                  //                               child: Text(
                  //                                 "=",
                  //                                 style: TextStyle(
                  //                                     color: Colors.white,
                  //                                     fontSize: 22,
                  //                                     fontWeight:
                  //                                         FontWeight.bold),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 3,
                  //                 ),
                  //                 Expanded(
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       Expanded(
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                               border: Border.all(
                  //                                   color: Colors.black38),
                  //                               borderRadius:
                  //                                   BorderRadius.circular(8),
                  //                               color: Colors.blueGrey.shade600),
                  //                           child: Center(
                  //                             child: Text(
                  //                               "ENTER",
                  //                               style: TextStyle(
                  //                                   color: Colors.white,
                  //                                   fontSize: 16,
                  //                                   fontWeight: FontWeight.bold),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )),
      ),
    );
  }
}

class Voc2 extends StatelessWidget {
  const Voc2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '78 500',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      '500',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                '00-1000000',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                '00-10000000',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                '00-10000000',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                '00-10000000',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Voucher extends StatelessWidget {
  const Voucher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.shade100,
                border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '25',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            '50000',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '25',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            '50000',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '25',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            '50000',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '20-02-2024',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Total :',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            '50000',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class KAMKeyboard extends StatefulWidget {
  final Function enterAction;
  final Function printAction;
  final TextEditingController con;
  final bool willInkwell;

  const KAMKeyboard(
      {required this.con,
      required this.enterAction,
      required this.printAction,
      this.willInkwell = true,
      super.key});

  @override
  State<KAMKeyboard> createState() => _KAMKeyboardState();
}

class _KAMKeyboardState extends State<KAMKeyboard> {
  void _insertText(String myText) {
    final text = widget.con.text;
    final textSelection = widget.con.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    widget.con.text = newText;
    widget.con.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace(String text) {
    final text = widget.con.text;
    final textSelection = widget.con.selection;
    final selectionLength =
        textSelection.end - textSelection.start; // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      widget.con.text = newText;
      widget.con.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    } // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    } // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    widget.con.text = newText;
    widget.con.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  void _enter(String text) {
    widget.enterAction();
  }

  void _printOut(String text) {
    widget.printAction();
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            KAMKey(
              bg: Theme.of(context).colorScheme.inversePrimary,
              text: "P",
              action: _insertText,
              child: Text(
                "P",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 4),
            KAMKey(
              xfactor: 2,
              bg: Theme.of(context).colorScheme.inversePrimary,
              text: "R",
              action: _insertText,
              child: Text(
                "R",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 4),
            KAMKey(
              bg: KAMKeyColors.red,
              action: _backspace,
              text: "delete",
              child: Icon(
                Icons.backspace_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            KAMKey(
              bg: Theme.of(context).colorScheme.inversePrimary,
              text: "A",
              action: _insertText,
              child: Text(
                "A",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 4),
            KAMKey(
              bg: Theme.of(context).colorScheme.inversePrimary,
              text: "B",
              action: _insertText,
              child: Text(
                "B",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "7",
                  action: _insertText,
                  child: Text(
                    "7",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "4",
                  action: _insertText,
                  child: Text(
                    "4",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "1",
                  action: _insertText,
                  child: Text(
                    "1",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "0",
                  action: _insertText,
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "8",
                  action: _insertText,
                  child: Text(
                    "8",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "5",
                  action: _insertText,
                  child: Text(
                    "5",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "2",
                  action: _insertText,
                  child: Text(
                    "2",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "00",
                  action: _insertText,
                  child: Text(
                    "00",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "9",
                  action: _insertText,
                  child: Text(
                    "9",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "6",
                  action: _insertText,
                  child: Text(
                    "6",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "3",
                  action: _insertText,
                  child: Text(
                    "3",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  bg: Theme.of(context).colorScheme.primary,
                  inkwell: widget.willInkwell,
                  text: "000",
                  action: _insertText,
                  child: Text(
                    "000",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Colors.green,
                  action: _printOut,
                  child: Icon(
                    Icons.download,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  text: "=",
                  action: _insertText,
                  bg: Color(0xFF0183FB),
                  child: Text(
                    "=",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  yfactor: 2,
                  action: _enter,
                  bg: Colors.blue.shade900,
                  child: Text(
                    "Enter",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "W",
                  action: _insertText,
                  child: Text(
                    "W",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "N",
                  action: _insertText,
                  child: Text(
                    "N",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "X",
                  action: _insertText,
                  child: Text(
                    "X",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "F",
                  action: _insertText,
                  child: Text(
                    "F",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "J",
                  action: _insertText,
                  child: Text(
                    "J",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "K",
                  action: _insertText,
                  child: Text(
                    "K",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "S",
                  action: _insertText,
                  child: Text(
                    "S",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                KAMKey(
                  inkwell: widget.willInkwell,
                  bg: Theme.of(context).colorScheme.inversePrimary,
                  text: "M",
                  action: _insertText,
                  child: Text(
                    "M",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class KAMKey extends StatefulWidget {
  final double xfactor;
  final double yfactor;
  final Widget child;
  final Color? bg;
  final String text;
  final Function action;
  final bool inkwell;

  const KAMKey({
    required this.child,
    required this.action,
    this.bg,
    this.xfactor = 1,
    this.yfactor = 1,
    this.text = "",
    this.inkwell = true,
    super.key,
  });

  @override
  State<KAMKey> createState() => _KAMKeyState();
}

class _KAMKeyState extends State<KAMKey> {
  @override
  Widget build(BuildContext context) {
    // final dynamic prov = Hive.box("KAM_login").get('appType') == "3D"
    //     ? Provider.of<TempProv3D>(context, listen: false)
    //     : Provider.of<TempProv>(context, listen: false);
    // final soundProv = Provider.of<SoundProvider>(context);

    final double avgSize =
        (MediaQuery.of(context).size.width - 24 - (4 * 5)) / 6;
    double extraWid = (widget.xfactor - 1) * 4;
    double extraHeig = (widget.yfactor - 1) * 4;

    Timer? deleting;

    Future<void> tap() async {
      // showToast("${context.size}");

      try {
        // print("yeh ${prov.mainFocus.hasFocus}");
        // prov.mainFocus.requestFocus();
        // print("yeh ${prov.mainFocus.hasFocus}");
      } catch (e) {
        try {
          print("nah");
          // FocusScope.of(context).requestFocus(prov.loginFocus);
        } catch (e) {
          print("bruh");
          print(e);
        }
      }

      widget.action(widget.text);
      // await Audio.playTap();
    }

    // print("${context.size}");

    return widget.inkwell
        ? InkWell(
            onTap: () async {
              await tap();
            },
            onTapDown: widget.text == "delete"
                ? (t) {
                    deleting =
                        Timer.periodic(Duration(milliseconds: 150), (timer) {
                      print("deleteee");
                      widget.action("");
                    });
                  }
                : (t) {},
            onTapUp: widget.text == "delete"
                ? (t) {
                    deleting!.cancel();
                  }
                : (t) {},
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(width: 1, color: Colors.black.withOpacity(.1)),
                // color: Colors.green,
                color: widget.bg == null
                    ? Theme.of(context).colorScheme.primary
                    : widget.bg,
              ),
              height: (avgSize - 16) * widget.yfactor + extraHeig,
              width: avgSize * widget.xfactor + extraWid,
              child: Center(child: widget.child),
            ),
          )
        : GestureDetector(
            onTap: () async {
              await tap();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(width: 1, color: Colors.black.withOpacity(.2)),
                color: widget.bg,
              ),
              height: avgSize * widget.yfactor + extraHeig,
              width: avgSize * widget.xfactor + extraWid,
              child: Center(child: widget.child),
            ),
          );
  }
}
