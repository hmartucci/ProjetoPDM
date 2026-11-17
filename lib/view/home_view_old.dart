import 'package:flutter/material.dart';
import 'package:p1/core/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p1/controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();
  String selecionado = 'Celta 2012';
  
  @override
  void initState() {
    super.initState();
    controller.carregarNome();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.historico);
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
        title: DropdownButton<String>(
          style: TextStyle(fontSize: 20),
          value: selecionado,
          items: [
            DropdownMenuItem(value: 'Celta 2012', child: Text('Celta 2012')),
            DropdownMenuItem(value: 'Uno 2000', child: Text('Uno 2000')),
            DropdownMenuItem(value: 'Gol 2015', child: Text('Gol 2015')),
          ],
          onChanged: (novo) {
            setState(() {
              selecionado = novo!;
            }
            );
          }
        ),

        centerTitle: true,
      ),
      
      body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
              children: [
          
                Card(
                  child: ListTile(
                    title: Text('10.542 km'),
                    trailing: IconButton(
                      onPressed: null,
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

                Card(
                  child: ListTile(
                    title: Text('Troca de Óleo'),
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    subtitle: Text('Previsão: 11.000 km'),
                  )
                ),
              ],
          ),
        ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.cadastrarVeiculo);
        },
        icon: Icon(Icons.add),
        label: Text('Cadastrar Veículo',
          style: TextStyle(fontSize: 16),
        ),
      ),

    );
  }
}