import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  String nomeUsuario = '';

  Future<void> carregarNome() async {
    try {
      final usuario = FirebaseAuth.instance.currentUser;
      if (usuario == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid)
          .get();

      nomeUsuario = (doc.data()?['nome'] as String?) ?? '';
    } catch (_) {
      nomeUsuario = '';
    } finally {
      notifyListeners();
    }
  }
}