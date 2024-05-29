import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;
import 'package:n1nicolas/utils/topBar.dart' as topb;
import 'package:n1nicolas/users.dart' as users;
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Usuário não encontrado') {
        print('E-mail não encontrado.');
      } else if (e.code == 'Senha incorreta') {
        print('Senha incorreta para este e-mail');
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topb.TopBar(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 12, 12, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: utils.DefaultInput(_emailController, context, "Digite seu e-mail", 50, false)
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: utils.DefaultInput(_passController, context, "Digite sua senha", 6, true)
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                style: utils.ButtonShade(),
                onPressed: () async {
                  try {
                    UserCredential userCredential = await signInWithEmailPassword(_emailController.text, _passController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => users.Users()),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Entrar', style: utils.textoMedio().copyWith(color: Colors.white)),
              ),
            ),
          ]
      ),
      )
    );
  }
}