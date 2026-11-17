import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1/core/app_routes.dart';
import 'package:p1/core/formatadores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p1/controller/home_controller.dart';
import 'package:p1/view/widgets/seletor_veiculo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.carregarNome();
    controller.carregar();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _editarKm() async {
    final veiculo = controller.veiculoSelecionado;
    if (veiculo == null) return;

    final campo = TextEditingController(text: veiculo.km.toString());
    String? erro;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: Text('Quilometragem atual'),
              content: TextField(
                controller: campo,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Quilometragem',
                  suffixText: 'km',
                  errorText: erro,
                  errorMaxLines: 3,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    final resultado = await controller.atualizarKm(campo.text);

                    if (!dialogContext.mounted) return;

                    if (resultado == null) {
                      Navigator.pop(dialogContext);
                    } else {
                      setDialogState(() => erro = resultado);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    return Text(
                      controller.nomeUsuario.isEmpty
                          ? 'Olá!'
                          : 'Olá, ${controller.nomeUsuario.split(' ').first}!',
                      style: TextStyle(fontSize: 24),
                    );
                  },
                ),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil do Usuário'),
              onTap: () async {
                await Navigator.pushNamed(context, AppRoutes.perfil);
                controller.carregarNome();
                },
            ),

            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Histórico'),
              onTap: () async {
                await Navigator.pushNamed(context, AppRoutes.historico);
                controller.carregar();
                },
            ),

            ListTile(
              leading: Icon(Icons.speed),
              title: Text('Monitoramento'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.monitoramento);
              },
            ),

            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.sobre);
                },
            ),
            
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () async{
                await FirebaseAuth.instance.signOut();

                if(!context.mounted) return;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
            ),

          ],
        ),
      ),
      
      
      appBar: AppBar(
        title: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            return SeletorVeiculo(
              style: TextStyle(fontSize: 20),
              veiculos: controller.veiculos,
              selecionadoId: controller.veiculoSelecionadoId,
              onChanged: controller.selecionarVeiculo,
            );
          },
        ),

        centerTitle: true,
      ),
      
      body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              if (controller.carregando && controller.veiculos.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.erro != null) {
                return Center(child: Text(controller.erro!));
              }

              final veiculo = controller.veiculoSelecionado;

              if (veiculo == null) {
                return Center(
                  child: Text(
                    'Nenhum veículo cadastrado.\nToque em "Cadastrar Veículo" para começar.',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Column(
                children: [

                  Card(
                    child: ListTile(
                      title: Text('${formatarKm(veiculo.km)} km'),
                      trailing: IconButton(
                        onPressed: _editarKm,
                        icon: Icon(Icons.edit),
                      ),

                    ),
                  ),

                  SizedBox(height: 80),

                  Text(
                    'Próxima Manutenção',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 15),

                  ...controller.proximas.map(
                    (status) => Card(
                      child: ListTile(
                        title: Text(status.servico.nome),
                        titleTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                        subtitle: Text('Previsão: ${formatarKm(status.proximoKm)} km'),
                      )
                    ),
                  ),
                ],
              );
            },
          ),
        ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.cadastrarVeiculo);
          if (!mounted) return;
          controller.carregar();
        },
        icon: Icon(Icons.add),
        label: Text('Cadastrar Veículo',
          style: TextStyle(fontSize: 16),
        ),
      ),

    );
  }
}
