import 'package:flutter/material.dart';
import 'package:n1nicolas/userEdit.dart';
import 'package:n1nicolas/utils/utils.dart' as utils;
import 'package:n1nicolas/utils/topBar.dart' as topb;
import 'package:cloud_firestore/cloud_firestore.dart';


class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

void _editUser(BuildContext context, DocumentSnapshot document){
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => userEdit(document: document),
      )
  );
}

Future<void> _deleteUser(String Conta) async{
  try{
    await FirebaseFirestore.instance.collection('usuarios').doc(Conta).delete();
    print('Usuário excluído com sucesso.');
  }catch (e){
    print('Erro ao excluir Usuário: $e');
  }
}

class _UsersState extends State<Users> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topb.TopBar(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError){
              return Text('Algo deu errado');
            }

            if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document){
                Map<String,dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['nome']),
                  subtitle: Text(data['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: (){
                          //função para deletar do banco
                          _deleteUser(document.id);
                        }
                      ),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: (){
                            //função para editar
                            _editUser(context, document);
                          }
                      ),
                    ]
                  ),
                );
              }).toList()
            );
          }
        ),
      )
    );
  }
}
