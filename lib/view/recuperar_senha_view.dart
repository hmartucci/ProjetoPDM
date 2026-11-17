import 'package:flutter/material.dart';
import 'package:p1/controller/recuperar_senha_controller.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  final controller = RecuperarSenhaController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
                'Recuperar Senha',
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

                
                SizedBox(height: 80),


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

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.carregando
                        ? null
                        : () async {
                            final sucesso = await controller.recuperarSenha();

                            if (!context.mounted) return;

                            if (sucesso) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Se existir uma conta com este e-mail, enviamos um link para redefinir a senha.',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                    child: controller.carregando
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Recuperar Senha'),
                  ),
                ),

              ],
            );
          }
        )
      ),
    );
  }
}
