import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'Customer_Drawer_.dart';
import 'Customer_Login.dart';
import 'Customer_ViewCart.dart';

class Customer_Dashboard extends StatefulWidget {
  final uiddata;

  const Customer_Dashboard({required this.uiddata});

  @override
  _Customer_DashboardState createState() => _Customer_DashboardState();
}

class _Customer_DashboardState extends State<Customer_Dashboard> {
  TextEditingController textcontroller = TextEditingController();
  TextEditingController product_qty = TextEditingController();
  TextEditingController uid = TextEditingController();

  late bool status;
  late String message = "";

  var getResult = '';

  @override
  void initState() {
    textcontroller = TextEditingController();
    product_qty = TextEditingController(text: '1');
    uid = TextEditingController(
      text: widget.uiddata,
    );

    status = false;
    message = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.pink.shade900),

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
                  Customer_Signout(context);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.pink.shade900,
                ))
          ],
        ),
        drawer: Drawer(
          child: Customer_Drawer(),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),

              //Text("uid test"+widget.uiddata.toString()),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                  //  border: Border.all(),
                  // borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: AssetImage('assets/images/qr.png'),
                    //  fit: BoxFit.contain,
                  ),
                  //  color: Colors.grey,
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.blueGrey.shade600,
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15),
                  ),
                  onPressed: () {
                    scanQRCode();
                  },
                  child: Text(
                    'Scan Qr code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //  Text(getResult),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  onChanged: (_value) {
                    setState(() {
                      _value = widget.uiddata;
                    });
                  },
                  controller: textcontroller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "QR Code Result",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextFormField(
                  controller: product_qty,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      label: Text("Product Qty"),
                      //   hintText: "Qty",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                status ? message : message,
                style: GoogleFonts.lato(
                    fontSize: 12,
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
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
                        setState(() {
                          send_scan_value();
                        });
                        print("Successful");
                        textcontroller.clear();
                        uid.text = uid_key;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.add_shopping_cart),
                          Text(
                            'Add to cart',
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
                                builder: (context) => Customer_Viewcart()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart),
                          Text(
                            'View cart',
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
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      print("QRCode_Result:--");
      print(qrCode);
      textcontroller.text = qrCode;
      uid.text = widget.uiddata;
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  Customer_Signout(BuildContext ctx) async //using navigator so we need context
  {
    final _CustomersharedPrefs = await SharedPreferences.getInstance();
    await _CustomersharedPrefs.clear();
    //push new page and remove all other pages

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx1) => Customer_Login()),
        (route) => false);
  }

  Future send_scan_value() async {
    //  var APIURL = "https://anthracitic-pecks.000webhostapp.com/product.php"; //000webhost ip address
    var APIURL =
        "http://$ip_address/MySampleApp/Scanner_App/Customer/Add%20to_Cart_Product.php";

    //json maping user entered details
    Map mapeddate = {
      'productid': textcontroller.text,
      'product_qty': product_qty.text,
      'uid': uid.text,
    };
    print("disp");
    //send  data using http post to our php code
    http.Response response =
        await http.post(Uri.parse(APIURL), body: mapeddate);

    //   getting response from php code, here
    var data = jsonDecode(response.body);
    var responseMessage = data["message"];
    var responseError = data["error"];
    print("DATA: ${data}");
    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
    } else {
      //textcontroller.clear();
      // product_qty.clear();
      //  uid.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });
    }
  }
}

