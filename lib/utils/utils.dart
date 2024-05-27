import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;
import 'package:n1nicolas/user.dart' as user;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

//#region EstiloTexto

TextStyle textoMedio(){
  return const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'C6Sans',
  );
}

TextStyle textoGrande(){
  return const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontFamily: 'C6Sans',
    fontWeight: FontWeight.w100
  );
}

TextStyle textoPequeno(){
  return const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'C6Sans',
  );
}
//#endregion EstiloTexto

//#region EstiloBotao

ButtonStyle ButtonShade(){
  return ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 252, 209, 50),
    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(
        color: Colors.black,
          width: 0.6
      ),
    ),
  );
}

ButtonStyle ButtonTransp(){
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(
        color: Colors.white,
        width: 0.6
      ),
    ),
  );
}

ButtonStyle ButtonFullTransp(){
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 24, 24, 24)),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    animationDuration: Duration.zero,
    textStyle: MaterialStateProperty.all(textoMedio().copyWith(color: Colors.blue)),
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 10)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(
          color: Colors.transparent,
          width: 0.6
      ),
    )),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
  );
}

Align miniBoxButton({context, required String text, bool isBlue = false}){
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.04,
      decoration: BoxDecoration(
        color: isBlue == true ? Color.fromARGB(255, 24, 24, 24) : Color.fromARGB(255, 252, 209, 50),
        border: Border(
          top: BorderSide(color: isBlue == true ? Color.fromARGB(255, 80, 80, 80) : Colors.black, width: 0.1),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {},
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text, style: utils.textoPequeno().copyWith(color: isBlue == true ? Colors.blue : Colors.black)),
                    Icon(Icons.arrow_forward_ios, color: isBlue == true ? Colors.blue : Colors.black, size: 15)
                  ]
              )
          )
      ),
    ),
  );
}

//#endregion EstiloBotao

//#region EstiloContainer

Container miniBox({required Widget child, context, country}){
  return Container(
    height: MediaQuery.of(context).size.height * 0.15,
    width: MediaQuery.of(context).size.width * 0.45,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 24, 24, 24),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.02),
            child: Row(
              children: [
                Icon(Icons.flag_circle_rounded, color: Colors.white, size: 20),
                Text(country == 'BR' ? 'Real': country == 'US' ? 'Dólar' : country == 'EU' ? 'Euro' : 'C6 Global Invest', style: utils.textoMedio()),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: MediaQuery.of(context).size.width * 0.02),
            child: Text.rich(
              TextSpan(
                  text: country == 'BR' ? 'R\$' : country == 'US' ? 'U\$' : '€',
                  style: utils.textoMedio(),
                  children: <TextSpan>[
                    TextSpan(
                      text: '  125,00',
                      style: utils.textoMedio().copyWith(fontWeight: FontWeight.bold)
                    ),
                  ]
              ),
            ),
          ),
        ),
        Spacer(),
        child
      ],
    ),
  );
}

Column bigBox({context, typeBox = 'saldo'}){
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          //color: Colors.grey,
          child: Builder (
            builder: (context) {
              if (typeBox == 'saldo') {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Saldos', style: utils.textoMedio().copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                        InkWell(
                          onTap: () {},
                          child: Text('Exibir extratos',
                              style: utils.textoMedio().copyWith(fontWeight: FontWeight.bold, color: Colors.blue)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                  child: utils.miniBox(
                                      context: context,
                                      country: 'BR',
                                      child: utils.miniBoxButton(context: context, text: 'Investir', isBlue: true)
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                  child: utils.miniBox(
                                    context: context,
                                    country: 'US',
                                    child: utils.miniBoxButton(context: context, text: 'Abrir conta'),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                  child: utils.miniBox(
                                      context: context,
                                      country: 'EU',
                                      child: utils.miniBoxButton(context: context, text: 'Abrir conta')
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                  child: utils.miniBox(
                                      context: context,
                                      country: 'IN',
                                      child: utils.miniBoxButton(context: context, text: 'Abrir conta')
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else return SizedBox(
                child: Text('Teste'),
              );
            }
          ),
        ),
      ),
    ],
  );
}

//#endregion EstiloContainer

//#region EstiloInput
SizedBox DefaultInput(controller, BuildContext context, String label, int lines, bool isPass){
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.070,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        style: utils.textoMedio().copyWith(color: Colors.white),
        controller: controller,
        maxLength: lines,
        obscureText: isPass ? true : false,
        enableSuggestions: isPass ? false : true,
        autocorrect: isPass ? false: true,
        keyboardType: isPass ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          counter: const Offstage(),
          labelStyle: utils.textoMedio().copyWith(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      )
    ),
  );
}

//#endregion EstiloInput

//Função para pegar os dados de um usuário
Future<Map<String, dynamic>> getUserData() async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('usuarios')
      .doc('99316466-5')
      .get();

  return documentSnapshot.data() as Map<String, dynamic>;
}
