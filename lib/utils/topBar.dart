import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;
import 'package:n1nicolas/users.dart' as users;

AppBar TopBar(BuildContext context){
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 12, 12, 12),
    automaticallyImplyLeading: false,
    foregroundColor: Colors.white,
    elevation: 0,
    title: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //Alinha os Text na esquerda
        children: [
          Text('Bem vindo,', style: utils.textoPequeno()),
          FutureBuilder<Map<String, dynamic>>(
            future: utils.getUserData(), // a Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              Map<String, dynamic>? data = snapshot.data;
              return Text('${data?['nome']}', style: utils.textoMedio().copyWith(fontWeight: FontWeight.bold));
            },
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.help_outline),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.chat_bubble_outline_outlined),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.remove_red_eye_outlined),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => users.Users()),
          );
        },
        icon: const Icon(Icons.account_circle_outlined),
      ),
    ],
  );
}
