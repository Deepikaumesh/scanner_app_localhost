
import 'package:flutter/material.dart';
import 'package:scan_local/scanner_app/main_way.dart';

const Merchant_Key = "MerchantLoggedIn";
//String Customer_Key = "CustomerLoggedIn";
var uid_key = '';
var access_total_amt ='';
var uid_user ='';


final subTotal = 0;
var ip_address = '192.168.29.64';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: Main_way(),
    );
  }
}

