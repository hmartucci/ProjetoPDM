// digite stf
// 06
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class CadastrarUsuarioView extends StatefulWidget {
  const CadastrarUsuarioView({super.key});

  @override
  State<CadastrarUsuarioView> createState() => _CadastrarUsuarioViewState();
}

class _CadastrarUsuarioViewState extends State<CadastrarUsuarioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Usuário',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome de Usuário',
                  icon: Icon(Icons.person),
                ),
              ),

              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@email.com',
                  icon: Icon(Icons.email),
                ),
              ),

              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                decoration: InputDecoration(
                  labelText: 'Número de Telefone',
                  hintText: '(99) 9 9999-9999',
                  icon: Icon(Icons.phone_android),
                ),
              ),
              
              SizedBox(height: 30),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  icon: Icon(Icons.password),
                )
              ),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirme a Senha',
                  icon: Icon(Icons.password),
                )
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },                              // PRECISA ATIVAR
                  child: Text('Entrar')
                ),
              ),

          ],
        ),
      ),
    );
  }
}
