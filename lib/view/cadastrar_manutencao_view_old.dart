import 'package:flutter/material.dart';

class CadastrarManutencaoView extends StatefulWidget {
  const CadastrarManutencaoView({super.key});

  @override
  State<CadastrarManutencaoView> createState() => _CadastrarManutencaoViewState();
}

class _CadastrarManutencaoViewState extends State<CadastrarManutencaoView> {
  String selecionado = 'Celta 2012';
  String servico = 'Troca de óleo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastrar Manutenção'),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [

              DropdownButton<String>(
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

              SizedBox(height: 20),

              DropdownButton<String>(
                value: servico,
                hint: Text('Selecione o serviço'),
                items: [
                  DropdownMenuItem(value: 'Troca de óleo', child: Text('Troca de óleo')),
                  DropdownMenuItem(value: 'Troca de pneus', child: Text('Troca de pneus')),
                  DropdownMenuItem(value: 'Alinhamento e balanceamento', child: Text('Alinhamento e balanceamento')),
                ],

                onChanged: (novo) {
                  setState(() {
                    servico = novo!;
                  }
                  );
                }
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Quilometragem da Manutenção',
                ),
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Valor',
                ),
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Data da Manutenção',
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },                                              
                  child: Text('Cadastrar Manutenção'),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}