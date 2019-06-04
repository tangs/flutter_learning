import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/widget_tools.dart';
import 'config.dart';

class _MaskUIState extends State<MaskUI> {

  final String username;
  final String token;
  Map<String, dynamic> dataStates;
  List<String> logs = List();
  String version = '';
  String channels = '';

  _MaskUIState(this.username, this.token);

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
        // _clearData();
        final String type = data['type'];
        final String value = data['value'];
        // final String value = '<1:<2:<4';
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
            _clearData();
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

  void _publish() {
    final String base = 'username=$username&token=$token&version=$version&channel=$channels';
    dataStates.forEach((k, v) async {
      String value = '';
      for (Map data in v) {
        if (data['select'] == true) {
          final key = data['key'];
          value += '$key:';
        }
      }
      if (value.length > 0) {
        value = value.substring(0, value.length - 1);
      }
      final String postData = '$base&type=$k&value=$value';
      HttpClient client = new HttpClient();
      final request = await client.postUrl(Uri.parse('${Config.publishAddr}?$postData'));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        response.transform(utf8.decoder).listen((contents) {
          // print(contents);
            if (contents != null && contents.length > 0) {
            final jsonData = JsonDecoder().convert(contents);
            if (jsonData['result'] == 'true') {
              // showToast(context, '设置成功.');
            }
            }
          logs.insert(0, contents);
          update();
        });
      } else {
        // print('Error get:\nHttp status ${response.statusCode}');    //连接错误提示
        logs.insert(0, 'Error get:\nHttp status ${response.statusCode}');
        update();
      }
      // }
    });
  }

  void syncConfig() async {
    HttpClient client = new HttpClient();
    final url = '${Config.reloadAddr}';
    final request = await client.postUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        response.transform(utf8.decoder).listen((contents) {
          // print(contents);
          // if (contents != null && contents.length > 0) {
          //   final jsonData = JsonDecoder().convert(contents);
          //   // if (jsonData['result'] == 'true') {
          //   //   // showToast(context, '发布成功.');
          //   // }
          // }
          logs.insert(0, contents);
          update();
        });
      } else {
        // print('Error get:\nHttp status ${response.statusCode}');    //连接错误提示
        logs.insert(0, 'Error get:\nHttp status ${response.statusCode}');
        update();
      }
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
                          if (checkParams(context)) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String alert = '';
                                dataStates.forEach((k, v) {
                                  alert += '$k:[';
                                  for (Map data in v) {
                                    if (data['select'] == true) {
                                      final show = data['show'];
                                      alert += '$show,';
                                    }
                                  }
                                  alert += ']\n\n';
                                });
                                alert += 'Confirm publish?';
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text(alert),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _publish();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text('Sync'),
                        onPressed: () {
                          if (checkParams(context)) {
                            syncConfig();
                          }
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
  final String username;
  final String token;

  const MaskUI({Key key, this.username, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MaskUIState(username, token);
  
}