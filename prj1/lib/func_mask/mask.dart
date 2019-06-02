import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../utils/widget_tools.dart';
import 'config.dart';

class _MaskUIState extends State<MaskUI> {

  final String token;
  Map<String, dynamic> dataStates;
  List<String> logs = List();
  String version = '';
  String channels = '';

  _MaskUIState(this.token);

  void update() {
    setState(() {
      
    });
  }

  void _updateParams(String src, List dest) {
    final hideParas = src.split(':');
    for (Map para in dest) {
      bool isHide = false;
      String key = para['key'];
      for (String hidePara in hideParas) {
        if (key == hidePara) {
          isHide = true;
          break;
        }
      }
      para['select'] = isHide;
    }
  }

  void _clearData() {
    dataStates.forEach((k, v) {
      for (final para in v) {
        para['select'] = false;
      }
    });
  }

  void _updateQueryData(String data) {
    dynamic pars = JsonDecoder().convert(data);
    for (dynamic data in pars) {
      if (data['version'] == version && data['channel'] == channels) {
        _clearData();
        final String type = data['type'];
        // final String value = data['value'];
        final String value = '<1:<2:<4';
        switch (type) {
          case 'hall': {
            _updateParams(value, dataStates['hall']);
          }
          break;
          case 'pay': {
            _updateParams(value, dataStates['pay']);
          }
          break;
        }
      }
    }
  }

  void query() {
    HttpClient client = new HttpClient();
    final url = '${Config.queryAddr}?version=$version&channel=$channels';
    client.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((contents) {
        bool isSucss = false;
        String errMsg = '';
        if (contents != null && contents.length > 0) {
          final jsonData = JsonDecoder().convert(contents);
          if (jsonData['result'] == 'true') {
            isSucss = true;
            String param = jsonData['param'];
            // logs.add(param);
            String time = DateTime.now().toString();
            _updateQueryData(param);
            logs.insert(0, 'query $time:$param');
            update();
          } else {
            if (jsonData['param'] != null) {
              errMsg = jsonData['param'];
            }
          }
        }
        if (!isSucss) {
          showToast(context, errMsg);
        }
       });
    }).catchError((err) {
     showToast(context, '链接错误');
    });
  }

  void showToast(BuildContext context, String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  bool checkParams(BuildContext context) {
    if (version.length == 0) {
      showToast(context, 'Version mast not null.');
      return false;
    }
    if (channels.length == 0) {
      showToast(context, 'Channels mast not null.');
      return false;
    }
    return true;
  }

  Widget _buildItem(BuildContext context, String section) {
    final size = MediaQuery.of(context).size;
    final int cols = size.width ~/ 200;
    final data = dataStates[section];
    return GridView.count(
      crossAxisCount: cols,
      childAspectRatio: 4.5,
      children: List.generate(data.length, (index) {
        // logs.add(data[index]['show']);
        final isSelcted = data[index]['select'] == true;
        return Row(
          // child: Text(data[index]['show']),
          children: <Widget>[
            Checkbox(
              value: isSelcted,
              onChanged: (isSelected) {
                update();
                data[index]['select'] = isSelected;
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
        // final jsonData = JsonDecoder().convert(snapshot.data);
        if (dataStates == null) {
          dataStates = JsonDecoder().convert(snapshot.data);
        }
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: new AppBar(
            title: new Text("Mask"),
          ),
          body: Builder(
            builder: (context) => Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: <Widget>[
                  WidgetTools.buildTextField('version', TextInputType.text, (String text) {
                    version = text;
                  }, version),
                  WidgetTools.buildTextField('channels', TextInputType.text, (String text) {
                    channels = text;
                  }, channels),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Query'),
                        onPressed: () {
                          if (checkParams(context)) {
                            query();
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text('Publish'),
                        onPressed: () {
                          checkParams(context);
                        },
                      ),
                    ]
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Pay',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ),
                  Expanded(
                    child: _buildItem(context, 'pay'),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'hall',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ),
                  Expanded(
                    child: _buildItem(context, 'hall'),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'log',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: ListView.builder(
                        itemCount: logs.length,
                        itemBuilder: (BuildContext context,int index){
                          return new Text(logs[index]);
                        },
                      ),
                    ),
                  ),
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
  final String token;

  const MaskUI({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MaskUIState(token);
  
}