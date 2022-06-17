import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  Widget calcbutton(String btntxt, Color? btncolor, Color? txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 28,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 195, 195),
      appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 66, 233, 155),
          title: Center(
            child: Text(
              "Calculator",
              style: TextStyle(
                  color: Color.fromARGB(255, 242, 244, 245),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 400),
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://icons.iconarchive.com/icons/blackvariant/shadow135-system/256/Calculator-icon.png")))),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('AC', Colors.grey, Colors.black),
                  calcbutton('+/-', Colors.grey, Colors.black),
                  calcbutton('%', Colors.grey, Colors.black),
                  calcbutton(
                      '/', Color.fromARGB(255, 0, 38, 255), Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('7', Colors.grey[850], Colors.white),
                  calcbutton('8', Colors.grey[850], Colors.white),
                  calcbutton('9', Colors.grey[850], Colors.white),
                  calcbutton(
                      'x', Color.fromARGB(255, 0, 38, 255), Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('4', Colors.grey[850], Colors.white),
                  calcbutton('5', Colors.grey[850], Colors.white),
                  calcbutton('6', Colors.grey[850], Colors.white),
                  calcbutton(
                      '-', Color.fromARGB(255, 0, 38, 255), Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('1', Colors.grey[850], Colors.white),
                  calcbutton('2', Colors.grey[850], Colors.white),
                  calcbutton('3', Colors.grey[850], Colors.white),
                  calcbutton(
                      '+', Color.fromARGB(255, 0, 38, 255), Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //this is button Zero
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    onPressed: () {
                      calculation('0');
                    },
                    shape: StadiumBorder(),
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    color: Colors.grey[850],
                  ),
                  calcbutton('.', Colors.grey[850], Colors.white),
                  calcbutton(
                      '=', Color.fromARGB(255, 0, 38, 255), Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}







// import 'package:calculator/Calculator_Button.dart';
// import 'package:math_expressions/math_expressions.dart';
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(CalculatorApp());
// }

// class CalculatorApp extends StatefulWidget {
//   CalculatorApp({Key? key}) : super(key: key);

//   @override
//   _CalculatorAppState createState() => _CalculatorAppState();
// }

// class _CalculatorAppState extends State<CalculatorApp> {
//   @override
//   String _history = '';
//   String _expression = '';

//   void numClick(String text) {
//     setState(() => _expression += text);
//   }

//   void allClear(String text) {
//     setState(() {
//       _history = '';
//       _expression = '';
//     });
//   }

//   void clear(String text) {
//     setState(() {
//       _expression = '';
//     });
//   }

//   void evaluate(String text) {
//     Parser p = Parser();
//     _history = _expression;
//     Expression exp = p.parse(_expression);
//     ContextModel cm = ContextModel();

//     setState(() {
//       _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Calculator',
//       home: Scaffold(
//         backgroundColor: Color(0xFF283637),
//         body: Container(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Container(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: Text(
//                     _history,
//                     style: GoogleFonts.rubik(
//                       textStyle: TextStyle(
//                         fontSize: 24,
//                         color: Color(0xFF545F61),
//                       ),
//                     ),
//                   ),
//                 ),
//                 alignment: Alignment(1.0, 1.0),
//               ),
//               Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Text(
//                     _expression,
//                     style: GoogleFonts.rubik(
//                       textStyle: TextStyle(
//                         fontSize: 48,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 alignment: Alignment(1.0, 1.0),
//               ),
//               SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   CalcButton(
//                     text: 'AC',
//                     fillColor: 0xFF6C807F,
//                     textColor: 0xFF65BDAC,
//                     textSize: 20,
//                     callback: allClear,
//                   ),
//                   CalcButton(
//                     text: 'C',
//                     fillColor: 0xFF6C807F,
//                     textColor: 0xFF65BDAC,
//                     callback: clear,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '%',
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     callback: numClick,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '/',
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     callback: numClick,
//                     textSize: 28,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   CalcButton(
//                     text: '7',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '8',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '9',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '*',
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 24,
//                     callback: numClick,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   CalcButton(
//                     text: '4',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '5',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '6',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '-',
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 38,
//                     callback: numClick,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   CalcButton(
//                     text: '1',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '2',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '3',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '+',
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 30,
//                     callback: numClick,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   CalcButton(
//                     text: '.',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '0',
//                     callback: numClick,
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     textSize: 28,
//                   ),
//                   CalcButton(
//                     text: '0',
//                     callback: numClick,
//                     textColor: 0xFF65BDAC,
//                     textSize: 20,
//                   ),
//                   CalcButton(
//                     text: '=',
//                     fillColor: 0xFFFFFFFF,
//                     textColor: 0xFF65BDAC,
//                     callback: evaluate,
//                     textSize: 28,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// // import 'package:flutter/material.dart';
// // import 'package:get/get_navigation/src/root/get_material_app.dart';
// // import '../bindings/my_bindings.dart';
// // import '../screen/main_screen.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       initialBinding: MyBindings(),
// //       title: "Flutter Calculator",
// //       home: MainScreen(),
// //     );
// //   }
// // }
