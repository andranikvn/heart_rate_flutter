import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:heart_rate_flutter/heart_rate_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HeartRateFlutter _heartRateFlutterPlugin = HeartRateFlutter();

  var heartBeatValue = 0;

  @override
  void initState() {
    _heartRateFlutterPlugin.init();
    _listener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Text("Heart beat $heartBeatValue"),
      )),
    );
  }

  void _listener() {
    _heartRateFlutterPlugin.heartBeatStream.listen((double event) {
      if (mounted) {
        setState(() {
          heartBeatValue = event.toInt();
        });
      }
    });
  }
}
