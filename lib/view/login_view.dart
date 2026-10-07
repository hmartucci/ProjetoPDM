//07
import 'package:flutter/material.dart';
import 'package:p1/core/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 150, 20, 20),

//15
        child: Column(
            children: [
              Image.asset(
                'assets/logo_teste.png',
                height: 120,
                width: 120,
              ),

              Text(
                'Login',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@email.com',
                ),
              ),

              SizedBox(height: 20),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha'
                )
              ),

              SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: null,
                  //  () {
                  //   Navigator.pushNamed(context, AppRoutes.sobre);
                  // },                                              // PRECISA ATIVAR
                  child: Text('Entrar')
                ),

              ),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.recuperarSenha);
                  },
                  child: Text('Esqueceu a senha?'),
                ),
              ),

              SizedBox(height: 60),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cadastrarUsuario);
                },
                child: Text('Cadastre-se')
              ),
            
            ],
          ),
        
        ),
      );
  }
}