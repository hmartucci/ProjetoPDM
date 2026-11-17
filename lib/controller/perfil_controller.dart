import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilController extends ChangeNotifier {
  final nomeUsuarioController = TextEditingController();
  final emailController = TextEditingController();

  String? erroNomeUsuario;
  bool carregando = false;
  bool salvando = false;

  Future<void> carregarDados() async {
    carregando = true;
    notifyListeners();

    try {
      final usuario = FirebaseAuth.instance.currentUser;
      if (usuario == null) return;

      emailController.text = usuario.email ?? '';

      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid)
          .get();

      nomeUsuarioController.text = (doc.data()?['nome'] as String?) ?? '';
    } catch (_) {
      erroNomeUsuario = 'Não foi possível carregar os dados.';
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<bool> salvar() async {
    final nomeUsuario = nomeUsuarioController.text.trim();

    erroNomeUsuario = null;

    if (nomeUsuario.isEmpty) {
      erroNomeUsuario = 'Informe o nome de usuário.';
      notifyListeners();
      return false;
    }

    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) {
      erroNomeUsuario = 'Você não está logado.';
      notifyListeners();
      return false;
    }

    salvando = true;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid)
          .set({'nome': nomeUsuario}, SetOptions(merge: true));

      return true;
    } on FirebaseException catch (_) {
      erroNomeUsuario = 'Não foi possível salvar. Tente novamente.';
      return false;
    } catch (_) {
      erroNomeUsuario = 'Erro inesperado. Tente novamente.';
      return false;
    } finally {
      salvando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nomeUsuarioController.dispose();
    emailController.dispose();
    super.dispose();
  }
}