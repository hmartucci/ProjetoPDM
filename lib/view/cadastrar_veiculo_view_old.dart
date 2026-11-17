import 'package:flutter/material.dart';


class CadastrarVeiculoView extends StatefulWidget {
  const CadastrarVeiculoView({super.key});

  @override
  State<CadastrarVeiculoView> createState() => _CadastrarVeiculoViewState();
}

class _CadastrarVeiculoViewState extends State<CadastrarVeiculoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastrar Veículo'),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Modelo',
                ),
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Ano',
                ),
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Placa',
                ),
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Quilometragem',
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
                  child: Text('Entrar')
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}