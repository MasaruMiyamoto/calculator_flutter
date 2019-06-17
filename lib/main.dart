import 'package:flutter/material.dart';

void main() => runApp(MyApp());

 final double _buttonSize = 90;

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
      textTheme: ButtonTextTheme.primary,
      buttonColor: Colors.blue,
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

  String _textString = "0";  //画面表示用
  String _sign = "";          //符号

  String _beforeValue = "";   //初めの入力値
  String _afterValue = "";    //後の入力値

  bool _isPushValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child:Column(
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
                  _button("AC"),
                  _button("+/-"),
                  _button('%'),
                  _button('÷'),
                ],
              ),
                
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _button('7'),
                  _button('8'),
                  _button('9'),
                  _button('×')
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _button('4'),
                  _button('5'),
                  _button('6'),
                  _button('-')
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _button('1'),
                  _button('2'),
                  _button('3'),
                  _button('+'),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _button('0'),
                  _button(''),
                  _button('.'),
                  _button('='),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Center _button(String _num) {
    return Center(
        child: Container(
          height: _buttonSize,
          width: _buttonSize,
          margin: const EdgeInsets.all(4.0),    //ボタン間の隙間設定
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: _numberButton(_num),
          ),
        ),
    );
  }
  RaisedButton _numberButton(String _num) {
    return RaisedButton(
      child: SizedBox(
          child: Text(
            _num,
            style: TextStyle(
             fontSize: 25,
            ),
          ),
        ),
      onPressed: () {
        print('button $_num selected');
        setState(() {
          //入力された値を追加or計算して画面に表示
          _textString = dispValue(_textString, _num);
        });
      },
    );
  }

  //電卓の表示を作成
  String dispValue(String _text, String _num) {
    String retString = _text;

    if ( isDigit(_num) ) {
      //0だけの場合
      if (retString == "0" || _isPushValue) {
        retString = _num.toString();
        if ( _isPushValue) {
          _isPushValue = false;
        }
      } else {
        retString += _num.toString();
      }
    }else{
      //押されたボタンが数字以外の場合

      //四則演算の場合
      if (_num == "+" || _num == "-" || _num == "×" || _num == "÷") {
        //beforeValueが空の場合
        if (_beforeValue.isEmpty) {
          _beforeValue = retString;
          _sign = _num;
          _isPushValue = true;
        } else if (_afterValue.isEmpty) {
          //四則演算の変更
          _sign = _num;
          _isPushValue = true;
        }
      }

      //"="の場合
      if (_num == "=") {
        //画面の値をafterValueに格納
        _afterValue = retString;

        //計算を行う
        if (_beforeValue.isNotEmpty && _afterValue.isNotEmpty && _sign.isNotEmpty) {
          retString = calculateValue(_beforeValue, _afterValue, _sign);
        }
        
      }
      //小数点の場合
      if (_num == ".") {

      }
      //ACの場合
      if (_num == "AC") {
        _beforeValue = "";
        _afterValue = "";
        _sign = "";
        retString = "0";
      }
    }
    return retString;
  }

  //数値かどうか判定
  bool isDigit(String _num) {
    try{
      double.parse(_num);
      return true;
    } catch(e) {
      return false;
    } finally{

    }
  }

  //計算処理
  String calculateValue(String beforeString, String afterString, String sign) {
    String retString = '0';
    double answer = 0;
    double beforeVal;
    double afterVal;

    //数値変換
    try {
      beforeVal = double.parse(beforeString);
      afterVal = double.parse(afterString);
    }catch (e) {
      beforeVal = 0;
      afterVal = 0;
    }

    //計算開始
    switch (sign) {
      case "+":
        answer = beforeVal + afterVal;
        break;
      
      case "-":
        answer = beforeVal - afterVal;
        break;

      case "×":
        answer = beforeVal * afterVal;
        break;
      
      case "÷":
        if (beforeVal != 0) {
          answer = beforeVal / afterVal;
        }
        break;
    }
    if (answer.isFinite) {
      retString = answer.round().toString();
    } else {
      retString = answer.toString();
    }
    return retString;
  }
}
