import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/calculator');
              },
              child: Text(
                ' Simple Calculator',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/converter');
              },
              child: Text(
                'Binary Converter',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
