import 'package:flutter/material.dart';

class CadastrarUsuarioController extends ChangeNotifier{
  final nomeUsuarioController = TextEditingController();
  final emailController = TextEditingController();
  final numeroTelefoneController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  String? erroNomeUsuario;
  String? erroEmail;
  String? erroNumeroTelefone;
  String? erroSenha;
  String? erroConfirmarSenha;

  bool cadastrar() {
    final nomeUsuario = nomeUsuarioController.text;
    final email = emailController.text.trim();
    final numeroTelefone = numeroTelefoneController.text;
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;

    erroNomeUsuario = null;
    erroEmail = null;
    erroNumeroTelefone = null;
    erroSenha = null;
    erroConfirmarSenha = null;

    final emailValido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);

    if (nomeUsuario.isEmpty) {
      erroNomeUsuario = 'Informe o nome de usuário.';
    }

    if (email.isEmpty) {
      erroEmail = 'Informe o e-mail.';
    } else if (!emailValido) {
      erroEmail = 'E-mail inválido.';
    }

    if (numeroTelefone.isEmpty) {
      erroNumeroTelefone = 'Informe o número de telefone.';
    }

    if (senha.isEmpty) {
      erroSenha = 'Informe a senha.';
    }

    if (confirmarSenha.isEmpty) {
      erroConfirmarSenha = 'Confirme a senha.';
    } else if (senha != confirmarSenha) {
      erroConfirmarSenha = 'As senhas não coincidem.';
    }

    if (erroEmail != null || erroSenha != null || erroNomeUsuario != null || erroNumeroTelefone != null || erroConfirmarSenha != null) {
      notifyListeners();
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}