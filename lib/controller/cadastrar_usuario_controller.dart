import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastrarUsuarioController extends ChangeNotifier {
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
  bool carregando = false;

  bool get temErro => [
        erroNomeUsuario,
        erroEmail,
        erroNumeroTelefone,
        erroSenha,
        erroConfirmarSenha,
      ].any((erro) => erro != null);

  Future<bool> cadastrar() async {
    final nomeUsuario = nomeUsuarioController.text.trim();
    final email = emailController.text.trim();
    final telefone = numeroTelefoneController.text.replaceAll(RegExp(r'\D'), '');
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

    if (telefone.isEmpty) {
      erroNumeroTelefone = 'Informe o número de telefone.';
    } else if (telefone.length < 10 || telefone.length > 11) {
      erroNumeroTelefone = 'Número de telefone inválido.';
    }

    if (senha.isEmpty) {
      erroSenha = 'Informe a senha.';
    } else if (senha.length < 6) {
      erroSenha = 'A senha deve ter no mínimo 6 caracteres.';
    }

    if (confirmarSenha.isEmpty) {
      erroConfirmarSenha = 'Confirme a senha.';
    } else if (senha != confirmarSenha) {
      erroConfirmarSenha = 'As senhas não coincidem.';
    }

    if (temErro) {
      notifyListeners();
      return false;
    }

    carregando = true;
    notifyListeners();

    User? usuario;

    try {
      final credencial = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);

      usuario = credencial.user;

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario!.uid)
          .set({
        'nome': nomeUsuario,
        'email': email,
        'telefone': telefone,
        'criadoEm': FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          erroEmail = 'Este e-mail já está cadastrado.';
          break;
        case 'invalid-email':
          erroEmail = 'E-mail inválido.';
          break;
        case 'weak-password':
          erroSenha = 'Senha muito fraca.';
          break;
        case 'network-request-failed':
          erroEmail = 'Sem conexão com a internet.';
          break;
        default:
          erroEmail = 'Erro ao cadastrar. Tente novamente.';
      }
      return false;
    } on FirebaseException catch (_) {
      await usuario?.delete();
      erroEmail = 'Não foi possível salvar os dados. Tente novamente.';
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
    nomeUsuarioController.dispose();
    emailController.dispose();
    numeroTelefoneController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }
}