//07
import 'package:flutter/material.dart';
import 'package:p1/core/app_routes.dart';
import 'package:p1/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  
final controller = LoginController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 150, 20, 20),

  //15
        child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return Column(
                children: [

                  Image.asset(
                    'assets/logo_carro.png',
                    height: 120,
                    width: 120,
                  ),

                  Text(
                    'Login',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'exemplo@email.com',
                      errorText: controller.erroEmail,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      errorText: controller.erroSenha,
                    )
                  ),

                  SizedBox(height: 20),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final sucesso = controller.entrar();

                        if(sucesso) {
                          Navigator.pushNamed(context, AppRoutes.home);
                        }
                      },                                              
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
              );
        
            }
        
        ),
      )
    );
  }
}