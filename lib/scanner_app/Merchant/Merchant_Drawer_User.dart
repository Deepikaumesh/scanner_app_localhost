
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Customer/Customer_About_Us.dart';
import 'Merchant_Login.dart';



class Merchant_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70.0,
                  backgroundImage: AssetImage(
                    "assets/images/qr_pro.png",
                  ),
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Scanner App",
                    style: GoogleFonts.aclonica(
                      color: Colors.pink.shade900,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => About_Us()));
          },
          leading: Icon(
            Icons.apps,
            color: Colors.blueGrey.shade900,
          ),
          title: Text("About",
              style: GoogleFonts.prompt(
                fontSize: 15,
              )),
        ),
        ListTile(
          onTap: () {
            Customer_Signout(context);
          },
          leading: Icon(
            Icons.logout,
            color: Colors.blueGrey.shade900,
          ),
          title: Text("Logout",
              style: GoogleFonts.prompt(
                fontSize: 15,
              )),
        ),
      ]),
    );
  }
  Customer_Signout(BuildContext ctx) async //using navigator so we need context
      {
    final _CustomersharedPrefs = await SharedPreferences.getInstance();
    await _CustomersharedPrefs.clear();
    //push new page and remove all other pages

    Navigator.pushAndRemoveUntil(
      ctx,
        MaterialPageRoute(builder: (ctx1) => Merchant_Login()),
            (route) => false);
    print("loggged out");
  }



}
