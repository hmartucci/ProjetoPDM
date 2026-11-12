import 'package:flutter/material.dart';

//02
class LoginController extends ChangeNotifier{
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  String? erroEmail;
  String? erroSenha;

  bool entrar() {
    final email = emailController.text.trim(); // trim tira espaços
    final senha = senhaController.text;

    erroEmail = null;
    erroSenha = null;

    final emailValido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);

    if (email.isEmpty) {
      erroEmail = 'Informe o e-mail.';
    } else if (!emailValido) {
      erroEmail = 'E-mail inválido.';
    }

    if (senha.isEmpty) {
      erroSenha = 'Informe a senha.';
    }

    if (erroEmail != null || erroSenha != null) {
      notifyListeners();
      return false;
    }

    if (email == 'admin@email.com' && senha == '123456') {
      return true;
    }

    erroSenha = 'E-mail ou senha incorretos.';
    notifyListeners();
    return false;
  }

  // Libera memória quando a tela fecha
  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}