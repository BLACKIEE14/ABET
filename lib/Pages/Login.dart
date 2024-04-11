import 'package:abet/Component.dart/API.dart';
import 'package:abet/Pages/Showtoast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final txtconphone = TextEditingController();
  final txtconpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff002bc3),
        appBar: AppBar(
          backgroundColor: Color(0xff002bc3),
          title: Text(
            'ABet',
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
                  Center(
                    child: Text(
                      'အကောင့်ဝင်ရန်',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'ဖုန်းနံပါတ်',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: txtconphone,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      'စကားဝှက်',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    controller: txtconpassword,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: () async {
                        if (txtconphone.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 2))
                                  .then((value) => Navigator.of(context).pop());
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
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'ဖုန်းနံပါတ်ရိုက်ထည့်ပါ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
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
                        } else if (txtconpassword.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 2))
                                  .then((value) => Navigator.of(context).pop());
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
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'အတည်ပြုစကားဝှက်ရိုက်ထည့်ပါ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
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
                          Map response = await API.postUserLogin(
                              txtconphone.text, txtconpassword.text);
                          print("gagaga" + response.toString());
                          if (response["token"] != null) {
                            Box tempBox = Hive.box("Login");
                            tempBox.put("token", response["token"]);
                            tempBox.put("name", response["name"]);
                            tempBox.put("phone", response["phone"]);
                            tempBox.put("password", response["password"]);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/empty", (route) => false);
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff002bc3)),
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'စကားဝှက်မေ့နေလား?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/createaccount');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff002bc3)),
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffd3d4d5),
                        ),
                        child: Center(
                          child: Text(
                            'အကောင့်အသစ်ဖွင့်ရန်',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
