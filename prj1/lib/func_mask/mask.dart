import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class _MaskUIState extends State<MaskUI> {
  Widget _buildItem(BuildContext context, List data) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(data.length, (index) {
        return Row(
          children: <Widget>[
            Checkbox(
              value: false,
              onChanged: (isSelected) {

              },
            ),
            Text(data[index]['show']),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/1.json'),
      builder: (context, snapshot) {
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
                  // _buildItem(context, snapshot.data['pay']),
                  // _buildItem(context, snapshot.data['hall']),
                ],
            ),
            ),
          ),
        );
      },
    );
  }
  
}

class MaskUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MaskUIState();
  
}