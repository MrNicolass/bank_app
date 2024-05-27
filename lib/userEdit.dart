import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userEdit extends StatefulWidget {

  final DocumentSnapshot document;

  const userEdit({super.key, required this.document});

  @override
  State<userEdit> createState() => _userEditState();
}

class _userEditState extends State<userEdit> {

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController(text: widget.document['nome']);
    _emailController = TextEditingController(text: widget.document['email']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Dados"),
        actions: [
          IconButton(
              onPressed: ()=> _updateProduto(),
              icon: Icon(Icons.save)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Nome do Usuário'
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'E-mail pessoal'
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProduto() async{
    try{
      await widget.document.reference.update({
        'nome': _nameController.text,
        'email': _emailController.text,
      });
      Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao editar o Usuário: $e'))
      );
    }
  }

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

}
