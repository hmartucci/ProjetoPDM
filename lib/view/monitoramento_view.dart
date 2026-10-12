import 'package:flutter/material.dart';

class MonitoramentoView extends StatefulWidget {
  const MonitoramentoView({super.key});

  @override
  State<MonitoramentoView> createState() => _MonitoramentoViewState();
}

class _MonitoramentoViewState extends State<MonitoramentoView> {
  String selecionado = 'Celta 2012';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Monitoramento'),
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

            SizedBox(height: 20),

            Card(
              color: Colors.green[100],

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Troca de óleo'),
                    Text('100%'),
                  ],
                ),
                subtitle: Text('Próxima troca em 5.000 km'),
              ),
            ),
            SizedBox(height: 20),

            Card(
              color: Colors.yellow[100],

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Troca de pneus'),
                    Text('50%'),
                  ],
                ),
                subtitle: Text('Próxima troca em 1.000 km'),
              ),
            ),

            SizedBox(height: 20),

            Card(
              color: Colors.red[200],

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alinhamento e balanceamento'),
                    Text('20%'),
                  ],
                ),
                subtitle: Text('Próximo alinhamento em 1.000 km'),
              ),
            ),


          ],
        ),
      ),
    );
  }
}