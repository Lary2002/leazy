import 'package:flutter/material.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white70,
        title: Text(
          'Converter',
          style: TextStyle(
              fontSize: 30,
              color: Colors.black
          ),
        ), 
      ),
      body: Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  TextEditingController decimalController = TextEditingController();
  TextEditingController binaryController = TextEditingController();
  String errorMessage = '';
  // Conversion functions
  void convertDecimalToBinary() {
    setState(() {
      errorMessage = ''; // Clear previous error messages
      String decimalText = decimalController.text;
      if (decimalText.isNotEmpty) {
        try {
          int decimal = int.parse(decimalText);
          binaryController.text = decimal.toRadixString(2);
        } catch (e) {
          errorMessage = 'Invalid decimal input. Please enter a valid integer.';
        }
      }
    });
  }

  void convertBinaryToDecimal() {
    setState(() {
      errorMessage = ''; // Clear previous error messages
      String binaryText = binaryController.text;
      if (binaryText.isNotEmpty) {
        try {
          // Check if the input contains only '0' and '1'
          if (RegExp(r'^[01]+$').hasMatch(binaryText)) {
            int decimal = int.parse(binaryText, radix: 2);
            decimalController.text = decimal.toString();
          } else {
            throw FormatException('Invalid binary input');
          }
        } catch (e) {
          errorMessage = 'Invalid binary input. Please enter a valid binary number.';
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white38,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              TextField(
                controller: decimalController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Decimal',
                    border: OutlineInputBorder(
                        borderSide:BorderSide(
                          width: 20,
                          color: Colors.white,
                        )
                    )
                ),
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState(() {
                    binaryController.clear();
                    errorMessage = '';
                  });
                },
              ),
              SizedBox(height: 20,),
              TextField(
                controller: binaryController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Binary',
                    border: OutlineInputBorder(
                        borderSide:BorderSide(
                          width: 20,
                          color: Colors.white,
                        )
                    )
                ),
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState(() {
                    decimalController.clear();
                    errorMessage = '';
                  });
                },
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty) // Display error message if present
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: convertBinaryToDecimal,
                    child: Text('Binary to Decimal')
                  ),
                  ElevatedButton(
                      onPressed: convertDecimalToBinary,
                      child: Text('Decimal to Binary')
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

