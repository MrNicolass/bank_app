import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;

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

//#endregion EstiloBotao

Container miniBox({required Widget child, context}){
  return Container(
    height: MediaQuery.of(context).size.height * 0.11,
    width: MediaQuery.of(context).size.width * 0.25,
    color: const Color.fromARGB(255, 24, 24, 24),
    child: child,
  );
}