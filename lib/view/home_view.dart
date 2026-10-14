import 'package:flutter/material.dart';
import 'package:p1/core/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selecionado = 'Celta 2012';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
              'Olá, Usuário!',
              style: TextStyle(
                fontSize: 24,
              ),
              ),
            
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil do Usuário'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.perfil);
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
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.login);
                },
            ),

            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('Configurações'),
            // ),
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
                      onPressed: null,  //altera a kilometragem
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