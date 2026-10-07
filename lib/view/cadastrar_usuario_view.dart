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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
                'Cadastrar nova conta',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome de Usuário',
                ),
              ),

              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@email.com',
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
                  hintText: '(99) 9 9999-9999'
                ),
              ),
              
              SizedBox(height: 30),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha'
                )
              ),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirme a Senha'
                )
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: null,                              // PRECISA ATIVAR
                  child: Text('Entrar')
                ),
              ),

          ],
        ),
      ),
    );
  }
}
