class User{

  String? nome;
  String? email;
  int? senha;
  String? conta;

  User(this.nome, this.email, this.senha, this.conta);

  Map<String, dynamic> toMap(){
    return{
      'nome': nome,
      'email': email,
      'senha': senha,
      'agencia': '0001',
      'conta': conta
    };
  }

}
