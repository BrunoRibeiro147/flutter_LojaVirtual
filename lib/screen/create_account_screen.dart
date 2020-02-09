import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<User>(builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nome Completo",
                ),
                validator: (text) {
                  if (text.isEmpty)
                    return "Nome Invalido";
                  else
                    return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains("@"))
                    return "E-mail Invalido";
                  else
                    return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  hintText: "Senha",
                ),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6)
                    return "Senha Invalido";
                  else
                    return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(
                  hintText: "Endereço",
                ),
                validator: (text) {
                  if (text.isEmpty)
                    return "Endereço Invalido";
                  else
                    return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 44,
                child: RaisedButton(
                  child: Text(
                    "Criar Conta",
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "adress": _enderecoController.text,
                      };
                      model.signUp(
                          userData: userData,
                          pass: _senhaController.text,
                          onSucess: _onSucess,
                          onFail: _onFailure);
                    }
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void _onSucess() {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Usuário Criado com Sucesso!'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((p) {
      Navigator.of(context).pop();
    });
  }

  void _onFailure() {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao Criar o Usuário '),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
