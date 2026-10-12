//09
import 'package:flutter/material.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
                'Recuperar Senha',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            
            SizedBox(height: 20),

            TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@email.com',
                ),
              ),
            
            SizedBox(height: 20),

            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },                              // PRECISA ATIVAR
                  child: Text('Recuperar Senha')
                ),
            ),

          ],
        )
      ),
    );
  }
}
