
import 'package:coba_absen_1/screens/authen/authen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User> (context);
    if (user != null){
      return HomeScreens();
    } else {
      return Authentication();
    }
  }
}