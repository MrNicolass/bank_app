import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Página Inicial',
      home: Home(),
    ),
  );
}

class passReplace extends StatefulWidget {
  @override
  _passReplaceState createState() => _passReplaceState();
}

class _passReplaceState extends State<passReplace> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateHintText);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateHintText);
    _controller.dispose();
    super.dispose();
  }

  void _updateHintText() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        TextFormField(
          controller: _controller,
          maxLength: 6,
          obscureText: false, // Altere para false
          textAlign: TextAlign.center,
          style: utils.textoGrande().copyWith(
              letterSpacing: 10,
              fontSize: 32.5,
              color: Colors.transparent // Altere para transparente
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
        Positioned(
          child: Text.rich(
            TextSpan(
              children: List<TextSpan>.generate(6, (int i) {
                return TextSpan(
                  text: _controller.text.length > i ? '● ' : '○ ',
                  style: utils.textoGrande().copyWith(
                    letterSpacing: 10,
                    fontSize: 32.5,
                    color: _controller.text.length > i ? Color.fromARGB(255, 69, 69, 69) : Color.fromARGB(255, 69, 69, 69).withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    onPressed: () {},
                    style: utils.elevButtonShade(),
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
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Icon(Icons.account_circle, color: Colors.white, size: 45),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 5.0, bottom: 9.0),
                                            child: Text('Olá, Nicolas', style: utils.textoGrande())
                                        ),
                                        Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(text: 'Agência ', style: utils.textoPequeno(),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: '0001',
                                                      style: utils.textoPequeno().copyWith(fontWeight: FontWeight.bold)
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 13), //Adiciona espaçamento entre os elementos
                                            Text.rich(
                                              TextSpan(text: ' Conta Corrente', style: utils.textoPequeno(),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: ' 12345678-1',
                                                        style: utils.textoPequeno().copyWith(fontWeight: FontWeight.bold)
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 22.0, bottom: 5.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: utils.elevButtonTransp(),
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
                                                          Padding(padding: EdgeInsets.only(bottom: 50, top: 22),
                                                            child: Text('Insira a senha de acesso', style: utils.textoGrande())
                                                          ),
                                                          Padding(padding: EdgeInsets.all(20),
                                                            child: Center(
                                                              child: passReplace(),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            style: utils.elevButtonShade(),
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
                      style: utils.elevButtonTransp(),
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
      ),
    );
  }
}