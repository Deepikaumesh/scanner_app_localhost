import 'package:flutter/material.dart';

import 'Customer/Customer_Splashsceen.dart';
import 'Merchant/Merchant_Login.dart';
import 'Merchant/Merchant_Splashscreen.dart';

class Main_way extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 200, horizontal: 60),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                // color: Colors.green,

                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/shop.png',
                    ),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.pink.shade900,
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 15, bottom: 15),
                        ),

                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Merchant_Splashscreen()));
                        },


                        //color: Colors.indigo,
                        child: Text(
                          'Merchant',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.pink.shade900,
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 15, bottom: 15),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Customer_Splashscreen()));
                        },
                        child: Text(
                          'Customer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
