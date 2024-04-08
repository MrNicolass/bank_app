import 'package:flutter/material.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

//Classe para definir a tela inicial do app com um estado mutável
class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Text('Nicolas', style: utils.textoMedio().copyWith(fontWeight: FontWeight.bold)),
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
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromARGB(255, 24, 24, 24),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 252, 209, 50),
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          selectedLabelStyle: utils.textoPequeno().copyWith(fontWeight: FontWeight.w900, letterSpacing: -1, fontSize: 14),
          unselectedLabelStyle: utils.textoPequeno().copyWith(letterSpacing: 0),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30),
              label: _selectedIndex == 0 ? '――' : 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined, size: 30),
              label: _selectedIndex == 1 ? '――' : 'Cartões',
            ),
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/images/cnum.png'), width: 30, height: 30),
              label: _selectedIndex == 2 ? '――' : 'Saldo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined, size: 30),
              label: _selectedIndex == 3 ? '――' : 'C6 Invest',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_2_outlined, size: 30),
              label: _selectedIndex == 4 ? '――' : 'Benefícios',
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromARGB(255, 12, 12, 12),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: double.infinity,
                  //color: Colors.black,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Saldos', style: utils.textoMedio().copyWith(fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {},
                            child: Text('Exibir Extratos',
                                style: utils.textoPequeno().copyWith(fontWeight: FontWeight.bold, color: Colors.blue)
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                              child: utils.miniBox(
                                  child: const Icon(Icons.add, size: 30),
                                  context: context
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                              child: utils.miniBox(
                                  child: const Icon(Icons.add, size: 30),
                                  context: context
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                              child: utils.miniBox(
                                  child: const Icon(Icons.add, size: 30),
                                  context: context
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}