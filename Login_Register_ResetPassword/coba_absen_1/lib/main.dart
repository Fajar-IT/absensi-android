import 'package:coba_absen_1/services/authen_services/authen_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import 'screens/homeScreens/wrapper.dart';


// const List<Color> _kDefaultRainbowColors = const [
//   Colors.red,
//   Colors.orange,
//   Colors.yellow,
//   Colors.green,
//   Colors.blue,
//   Colors.indigo,
//   Colors.purple,
// ];
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future:  _init,
        builder: (context, snapshot){
          if (snapshot.hasError){
            return ErrorWidget();
          } else if (snapshot.hasData){
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthenServices>.value(value: AuthenServices()),
                StreamProvider<User>.value(
                  value: AuthenServices().user,
                  initialData: null,
                  )
              ],
              child: MaterialApp(
                title:"Absen Digital",
                theme: ThemeData(
                  primarySwatch: Colors.red
                ),
                debugShowCheckedModeBanner: false,
                home: Wrapper(),
              ),
            );
          }
          else {
            return Loading();
          }
        },
      ),
    );
  }
}


class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
          Icon(Icons.error),
          Text('Something went wrong !')
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF424245),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   // ignore: missing_return
//   Void initState() {
//     super.initState();
//     Timer(Duration(seconds: 10), (){});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF424245),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/logo.png",
//               width: 200.0,
//               height: 200.0,
//             ),
//             SizedBox(height: 20,),
//           ],
//         ),
//       ),
//     );
//   }
// }
