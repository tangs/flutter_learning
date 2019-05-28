import 'package:flutter/material.dart';

class UI2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      'images/2.jpeg',
      // width: 440,
      fit: BoxFit.fitWidth,  
    );
    final top = Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 13,
                ),
                textAlign: TextAlign.left,
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.red[500],
              ),
              Text('41'),
            ],
          ),
        ],
      ),
    );
    final mid = Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.call,
                color: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              ),
              Text(
                'CALL',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.near_me,
                color: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              ),
              Text(
                'ROUTE',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.share,
                color: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              ),
              Text(
                'SHARE',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    final bottom = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 30),
      child: Text(
        "This guide then takes a step back to explain Flutter’s approach to layout, and shows how to place a single widget on the screen. After a discussion of how to lay widgets out horizontally and vertically, some of the most common layout widgets are covered.\nIf you want a “big picture” understanding of the layout mechanism, start with Flutter’s approach to layout.\nIn Flutter, a Card features slightly rounded corners and a drop shadow, giving it a 3D effect. Changing a Card’s elevation property allows you to control the drop shadow effect. Setting the elevation to 24, for example, visually lifts the Card further from the surface and causes the shadow to become more dispersed. For a list of supported elevation values, see Elevation in the Material guidelines. Specifying an unsupported value disables the drop shadow entirely.",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return MaterialApp(
      title: 'UI2',
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            image,
            top,
            mid,
            bottom,
          ],
        ),
      ),
    );
  }  
}