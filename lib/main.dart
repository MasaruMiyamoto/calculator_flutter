import 'package:flutter/material.dart';

void main() => runApp(MyApp());

 double _buttonSize;

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
            Container(
              height: _buttonSize,
              width: 500,
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blueAccent)
                ),
              child: Text(
                '$_textString',
                style: TextStyle(fontSize: 80),
                textAlign: TextAlign.right,
            ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('AC'),
                _numberButton('+/-'),
                _numberButton('%'),
                _numberButton('÷'),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('7'),
                _numberButton('8'),
                _numberButton('9'),
                _numberButton('/')
              ],
            ),

            //SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('4'),
                _numberButton('5'),
                _numberButton('6'),
                _numberButton('*')
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('1'),
                _numberButton('2'),
                _numberButton('3'),
                _numberButton('-'),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _numberButton('0'),
                _numberButton('.'),
                _numberButton('='),
                _numberButton('+'),
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
        style: TextStyle(fontSize: 40),
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
