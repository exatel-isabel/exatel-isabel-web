import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  /// Cadastrar usuario no firebase com e-mail e senha
  Future<String> signup(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains("email-already-in-use")) {
        return "E-mail já cadastrado";
      }
    }
    return "";
  }

  /// Login de usuario no firebase com e-mail e senha
  Future<String> signin(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      debugPrint(e.message);
      if (e.message!.contains("no user")) {
        return "E-mail não cadastrado!";
      } else if (e.message!.contains("password is invalid")) {
        return "Senha errada!";
      }
    }
    return "";
  }

  /// Envia e-mail de redefinição de senha
  Future<void> sendEmailPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  /// Faz logout do usuario
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

extension EmailValidator on String {
  bool get isNotEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
