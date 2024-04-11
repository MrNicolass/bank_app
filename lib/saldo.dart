import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;

class Saldo extends StatefulWidget {
  const Saldo({Key? key}) : super(key: key);

  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.purple,
      ),
    );
  }
}