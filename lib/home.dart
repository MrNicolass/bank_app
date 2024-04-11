//#region Imports

//Importações flutter
import 'package:flutter/material.dart';

//Importações de projetos
import 'package:n1nicolas/utils/utils.dart' as utils;
import 'package:n1nicolas/utils/topBar.dart' as topb;
import 'package:n1nicolas/cards.dart' as cards;
import 'package:n1nicolas/saldo.dart' as saldo;
import 'package:n1nicolas/invest.dart' as invest;
import 'package:n1nicolas/store.dart' as store;

//#endregion Imports

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

//Classe para definir a tela inicial do app com um estado mutável
class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topb.TopBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          Stack(
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
                      color: Colors.black,
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
                                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.023),
                                  child: utils.miniBox(
                                    context: context,
                                    child: utils.miniBoxButton(context: context, text: 'Investir', isBlue: true)
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.023),
                                  child: utils.miniBox(
                                    context: context,
                                    child: utils.miniBoxButton(context: context, text: 'Abrir conta'),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.023),
                                  child: utils.miniBox(
                                    context: context,
                                    child: utils.miniBoxButton(context: context, text: 'Abrir conta')
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          cards.Cards(),
          saldo.Saldo(),
          invest.Invest(),
          store.Store(),
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
    );
  }
}