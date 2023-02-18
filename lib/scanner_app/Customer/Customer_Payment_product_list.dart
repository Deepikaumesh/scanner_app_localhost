import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Carousel slider.dart';
import '../../main.dart';
import 'Customer_Online_Payment.dart';



//Creating a class user to store the data;
class User_Model {
  final String id;
  final String productid;
  final String productname;
  final String productprice;

  //final String productqty;
  final String image;
  final String stock;
  final String cid;
  final String product_qty;

  User_Model({
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

class Customer_Payment_Page extends StatefulWidget {
  @override
  _Customer_Payment_PageState createState() => _Customer_Payment_PageState();
}

class _Customer_Payment_PageState extends State<Customer_Payment_Page> {
  //Applying get request.
  Future<List<User_Model>> getRequest() async {
    //replace your restFull API here.

    final _sharedPrefs = await SharedPreferences.getInstance();
    final  ui = _sharedPrefs.getString("userid");
    String url =
        "http://$ip_address/MySampleApp/Scanner_App/Merchant/Merchant_cust_join_cartDisplay.php?uid="+ui!;

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<User_Model> users = [];
    for (var singleUser in responseData) {
      User_Model user = User_Model(
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

      //Adding user to the list.
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
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Payment",
          style: GoogleFonts.prompt(fontSize: 25,color: Colors.pink.shade900),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          //color: Colors.pink.shade500,
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Text("Cash Payment",style: TextStyle(color: Colors.pink.shade500),),
                        content: Text(
                            "Go to bill counter and Show total amount for cash payment"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Customer_Payment_Page()));
                              },
                              child: Text("ok",style: TextStyle(color: Colors.pink.shade500,)),),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel",style: TextStyle(color: Colors.pink.shade500)),),
                        ],
                      );
                    });
              },
              child: Text("Cash Payment",style: TextStyle(color: Colors.pink.shade500,fontSize: 22),),
          ),
          //VerticalDivider(width: 2,),
          Container(
            height: 40,
            width: 1,
            color: Colors.blueGrey,
          ),
          TextButton(onPressed: () {
            print("key access test"+uid_key);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Customer_online_payment(cart_data: access_total_amt,)));
          }, child: Text("Online Payment",style: TextStyle(color:  Colors.teal.shade300,fontSize: 22),))
        ],
      )),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
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
                            "Data Loading Please wait",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  List<User_Model> _user = snapshot.data;
                  return Flexible(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Carousel_slider(),
                        // Container(
                        //   height: 200,
                        //   width: 300,
                        //   // color: Colors.red,
                        //  child: Image.asset("assets/images/payment.jpg",),
                        // ),
                        SizedBox(height: 20,),
                        Text(
                          "Your Products:",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 18),
                        ),
                        Flexible(
                          child: ListView.builder(
                              // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    Divider(
                                      color: Colors.blueGrey,
                                      thickness: 0.5,
                                    ),
                                    ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.network(
                                          snapshot.data[index].image,
                                        ),
                                      ),
                                      // ClipRRect(
                                      //       borderRadius:
                                      //       BorderRadius.circular(8.0),
                                      //       child: Image.network(
                                      //         snapshot.data[index].image,
                                      //         height: 100,
                                      //         width: 100.0,
                                      //         fit: BoxFit.cover,
                                      //       ),
                                      //     ),
                                      title: Text(
                                        "Name : " +
                                            snapshot.data[index].productname,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                Text(
                                  "Sub Total : " +
                                      ProductCalculation
                                          .getTotalRateFromString(
                                              productPrice: snapshot
                                                  .data[index]
                                                  .productprice,
                                              Quantity: snapshot
                                                  .data[index]
                                                  .product_qty),
                                ),
                                          Text( "Product Qty : " +snapshot.data[index].product_qty),
                                        ],
                                      ),

                                      // trailing: Text(
                                      //   "Sub Total : " +
                                      //       ProductCalculation
                                      //           .getTotalRateFromString(
                                      //               productPrice: snapshot
                                      //                   .data[index]
                                      //                   .productprice,
                                      //               Quantity: snapshot
                                      //                   .data[index]
                                      //                   .product_qty),
                                      // ),
                                    )
                                    // Card(
                                    //   shadowColor: Colors.red,
                                    //   elevation: 8,
                                    //   clipBehavior: Clip.antiAlias,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(8),
                                    //   ),
                                    //   child: Container(
                                    //     // color: Colors.red,
                                    //     height:
                                    //     MediaQuery.of(context).size.height / 5,
                                    //     width: MediaQuery.of(context).size.width,
                                    //     padding:
                                    //     EdgeInsets.fromLTRB(10, 15, 50, 15),
                                    //     child: Row(
                                    //       crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //       children: [
                                    //         ClipRRect(
                                    //           borderRadius:
                                    //           BorderRadius.circular(8.0),
                                    //           child: Image.network(
                                    //             snapshot.data[index].image,
                                    //             height: 100,
                                    //             width: 100.0,
                                    //             fit: BoxFit.cover,
                                    //           ),
                                    //         ),
                                    //         Spacer(),
                                    //         Column(
                                    //           crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //           children: [
                                    //             Text(
                                    //               "Name : " +
                                    //                   snapshot
                                    //                       .data[index].productname,
                                    //             ),
                                    //             Text(
                                    //               "Price : " +
                                    //                   snapshot
                                    //                       .data[index].productprice,
                                    //             ),
                                    //
                                    //             // Text(
                                    //             //   "Product Qty : " +
                                    //             //       snapshot
                                    //             //           .data[index].productqty,
                                    //             // ),
                                    //             Text(
                                    //               "Product Qty : " +
                                    //                   snapshot
                                    //                       .data[index].product_qty,
                                    //             ),
                                    //             Text(
                                    //               "Sub Total : " +
                                    //                   ProductCalculations
                                    //                       .getTotalRateFromString(
                                    //                       productPrice: snapshot
                                    //                           .data[index]
                                    //                           .productprice,
                                    //                       Quantity: snapshot
                                    //                           .data[index]
                                    //                           .product_qty),
                                    //             ),
                                    //
                                    //             Row(
                                    //               mainAxisAlignment:
                                    //               MainAxisAlignment
                                    //                   .spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   "Remove",
                                    //                   style: GoogleFonts.aBeeZee(
                                    //                       color:
                                    //                       Colors.red.shade900),
                                    //                 ),
                                    //                 IconButton(
                                    //                     onPressed: () {
                                    //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewcart_customer()));
                                    //                       setState(() {
                                    //                         delrecord(snapshot
                                    //                             .data[index].cid);
                                    //                       });
                                    //                     },
                                    //                     icon: Icon(Icons.clear,
                                    //                         size: 20,
                                    //                         color: Colors
                                    //                             .red.shade900)),
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         Padding(
                                    //             padding: EdgeInsets.only(
                                    //                 top: 20, bottom: 20, left: 20),
                                    //
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   showModalBottomSheet(context: context, builder: (context) =>
                                    //                       Merchant_Update_Bottomsheet(
                                    //                         data_user: snapshot
                                    //                             .data[index],
                                    //                       ));
                                    //                 },
                                    //                 icon: Icon(
                                    //                     Icons.arrow_forward_ios)))
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                  ],
                                );
                              }),
                        ),
                        Divider(
                          color: Colors.blueGrey,
                          thickness: 0.5,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              // color: Colors.pink.shade50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "\$${returnTotalAmount(_user)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            )),
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

  String returnTotalAmount(List<User_Model> _user) {
    double totalAmount = 0.0;
    for (int i = 0; i < _user.length; i++) {
      totalAmount = totalAmount +
          (double.parse(_user[i].productprice) *
              double.parse(_user[i].product_qty));
    }
    return totalAmount.toString();
  }
}

class ProductCalculation {
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
