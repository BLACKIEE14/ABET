import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff002bc3)),
      child: Center(
          child: AnimatedTextKit(
        animatedTexts: [
          FadeAnimatedText('ခဏစောင့်ပါ...',
              textAlign: TextAlign.center,
              textStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      )),
    );
  }
}
