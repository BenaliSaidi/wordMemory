// ignore_for_file: file_names

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_words/views/myWordList.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      runApp(const MaterialApp(home: MyWordList()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ignore: sized_box_for_whitespace
          const SizedBox(
            height: 160,
          ),
          SizedBox(
            height: 300,
            width: 600,
            child: Lottie.asset("assets/anim.json"),
          ),

          SizedBox(
            height: 50,
          ),

          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 40,
                color: const Color(0xff7FB77E),
                fontWeight: FontWeight.bold),
            child: AnimatedTextKit(
                //pause: const Duration(milliseconds: 3000),
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Word Memory',
                    speed: const Duration(milliseconds: 120),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
