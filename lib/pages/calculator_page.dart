import 'package:calculator_app/main.dart';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        title: Text(
            'Calculator',
            style: TextStyle(
                fontSize: 30,
                color: Colors.black
            ),
        ),
      ),
      body: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String display = '';  // To show the current input
  String result = '';   // To show the final result
  List<String> inputs = [];  // To store all inputs (numbers and operators)


  // Method to handle button presses
  void _onButtonPressed(String buttonText) {
    setState(() {
      // buttonText = buttonText.trim();  // Trim the button text to remove any extra spaces
      if (buttonText == 'AC') {
        display = '';
        result = '';
        inputs.clear();
      } else if (buttonText == ' = ') {
        if (inputs.isNotEmpty || display.isNotEmpty) {
          inputs.add(display);
          result = _calculateResult(inputs.join(' '));
          display = result;
          inputs.clear();
        }
      }else if (buttonText == ' X ') {
        if (display.isNotEmpty) {
          display = display.substring(0, display.length - 1);
        }
      } else {
        // Append numbers and operators to inputs list
        if (['+', '-', '*', '/'].contains(buttonText)) {
          if (display.isNotEmpty) {
            inputs.add(display);
            inputs.add(buttonText);
            display = '';
          }
        } else {
          display += buttonText.replaceAll(' ', '');
        }
      }
    });
  }

  // Method to calculate the result from the inputs
  String _calculateResult(String expression) {
    try {
      final exp = Expression.parse(expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }


  Widget calcButton(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      child: ClipOval(
        child: GestureDetector(
            onTap: () => _onButtonPressed(btntxt),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                btntxt,
                style: TextStyle(
                    fontSize: 28,
                    color: txtcolor,
                    fontWeight: FontWeight.bold
                ),
              ),
              color: btncolor,
            )
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              // calculation display
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        display,
                        style: TextStyle(color: Colors.white, fontSize: 60),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    result,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            ),
            // Buttons dispay
            _buildSimpleCalculationButtons()
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleCalculationButtons(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton('AC', Colors.white, Colors.black45),
            calcButton(' ( ', Colors.white70, Colors.black),
            calcButton(' ) ', Colors.white70, Colors.black),
            calcButton(' X ', Colors.white, Colors.red),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton(' 7 ', Colors.grey, Colors.white),
            calcButton(' 8 ', Colors.grey, Colors.white),
            calcButton(' 9 ', Colors.grey, Colors.white),
            calcButton(' * ', Colors.amber, Colors.black),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton(' 4 ', Colors.grey, Colors.white),
            calcButton(' 5 ', Colors.grey, Colors.white),
            calcButton(' 6 ', Colors.grey, Colors.white),
            calcButton(' + ', Colors.amber, Colors.black),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton(' 1 ', Colors.grey, Colors.white),
            calcButton(' 2 ', Colors.grey, Colors.white),
            calcButton(' 3 ', Colors.grey, Colors.white),
            calcButton(' - ', Colors.amber, Colors.black),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton(' 0 ', Colors.grey, Colors.white),
            calcButton(' . ', Colors.grey, Colors.white),
            calcButton(' / ', Colors.amber, Colors.black),
            calcButton(' = ', Colors.amber, Colors.black),
          ],
        ),
        SizedBox(height: 5,),
      ],
    );
  }
}