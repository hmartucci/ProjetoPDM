import 'package:flutter/material.dart';
import 'package:p1/controller/perfil_controller.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final controller = PerfilController();

  @override
  void initState() {
    super.initState();
    controller.carregarDados();
  }

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
                'Perfil do Usuário',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
      
      
      
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              if (controller.carregando) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Text(
                    'Alterar dados de cadastro',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: controller.nomeUsuarioController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Nome',
                      errorText: controller.erroNomeUsuario,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'E-mail',
                    ),
                    enabled: false,
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.salvando
                          ? null
                          : () async {
                              final sucesso = await controller.salvar();

                              if (!context.mounted) return;

                              if (sucesso) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Dados atualizados!')),
                                );
                                Navigator.pop(context);
                              }
                            },
                      child: controller.salvando
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('Salvar Edições'),
                      ),
                    ),
                ],
              );        
            },
          ),
        ),
      ),
    );
  }
}
