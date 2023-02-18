import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';


//Creating a class user to store the data;
class User {
  final String id;
  final String productid;
  final String productname;
  final String productprice;

  //final String productqty;
  final String image;
  final String stock;
  final String cid;
  final String product_qty;

  User({
    required this.id,
    required this.productid,
    required this.productname,
    required this.productprice,
    // required this.productqty,
    required this.image,
    required this.stock,
    required this.cid,
    required this.product_qty,
  });
}

class Customer_Orders extends StatefulWidget {
  @override
  _Customer_OrdersState createState() => _Customer_OrdersState();
}

class _Customer_OrdersState extends State<Customer_Orders> {
  num subTotal = 0;

  //Applying get request.
  Future<List<User>> getRequest() async {
    //replace your restFull API here.
    final _sharedPrefs = await SharedPreferences.getInstance();
    final ui = _sharedPrefs.getString("userid");

    String url =
        "http://$ip_address/MySampleApp/Scanner_App/Customer/order_items_Display.php?uid=" +
            ui!;

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<User> users = [];

    for (var singleUser in responseData) {
      User user = User(
        product_qty: singleUser["product_qty"].toString(),
        cid: singleUser["cartid"].toString(),
        id: singleUser["id"].toString(),
        productid: singleUser["productid"].toString(),
        productname: singleUser["productname"].toString(),
        productprice: singleUser["productprice"].toString(),
        // productqty: singleUser["productqty"].toString(),
        image: singleUser["image"].toString(),
        stock: singleUser["stock"].toString(),
      );

      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pink.shade900,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My orders",
          style: GoogleFonts.prompt(fontSize: 25, color: Colors.pink.shade900),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.card_giftcard,
                color: Colors.pink.shade900,
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data == false) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red.shade900,
                            strokeWidth: 5,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Loading...",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  List<User> _user = snapshot.data;
                  print("test" + returnTotalAmount(_user));

                  access_total_amt = returnTotalAmount(_user);
                  return Flexible(
                    child: Column(
                      children: [
                        // Text("hai"),
                        Flexible(
                          child: ListView.builder(
                              // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, index) {
                                return SingleChildScrollView(
                                  //  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      Card(
                                        shadowColor: Colors.red,
                                        elevation: 8,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          // color: Colors.red,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.fromLTRB(
                                              10, 15, 50, 15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  snapshot.data[index].image,
                                                  height: 100,
                                                  width: 100.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Name : " +
                                                        snapshot.data[index]
                                                            .productname,
                                                  ),
                                                  Text(
                                                    "Price : " +
                                                        snapshot.data[index]
                                                            .productprice,
                                                  ),

                                                  // Text(
                                                  //   "Product Qty : " +
                                                  //       snapshot
                                                  //           .data[index].productqty,
                                                  // ),
                                                  Text(
                                                    "Product Qty : " +
                                                        snapshot.data[index]
                                                            .product_qty,
                                                  ),
                                                  Text(
                                                    "Sub Total : " +
                                                        ProductCalculations
                                                            .getTotalRateFromString(
                                                                productPrice: snapshot
                                                                    .data[index]
                                                                    .productprice,
                                                                Quantity: snapshot
                                                                    .data[index]
                                                                    .product_qty),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }


  String returnTotalAmount(List<User> _user) {
    double totalAmount = 0.0;
    for (int i = 0; i < _user.length; i++) {
      totalAmount = totalAmount +
          (double.parse(_user[i].productprice) *
              double.parse(_user[i].product_qty));
    }
    return totalAmount.toString();
  }
}

class ProductCalculations {
  static String getTotalRateFromString(
      {required String productPrice, required String Quantity}) {
    String rate = "";
    double _Quantity = double.parse(Quantity);
    double _productPrice = double.parse(productPrice);

    double totalAmount = _Quantity * _productPrice;
    rate = totalAmount.toInt().ceil().toString();

    return rate;
  }
}
