import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthenServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  

  Future register (String email, String password)async{
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      return user;
    } on SocketException{
      setLoading(false);
      setMesaage("no internet");
    }
    catch (e) {
      setLoading(false);
      setMesaage(e.message);
    }
    notifyListeners();
  }

  Future login (String email, String password)async{
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      return user;
    } on SocketException{
      setLoading(false);
      setMesaage("no internet");
    }
    catch (e) {
      setLoading(false);
      setMesaage(e.message);
    }
    notifyListeners();
  }

  Future<void> reset(String email) async {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future logout ()async{
    await firebaseAuth.signOut();
  }
  
  void setLoading (val){
    _isLoading = val;
    notifyListeners();
  }

  void setMesaage (message){
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User> get user =>
    firebaseAuth.authStateChanges().map((event) => event);
}