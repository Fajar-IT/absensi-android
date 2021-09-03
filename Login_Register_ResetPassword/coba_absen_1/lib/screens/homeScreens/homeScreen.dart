
import 'package:coba_absen_1/services/authen_services/authen_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthenServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await loginProvider.logout();
            }
            )
        ],
      ),
    );
  }
}