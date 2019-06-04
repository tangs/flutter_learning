// import 'dart:_http';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../utils/widget_tools.dart';
import 'mask.dart';
import 'config.dart';

class _LoginUIState extends State<LoginUI> {
  String username = 'tangs';
  String password = 'Slot2018';

  void showToast(BuildContext context, String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(new SnackBar(
      content: new Text(msg),
      // action: SnackBarAction(
      //   label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  void loginReqest(BuildContext context) {
    if (username == null || username.length == 0) {
      showToast(context, '用户名不能为空');
      return;
    }
    if (password == null || password.length == 0) {
      showToast(context, '密码不能为空');
      return;
    }
    HttpClient client = new HttpClient();
    final content = new Utf8Encoder().convert('$username$password');
    final String token = md5.convert(content).toString();
    final url = '${Config.loginAddr}?username=$username&token=$token';
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
            String token = jsonData['param'];
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new MaskUI(
                username: username,
                token: token,
              )),
            );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(32),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  WidgetTools.buildTextField('username', TextInputType.text, (String text) {
                    username = text;
                  }, ''),
                  WidgetTools.buildTextField('password', TextInputType.text, (String text) {
                    password = text;
                  }, ''),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              RaisedButton(
                child: Text('Login'), 
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  loginReqest(context);
                },
              ),
            ],
        ),
        ),
      ),
    );
  }
}

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginUIState();
  
}
