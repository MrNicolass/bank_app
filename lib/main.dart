import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Página Inicial',
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('C6 Bank',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}