import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'baba calculator',
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 35.0;
  double resultFontSize = 45.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm).toInt()}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textButtonColor) {
    return Container(
        height: MediaQuery.of(context).size.height * buttonHeight,
        color: buttonColor,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 30, color: textButtonColor),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Text(
            equation,
            style: TextStyle(fontSize: equationFontSize, color: Colors.grey),
            maxLines: 3,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          ),
        ),
        const Expanded(
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("C", 0.1, Colors.white, Colors.redAccent),
                    buildButton("⌫", 0.1, Colors.white, Colors.blue),
                    buildButton("÷", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("7", 0.1, Colors.white, Colors.blue),
                    buildButton("8", 0.1, Colors.white, Colors.blue),
                    buildButton("9", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("4", 0.1, Colors.white, Colors.blue),
                    buildButton("5", 0.1, Colors.white, Colors.blue),
                    buildButton("6", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("1", 0.1, Colors.white, Colors.blue),
                    buildButton("2", 0.1, Colors.white, Colors.blue),
                    buildButton("3", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton(".", 0.1, Colors.white, Colors.blue),
                    buildButton("0", 0.1, Colors.white, Colors.blue),
                    buildButton("000", 0.1, Colors.white, Colors.blue)
                  ]),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("×", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("+", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("-", 0.1, Colors.white, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("=", 0.2, Colors.blue, Colors.white)
                  ]),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
