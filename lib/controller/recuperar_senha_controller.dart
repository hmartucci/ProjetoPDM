import 'package:flutter/material.dart';

//04
class RecuperarSenhaController extends ChangeNotifier{
  final emailController = TextEditingController();

  String? erroEmail;

  bool recuperarSenha() {
    final email = emailController.text.trim();

    erroEmail = null;

    final emailValido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);

    if (email.isEmpty) {
      erroEmail = 'Informe o e-mail.';
    } else if (!emailValido) {
      erroEmail = 'E-mail inválido.';
    }

    if (erroEmail != null) {
      notifyListeners();
      return false;
    }

    if (email == 'admin@email.com') {
      return true;
    }

    erroEmail = 'E-mail não encontrado.';
    notifyListeners();
    return false;

  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}