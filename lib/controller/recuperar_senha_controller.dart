import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecuperarSenhaController extends ChangeNotifier {
  final emailController = TextEditingController();

  String? erroEmail;
  bool carregando = false;

  Future<bool> recuperarSenha() async {
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

    carregando = true;
    notifyListeners();

    try {
      FirebaseAuth.instance.setLanguageCode('pt-BR');
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          erroEmail = 'E-mail inválido.';
          break;
        case 'user-not-found':
          erroEmail = 'Não existe conta com este e-mail.';
          break;
        case 'too-many-requests':
          erroEmail = 'Muitas tentativas. Tente novamente mais tarde.';
          break;
        case 'network-request-failed':
          erroEmail = 'Sem conexão com a internet.';
          break;
        default:
          erroEmail = 'Erro ao enviar o e-mail. Tente novamente.';
      }
      return false;
    } catch (_) {
      erroEmail = 'Erro inesperado. Tente novamente.';
      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}