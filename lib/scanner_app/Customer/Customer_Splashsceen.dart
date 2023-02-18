import 'dart:async';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'Customer_Login.dart';
import 'Customer_Dashboard.dart';




class Customer_Splashscreen extends StatefulWidget {
  _Customer_SplashscreenState createState() => _Customer_SplashscreenState();
}

class _Customer_SplashscreenState extends State<Customer_Splashscreen> {

  void initState() {
    checkCustomerLogedIn();
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "welcome",
            style: GoogleFonts.aclonica(
              color: Colors.red.shade900,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],


      ),
    );
  }
  Future gotoLogin_Customer() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Customer_Login()));
  }



  Future<void> checkCustomerLogedIn() async{
    final _sharedPrefs =await SharedPreferences.getInstance();
   // print("first key check "+Customer_Key);
    final _userid=_sharedPrefs.getString("userid");
    if(_userid == null){
      gotoLogin_Customer();
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Customer_Dashboard(uiddata: uid_key,)));
    }

  }


}