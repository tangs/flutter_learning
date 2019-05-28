import 'package:flutter/material.dart';

class UI2App extends StatelessWidget {

  Column _buildButtonColumn(Color color, IconData iconData, String label) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          color: color,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }

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
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey,
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
          _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
          _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
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