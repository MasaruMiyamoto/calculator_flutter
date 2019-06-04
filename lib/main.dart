import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final double _buttonSize = 60.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: _numberButtonThemeData(),
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }

  //buttonのテーマ
  ButtonThemeData _numberButtonThemeData(){
    return ButtonThemeData(
      minWidth: _buttonSize,
      height: _buttonSize,
      textTheme: ButtonTextTheme.primary,
      buttonColor: Colors.yellow,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _textString = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            print('button test');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //テキスト表示領域
            Text(
              '$_textString',
              style: Theme.of(context).textTheme.display1,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('7'),
                SizedBox(width: 5,),
                _numberButton('8'),
                SizedBox(width: 5,),
                _numberButton('9'),
              ],
            ),

            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('4'),
                SizedBox(width: 5,),
                _numberButton('5'),
                SizedBox(width: 5,),
                _numberButton('6'),
              ],
            ),

            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('1'),
                SizedBox(width: 5,),
                _numberButton('2'),
                SizedBox(width: 5,),
                _numberButton('3'),
              ],
            ),

          ],
        ),
      ),
    );
  }

  RaisedButton _numberButton(String _num) {
    return RaisedButton(
      child: Text(
        _num,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        print('button $_num selected');
        setState(() {
          _textString = _textString + _num;
        });
      },
    );
  }
}
