import 'package:flutter/material.dart';

class TipsTab extends StatefulWidget {
  @override
  _TipsTabState createState() => _TipsTabState();
}

class _TipsTabState extends State<TipsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tips',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.yellow[100],
    );
  }
}