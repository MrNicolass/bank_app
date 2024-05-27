import 'package:n1nicolas/user.dart' as user;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;
import 'package:n1nicolas/home.dart';
import 'dart:math';

/// @Documentation
/// All the functions will be written in english, but comments will be in portuguese.

Future<void> main() async {

  //Estancia o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Login(),
    ),
  );
}

//Controladores dos inputs
final TextEditingController _nameController = TextEditingController();
final TextEditingController _passController = TextEditingController();
final TextEditingController _emailController = TextEditingController();

//#region Cadastro Usuário
void userRegistration(BuildContext context){
  var account = '${Random().nextInt(99999999)}-${Random().nextInt(10)}'.toString();

  final userR = user.User(
      _nameController.text,
      _emailController.text,
      int.parse(_passController.text),
      account
  );

  FirebaseFirestore.instance.collection('usuarios').doc(account).set(userR.toMap()).then((result){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Seja muito bem-vindo ${_nameController.text}!'),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }).catchError((error){
    print('Erro ao cadastrar o usuário: $error');
  });
}
//#endregion Cadastro Usuário

//#region FunçãoTrocaSenha

class passReplace extends StatefulWidget {
  @override
  _passReplaceState createState() => _passReplaceState();
}

class _passReplaceState extends State<passReplace> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateHintText);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateHintText);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<bool> verifyPassword(String password) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc('99316466-5')
        .get();

    Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

    // Verifica se o documento existe e se a senha é igual à senha fornecida
    if (data?['senha'].toString() == password) {
      return true;
    } else {
      return false;
    }
  }

  void _updateHintText() async {
    bool pass = await verifyPassword(_controller.text);
    setState(() {
      if (_controller.text.length == 6) {
        if (pass) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Falha na autenticação'),
                content: Text('Você digitou a senha errada. Tente novamente.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Fechar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          EditableText(
            focusNode: _focusNode,
            controller: _controller,
            backgroundCursorColor: Colors.transparent,
            cursorColor: Colors.transparent,
            style: utils.textoGrande().copyWith(
                letterSpacing: 10,
                fontSize: 32.5,
                color: Colors.transparent
            ),
            maxLines: 1,
            showCursor: true,
            showSelectionHandles: false, //Desativa o seletor de texto
            keyboardType: TextInputType.number, //Abre teclado numérico
          ),
          Positioned(
            child: Text.rich(
              TextSpan(
                children: List<TextSpan>.generate(6, (int i) {
                  return TextSpan(
                    //Verifica se o tamanho do texto é maior que o índice e troca os símbolos
                    text: _controller.text.length > i ? '● ' : '○ ',
                    style: utils.textoGrande().copyWith(
                      letterSpacing: 10,
                      fontSize: 32.5,
                      //Troca cor do símbolo de acordo com o tamanho do texto digitado
                      color: _controller.text.length > i ? Colors.white : Color.fromARGB(255, 69, 69, 69).withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//#endregion FunçãoTrocaSenha

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError){
            return Text('Algo deu errado: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
        return Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
              child: AppBar(
                title: Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: const Color.fromARGB(255, 24, 24, 24),
                            context: context,
                            builder: (BuildContext context){
                              return SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(Icons.account_circle, color: Colors.white, size: 45),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 5.0, bottom: 9.0),
                                          child: Text('Crie sua conta', style: utils.textoGrande())
                                      ),
                                      utils.DefaultInput(_nameController, context, 'Digite seu Nome', 50, false),
                                      utils.DefaultInput(_emailController, context, 'Digite seu E-mail', 40, false),
                                      utils.DefaultInput(_passController, context, 'Digite uma Senha', 6, true),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 22.0, bottom: 5.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            userRegistration(context);
                                          },
                                          style: utils.ButtonShade(),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            height: MediaQuery.of(context).size.height * 0.030,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text('Criar conta',
                                                  style: utils.textoMedio().copyWith(color: Colors.black)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      style: utils.ButtonShade(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.030,
                        child: Center(
                          child: Text('Abrir conta',
                            style: utils.textoMedio().copyWith(color: Colors.black)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child:
                      ElevatedButton(
                        onPressed: (){
                          showModalBottomSheet(
                            backgroundColor: const Color.fromARGB(255, 24, 24, 24),
                            context: context,
                            builder: (BuildContext context){
                              return SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // Alinha os elementos ao centro
                                    children:[
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(Icons.account_circle, color: Colors.white, size: 45),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(top: 5.0, bottom: 9.0),
                                              child: FutureBuilder<Map<String, dynamic>>(
                                                future: utils.getUserData(), // a Future<String> or null
                                                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                                  Map<String, dynamic>? data = snapshot.data;
                                                  return Text('Olá, ${data?['nome']}', style: utils.textoGrande());
                                                },
                                              ),
                                          ),
                                          Row(
                                            children: [
                                              Text.rich(
                                                TextSpan(text: 'Agência ', style: utils.textoPequeno(),
                                                ),
                                              ),
                                              FutureBuilder<Map<String, dynamic>>(
                                                future: utils.getUserData(), // a Future<String> or null
                                                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                                  Map<String, dynamic>? data = snapshot.data;
                                                  return Text('${data?['agencia']}', style: utils.textoPequeno().copyWith(fontWeight: FontWeight.bold));
                                                },
                                              ),
                                              const SizedBox(width: 13), //Adiciona espaçamento entre os elementos
                                              Text.rich(
                                                TextSpan(text: ' Conta Corrente ', style: utils.textoPequeno(),
                                                ),
                                              ),
                                              FutureBuilder<Map<String, dynamic>>(
                                                future: utils.getUserData(), // a Future<String> or null
                                                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                                  Map<String, dynamic>? data = snapshot.data;
                                                  return Text('${data?['conta']}', style: utils.textoPequeno().copyWith(fontWeight: FontWeight.bold));
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 22.0, bottom: 5.0),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: utils.ButtonTransp(),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.030,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text('Entrar com outra conta',
                                                      style: utils.textoMedio()
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor: const Color.fromARGB(255, 24, 24, 24),
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                        child: SizedBox(
                                                          width: double.infinity,
                                                          child: Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Padding(padding: EdgeInsets.only(bottom: 50, top: 22),
                                                                    child: Text('Insira a senha de acesso', style: utils.textoGrande())
                                                                ),
                                                                Padding(padding: EdgeInsets.all(20),
                                                                  child: Center(
                                                                    child: passReplace(),
                                                                  ),
                                                                ),
                                                                Padding(padding: EdgeInsets.all(20),
                                                                  child: ElevatedButton(
                                                                    onPressed: () {},
                                                                    style: utils.ButtonFullTransp(),
                                                                    child: SizedBox(
                                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                                      height: MediaQuery.of(context).size.height * 0.030,
                                                                      child: Center(
                                                                        child: Text('Redefinir senha',
                                                                            style: utils.textoMedio().copyWith(color: Colors.blue)
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              style: utils.ButtonShade(),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.030,
                                                child: Center(
                                                  child: Text('Entrar',
                                                      style: utils.textoMedio().copyWith(color: Colors.black)
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: utils.ButtonTransp(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.030,
                          child: Center(
                            child: Text('Já tenho Conta',
                              style: utils.textoMedio()
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
