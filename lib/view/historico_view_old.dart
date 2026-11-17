import 'package:flutter/material.dart';
import 'package:p1/core/app_routes.dart';

class HistoricoView extends StatefulWidget {
  const HistoricoView({super.key});

  @override
  State<HistoricoView> createState() => _HistoricoViewState();
}

class _HistoricoViewState extends State<HistoricoView> {
  String selecionado = 'Celta 2012';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Histórico'),
      ),
      
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
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
            ),

            
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                title: Text('Troca de óleo'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data: 01/01/2024'),
                    Text('Quilometragem: 10.000 km'),
                    Text('Valor: R\$ 150,00'),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                title: Text('Troca de pneus'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data: 15/02/2024'),
                    Text('Quilometragem: 12.000 km'),
                    Text('Valor: R\$ 400,00'),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                title: Text('Alinhamento e balanceamento'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data: 10/03/2024'),
                    Text('Quilometragem: 15.000 km'),
                    Text('Valor: R\$ 120,00'),
                  ],
                ),
              ),
            ),
            
          ],
        ),

      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.cadastrarManutencao);
        },
        icon: Icon(Icons.add),
        label: Text('Nova manutenção'),
      ),
  
    );
  }
}