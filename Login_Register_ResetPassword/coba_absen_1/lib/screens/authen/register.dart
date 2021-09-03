

// import 'package:coba_absen_1/screens/authen/login_screens.dart';
import 'package:coba_absen_1/services/authen_services/authen_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  const Register({Key key, this.toggleScreen}) : super(key: key);


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF424245),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 110.0),
          children: <Widget>[
            Image.asset(
              "assets/icon_1.png",
              width: 105.0,
              height: 105.0,
              ) ,
            Center(
              child: Column(
                children: <Widget>[
                  _titleDescription(),
                  _textField(),
                  // _buildButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 90.0),
        ),
        Text(
          "Register",
          style: TextStyle(
            fontFamily: "SFProDisplay",
            color: Color(0xFFFF1741),
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

Widget _textField() {
  final loginProvider = Provider.of<AuthenServices>(context);
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (val) => val.isNotEmpty ? null : 'Please Masukkan Emailnya dong',
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFEBEBEB),
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 19.0),
                ),
                TextFormField(
                  validator: (val) => val.length < 6 ? 'Masukkan pasword lebih dari 6 karakter' : null,
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFEBEBEB),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock_outline_sharp,
                    )
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0,),
                Container(
                  // ignore: deprecated_member_use
                    child: FlatButton(
                    onPressed: () async{
                      if (_formkey.currentState.validate()){
                        print("Email: ${_emailController.text}");
                        print("Email: ${_passwordController.text}");
                        await loginProvider.register(
                          _emailController.text.trim(),
                          _passwordController.text.trim()
                        );
                      }
                      Fluttertoast.showToast(
                        msg: "Register Berhasil",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xFFFF1741),
                        textColor: Colors.white,
                        fontSize: 12.0);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreens()));
                    },
                    minWidth: loginProvider.isLoading ? null : double.infinity,
                    color: Color(0xFFFF1741),
                    padding: EdgeInsets.all(13.0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 6.0)),
                        Text(
                          "Register",
                          style: TextStyle(
                            fontFamily: "SFProDisplay",
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah Punya Akun ?",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontFamily: "SFProDisplay",
                    ),),
                    TextButton(onPressed: () => widget.toggleScreen(),
                    child: Text("LOGIN",
                    style: TextStyle(
                      color: Color(0xFFFF1741),
                      fontFamily: "SFProDisplay",
                    ),))
                  ],
                ),
                SizedBox(height: 30,),
                if (loginProvider.errorMessage != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.amber,
                  child: ListTile (
                    title: Text(loginProvider.errorMessage),
                    leading: Icon(Icons.error),
                    trailing: IconButton(
                      icon: Icon(Icons.close), 
                      onPressed: () => loginProvider.setMesaage(null),
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    ],
  );
}
}
