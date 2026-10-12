//10
import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              title: Text(
                'Sobre',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            Text(
              'Objetivo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Text(
              'Facilitar o gerenciamento de manutenção de veículos,'
              'permitindo que os usuários acompanhem o histórico de serviços realizados,'
              'consultem manutenções futuras e tenham acesso a informações importantes sobre seus veículos.',
            ),

            SizedBox(height: 20),

            Text(
              'Desenvolvido por',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Text(
              'Heitor Martucci'
            ),
            
            SizedBox(height: 20),

            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Desenvolvido por'),
                    subtitle: Text('Heitor Martucci'),
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Disciplina'),
                    subtitle: Text('Programação em Dispositivos Móveis'),
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Instituição'),
                    subtitle: Text('Fatec - Ribeirão Preto'),
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(Icons.co_present),
                    title: Text('Professor Orientador'),
                    subtitle: Text('Rodrigo Plotze'),
                  ),
                  Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('Versão do Aplicativo'),
                    subtitle: Text('1.0.0'),
                  ),
                ],
              ),
            ),

            

            

          ],
        
        
        ),
      ),
    );
  }
}