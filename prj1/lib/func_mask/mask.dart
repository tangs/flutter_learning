import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class _MaskUIState extends State<MaskUI> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: new Text("Mask"),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(32),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
            ],
        ),
        ),
      ),
    );
  }
  
}

class MaskUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MaskUIState();
  
}