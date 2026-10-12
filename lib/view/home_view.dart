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
        backgroundColor: Color(0xFF2A1A1A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2A1A1A),
              ),
            
              child: Text(
              'Ferramentas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              ),
            
            ),
            
            // ListTile(
            //   leading: Icon(Icons.home, color: Colors.white),
            //   title: Text('Início', style: TextStyle(color: Colors.white)),
            // ),

            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text('Perfil do Usuário', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.perfil);
                },
            ),

            ListTile(
              leading: Icon(Icons.list_alt, color: Colors.white),
              title: Text('Histórico', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.historico);
                },
            ),

            ListTile(
              leading: Icon(Icons.speed, color: Colors.white),
              title: Text('Monitoramento', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.monitoramento);
              },
            ),

            ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text('Sobre', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.sobre);
                },
            ),
            
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Sair', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.login);
                },
            ),

            // ListTile(
            //   leading: Icon(Icons.settings, color: Colors.white),
            //   title: Text('Configurações', style: TextStyle(color: Colors.white)),
            // ),
          ],
        ),
      ),
      
      
      appBar: AppBar(

        title: DropdownButton<String>(
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
        // backgroundColor: Color(0xFF2A1A1A),
        // foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      
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
                style: TextStyle(fontSize: 25),
              ),

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
        label: Text('Cadastrar Veículo'),
      ),

    );
  }
}