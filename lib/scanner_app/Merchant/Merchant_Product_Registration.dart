import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scan_local/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Merchant_Login.dart';

class Merchant_Product_Registration extends StatefulWidget {


  @override
  _Merchant_Product_RegistrationState createState() =>
      _Merchant_Product_RegistrationState();
}

class _Merchant_Product_RegistrationState extends State<Merchant_Product_Registration> {
  var getResult = '';
  var _image;
  final picker = ImagePicker();
  TextEditingController Productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  //TextEditingController productqty = TextEditingController(text: '1');
  TextEditingController qr_controller = TextEditingController();
  TextEditingController stock = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();




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
      qr_controller.text = qrCode;
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  signout(BuildContext ctx) async //using navigator so we need context
  {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
    //push new page and remove all other pages

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx1) => Merchant_Login()),
        (route) => false);
  }

  Future choose_image() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadImage() async {
    final uri = Uri.parse(
        "http://$ip_address/MySampleApp/Scanner_App/Merchant/Add_Product_to_db.php");
   // "http://192.168.29.64/MySampleApp/Scanner_App/Merchant/Add_Product_to_db.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['productid'] = qr_controller.text;
    request.fields['productname'] = Productname.text;
    request.fields['productprice'] = productprice.text;
  //  request.fields['productqty'] = productqty.text;
    request.fields['stock'] = stock.text;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();
    print(response);


    if (response.statusCode == 200) {
      print('Image Uploded');
      qr_controller.clear();
      productprice.clear();
    //  productqty.clear();
      Productname.clear();
      stock.clear();

      final snackBar = await SnackBar(
        content: const Text('Product Added Successfully!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Image Not Uploded');
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
        "Product Registration",style: GoogleFonts.prompt(fontSize: 25,color: Colors.pink.shade900),
          ),
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(Icons.arrow_back))
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/qr.png'),
                    //  fit: BoxFit.contain,
                  ),
                  //  color: Colors.grey,
                ),
              ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  controller: qr_controller,
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
                      hintText: "Qr Code Result",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextFormField(
                  controller: Productname,
                  keyboardType: TextInputType.text,
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
                      hintText: "Please enter product name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  controller: productprice,
                  keyboardType: TextInputType.number,
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
                      hintText: "Please enter poduct price",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 40,
              //   ),
              //   child: TextFormField(
              //     controller: productqty,
              //     keyboardType: TextInputType.number,
              //     style: TextStyle(color: Colors.black),
              //     decoration: InputDecoration(
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           borderSide: BorderSide(
              //             color: Colors.black,
              //           ),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           borderSide: BorderSide(
              //             color: Colors.black,
              //           ),
              //         ),
              //         label: Text("Product Quantity"),
              //         hintText: "product qty",
              //         hintStyle: TextStyle(color: Colors.grey),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         )),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: stock,
                  keyboardType: TextInputType.number,
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
                      hintText: "Please stock",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Choose Image",
                    style: GoogleFonts.hindVadodara(
                      fontSize: 20,
                      color: Colors.cyan,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.photo_outlined,
                      size: 35,
                      color: Colors.cyan,
                    ),
                    onPressed: () {
                      choose_image();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 35,
                      color: Colors.cyan,
                    ),
                    onPressed: () {
                      pickImageC();
                    },
                  ),
                ],
              ),
              Center(
                child: Container(
                    height: 100,
                    width: 200,
                    //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),  color: Colors.grey,
                    //),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _image != null
                          ? Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                              "No image selected",
                              style: GoogleFonts.hindVadodara(
                                  fontSize: 13, color: Colors.red.shade900),
                            )),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.pink.shade900,
                  padding: EdgeInsets.only(
                      left: 110, right: 110, top: 20, bottom: 20),
                ),
                onPressed: () {
                  setState(() {});
                  uploadImage();
                },

                child: Text('Submit'),
              ),
              // Text(
              //   status ? message : message,
              //   style: GoogleFonts.lato(
              //       fontSize: 12,
              //       color: Colors.red.shade900,
              //       fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 15,
              ),
         //  ElevatedButton(onPressed: (){
         // //Navigator.pushReplacementNamed(context, "'Merchant_Product_Registration'");
         //  }, child: Text("refresh"))
          //     ElevatedButton(onPressed: (){
          // //Navigator.push(context, MaterialPageRoute(builder: (context)=> Merchant_Product_Registration()));
          // //       Navigator.pushAndRemoveUntil(
          // //         context,
          // //         MaterialPageRoute(builder: (context) => Merchant_Product_Registration() ),
          // //             (Route<dynamic> route) => false,
          // //       );
          //     }, child: Text("Refresh Page"))
            ],
          ),
        ),
      ),
    );
  }
}
