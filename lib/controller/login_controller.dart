import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends ChangeNotifier{
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  String? erroEmail;
  String? erroSenha;
  bool carregando = false;

  Future<bool> entrar() async {
    final email = emailController.text.trim();
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

    carregando = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          erroEmail = 'E-mail inválido.';
          break;
        case 'invalid-credential':
        case 'user-not-found':
        case 'wrong-password':
          erroSenha = 'E-mail ou senha incorretos.';
          break;
        case 'user-disabled':
          erroEmail = 'Esta conta foi desativada.';
          break;
        case 'too-many-requests':
          erroSenha = 'Muitas tentativas. Tente novamente mais tarde.';
          break;
        case 'network-request-failed':
          erroSenha = 'Sem conexão com a internet.';
          break;
        default:
          erroSenha = 'Erro ao entrar. Tente novamente.';
      }
      return false;
    } catch (_) {
      erroSenha = 'Erro inesperado. Tente novamente.';
      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}