import 'package:flutter/material.dart';

class UI1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      'Strawberry Pavlova',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 24,
      ),
    );
    final title = Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: titleText,
    );

    final subTitle = Text(
      'Heat oven to 150C/130C fan/gas 2.\n Using a pencil, mark out the circumference of a dinner plate on baking parchment. ',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );

    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
    final ratings = Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          stars,
          Text(
            '170 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

    final iconList = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.kitchen,
                color: Colors.green,
              ),
              Text('PREP:'),
              Text('25 min'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.timer,
                color: Colors.green,
              ),
              Text('COOK:'),
              Text('1 hr'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.restaurant,
                color: Colors.green,
              ),
              Text('PREP:'),
              Text('25 min'),
            ],
          ),
        ],
      ),
    );

    final leftColumn = Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          title,
          subTitle,
          ratings,
          iconList,
        ],
      ),
    );

    final mainImage = Expanded(
      child: Image.asset('images/1.jpg')
    );

    return MaterialApp(
      title: 'UI1',
      home: Scaffold(
        appBar: AppBar(
          title: Text('UI1 demo.'),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 600,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 400,
                    child: leftColumn,
                  ),
                  mainImage,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
