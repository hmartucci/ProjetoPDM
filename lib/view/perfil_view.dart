//08
import 'package:flutter/material.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
                'Perfil do Usuário',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
                'Alterar dados de cadastro',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            
            SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Nome',
              ),

              validator: (String? value) {
                if (value == null) {
                  return 'Campo obrigatório!';
                }
                return null;

              },
            ),

            SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'E-mail',
              ),
              initialValue: 'nome@email.com',
              enabled: false,

            ),

            SizedBox(height: 20),

            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },                      // PRECISA ATIVAR
                                                  
                  child: Text('Salvar Edições')
                ),
            ),
            


          ],
        ),
      ),
    );
  }
}
