import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_local/scanner_app/Admin/Admin_Drawer_.dart';
import 'package:scan_local/scanner_app/Admin/Admin_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Carousel slider.dart';
import 'Admin_View_Product_Stock.dart';
import 'Display_Customer_feedback_.dart';


class Admin_Dashboard extends StatefulWidget {
  @override
  _Admin_DashboardState createState() => _Admin_DashboardState();
}

class _Admin_DashboardState extends State<Admin_Dashboard> {
  Merchant_Signout(BuildContext ctx) async //using navigator so we need context
      {
    final _MerchanntsharedPrefs = await SharedPreferences.getInstance();
    await _MerchanntsharedPrefs.clear();
    //push new page and remove all other pages

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx1) => Admin_Login()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.pink.shade900),

        //  automaticallyImplyLeading: false,
        //for hiding default back arrow
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Dashboard",
            style:
            GoogleFonts.prompt(fontSize: 25, color: Colors.pink.shade900),
          ),
        ),

        actions: [
          IconButton(
              onPressed: () {
                Merchant_Signout(context);
              },
              icon: Icon(Icons.exit_to_app, color: Colors.pink.shade900))
        ],
      ),
      drawer: Drawer(
        child: Admin_Drawer(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                //border: Border.all(width: 0.5,color: Colors.pink),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: AssetImage("assets/images/qr.png"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 85, vertical: 10),
              height: 50,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                "Qr code scanner",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              color: Colors.blueGrey.shade100,
            ),
            SizedBox(
              height: 20,
            ),
            Carousel_slider(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  // width: double.infinity,
                  //  padding:
                  //  const EdgeInsets.only(top: 20, left: 110, right: 100,bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //  shape: StadiumBorder(),
                      backgroundColor: Colors.pink.shade900,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  customer_feedback_Display()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.star),
                        Text(
                          'Customer feedback',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  // width: MediaQuery.of(context).size.width,
                  //  padding:
                  //  const EdgeInsets.only(top: 20, left: 110, right: 110,bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //  shape: StadiumBorder(),
                      backgroundColor: Colors.teal.shade300,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Admin_View_Product_stock()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        Text(
                          'View products',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
