import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../utils/widget_tools.dart';

class _MaskUIState extends State<MaskUI> {
  Widget _buildItem(BuildContext context, List data) {
    final size = MediaQuery.of(context).size;
    final int cols = size.width ~/ 200;
    return GridView.count(
      crossAxisCount: cols,
      childAspectRatio: 2.5,
      children: List.generate(data.length, (index) {
        return Row(
          // child: Text(data[index]['show']),
          children: <Widget>[
            Checkbox(
              value: true,
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
      future: DefaultAssetBundle.of(context).loadString('assets/config.json'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return  Scaffold();
        }
        final jsonData = JsonDecoder().convert(snapshot.data);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: new AppBar(
            title: new Text("Mask"),
          ),
          body: Builder(
            builder: (context) => Container(
              padding: EdgeInsets.all(32),
              // child: _buildItem(context, jsonData['pay']),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Pay'),
                    ]
                  ),
                  Expanded(
                    child: _buildItem(context, jsonData['pay'])
                  ),
                  Row(
                    children: <Widget>[
                      Text('hall'),
                    ]
                  ),
                  Expanded(
                    child: _buildItem(context, jsonData['hall'])
                  ),
                  WidgetTools.buildTextField('version', TextInputType.text, (String text) {
                    // username = text;
                  }),
                  WidgetTools.buildTextField('chanels', TextInputType.text, (String text) {
                    // username = text;
                  }),
                  // _buildItem(context, jsonData['hall']),
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