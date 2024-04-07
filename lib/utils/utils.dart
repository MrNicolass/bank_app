import 'package:flutter/material.dart';

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

ButtonStyle elevButtonShade(){
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

ButtonStyle elevButtonTransp(){
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

//#endregion EstiloBotao