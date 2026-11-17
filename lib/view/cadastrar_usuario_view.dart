import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:p1/controller/cadastrar_usuario_controller.dart';
import 'package:p1/core/app_routes.dart';


class CadastrarUsuarioView extends StatefulWidget {
  const CadastrarUsuarioView({super.key});

  @override
  State<CadastrarUsuarioView> createState() => _CadastrarUsuarioViewState();
}

class _CadastrarUsuarioViewState extends State<CadastrarUsuarioView> {
  final controller = CadastrarUsuarioController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            return Column(
              children: [

                  TextField(
                    controller: controller.nomeUsuarioController,
                    decoration: InputDecoration(
                      labelText: 'Nome de Usuário',
                      icon: Icon(Icons.person),
                      errorText: controller.erroNomeUsuario,
                    ),
                  ),

                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'exemplo@email.com',
                      icon: Icon(Icons.email),
                      errorText: controller.erroEmail,
                    ),
                  ),

                  TextField(
                    controller: controller.numeroTelefoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Número de Telefone',
                      hintText: '(99) 9 9999-9999',
                      icon: Icon(Icons.phone_android),
                      errorText: controller.erroNumeroTelefone,
                    ),
                  ),
                  
                  SizedBox(height: 30),

                  TextField(
                    controller: controller.senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.password),
                      errorText: controller.erroSenha,
                    )
                  ),

                  TextField(
                    controller: controller.confirmarSenhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirme a Senha',
                      icon: Icon(Icons.password),
                      errorText: controller.erroConfirmarSenha,
                    )
                  ),

                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.carregando
                        ? null
                        : () async {
                          final sucesso = await controller.cadastrar();

                          if (!context.mounted) return;

                          if (sucesso){
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.home,
                              (route) => false
                            );
                          }
                      },
                      child: controller.carregando
                        ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Cadastrar Usuário')
                    ),
                  ),

              ],
            );
          }
        ),  
      ),
    );
  }
}
