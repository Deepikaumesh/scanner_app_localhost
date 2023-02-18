import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import 'Merchant_Dashboard.dart';
import 'Merchant_Registration.dart';



class Merchant_Login extends StatefulWidget {
  const Merchant_Login({Key? key}) : super(key: key);

  @override
  _Merchant_LoginState createState() => _Merchant_LoginState();
}

class _Merchant_LoginState extends State<Merchant_Login> {
  TextEditingController Merchant_user = TextEditingController();
  TextEditingController Merchant_pass = TextEditingController();
  final GlobalKey<FormState> Merchant_formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/log.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: Merchant_formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: Merchant_user,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter username";
                                }
                                return null;
                              },
                              onSaved: (name) {},
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: Merchant_pass,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                              onSaved: (name) {},
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Merchant_Login();
                                        });

                                        if (Merchant_formkey.currentState!.validate()) {
                                          print("Successfully  logged");
                                          Merchant_user.clear();
                                          Merchant_pass.clear();
                                        }
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, 'register');
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRegister()));
                                  },
                                  child: Text(
                                    'Does not have an account?',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Merchant_Registration()));
                                    },
                                    child: Text(
                                      //  'Forgot Password',
                                      'Sign Up',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Future Merchant_Login() async {
  var url =
      "http://$ip_address/MySampleApp/Scanner_App/Merchant/Merchant_login.php"; //intego wifi password
  //  var url ="https://anthracitic-pecks.000webhostapp.com/login.php";
  var response = await http.post(Uri.parse(url), body: {
    "username": Merchant_user.text,
    "password": Merchant_pass.text,
  });
  var data = json.decode(response.body);
  if (data.toString() == "Success") {
    // await  SessionManager().set('token', user.text);

    final snackBar = SnackBar(
      content: Text('Login Successfull'),
      duration: Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Merchant_Dashboard()));
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setBool(Merchant_Key, true);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Merchant_Dashboard()));
    print("username:");
  } else {
    final snackBar = SnackBar(
      content: Text('Username and password invalid'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Merchant_Dashboard()));
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

}