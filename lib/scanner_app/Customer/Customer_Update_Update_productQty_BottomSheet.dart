import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scan_local/main.dart';
import 'Customer_ViewCart.dart';

class Customer_Update_ProductQty_Bottomsheet extends StatefulWidget {

  final User data_user;

  const Customer_Update_ProductQty_Bottomsheet({required this.data_user});

  @override
  _Customer_Update_ProductQty_BottomsheetState createState() => _Customer_Update_ProductQty_BottomsheetState();
}

class _Customer_Update_ProductQty_BottomsheetState extends State<Customer_Update_ProductQty_Bottomsheet> {
  TextEditingController pro_id = TextEditingController();
  TextEditingController pro_name = TextEditingController();
  TextEditingController pro_price = TextEditingController();
 // TextEditingController pro_qty = TextEditingController();
  TextEditingController pro_stok = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController product_qty = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  setUp() {
    pro_id = TextEditingController(text: widget.data_user.productid);
    pro_name = TextEditingController(text: widget.data_user.productname);
    pro_price = TextEditingController(text: widget.data_user.productprice);
   // pro_qty = TextEditingController(text: widget.data_user.productqty);
    pro_stok = TextEditingController(text: widget.data_user.stock);
    image = TextEditingController(text: widget.data_user.image);
    product_qty=TextEditingController(text: widget.data_user.product_qty);
  }

  submit() async {
    print(widget.data_user.cid);
    print(product_qty);
    final response = await http.post(
        Uri.parse(
           "http://$ip_address/MySampleApp/Scanner_App/Customer/Update_product_Qty.php"),
          //"https://anthracitic-pecks.000webhostapp.com/scan_copy/Merchant/Update_productqty.php"),
        body: {
          "id": widget.data_user.cid.toString(),
          // "productid": pro_id.text,
          // "productname": pro_name.text,
          // "productprice": pro_price.text,
         // "productqty": pro_qty.text,
          // "stock": pro_stok.text,
          // "image": image.text,
          "product_qty":product_qty.text,
        });
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         // color: Colors.white,
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.data_user.image,
                  height: 200,
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Name:" + widget.data_user.productname),
                  SizedBox(height: 20,),
                  Text("Product Price:" + widget.data_user.productprice),
                  // Row(
                  //   children: [
                  //     Text("Product Qty:"),
                  //     SizedBox(
                  //       width: 20,
                  //       child: TextFormField(
                  //         controller: pro_qty,
                  //         textAlign: TextAlign.center,
                  //         decoration: new InputDecoration(
                  //           border: InputBorder.none,
                  //           focusedBorder: InputBorder.none,
                  //           enabledBorder: InputBorder.none,
                  //           errorBorder: InputBorder.none,
                  //           disabledBorder: InputBorder.none,
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       child: Icon(
                  //         Icons.arrow_drop_up,
                  //         size: 50,
                  //       ),
                  //       onTap: () {
                  //         int currentValue = int.parse(pro_qty.text);
                  //         setState(() {
                  //           currentValue++;
                  //           pro_qty.text = (currentValue).toString();
                  //         });
                  //       },
                  //     ),
                  //     InkWell(
                  //       child: Icon(
                  //         Icons.arrow_drop_down,
                  //         size: 50.0,
                  //       ),
                  //       onTap: () {
                  //         int currentValue = int.parse(pro_qty.text);
                  //         setState(() {
                  //           currentValue--;
                  //           pro_qty.text =
                  //               (currentValue > 0 ? currentValue : 1).toString();
                  //         });
                  //       },
                  //     ),
                  //
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text("Product_Qty:"),
                      SizedBox(
                        width: 20,
                        child: TextFormField(
                          controller: product_qty,
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 50,
                        ),
                        onTap: () {
                          int currentValue = int.parse(product_qty.text);
                          setState(() {
                            currentValue++;
                            product_qty.text = (currentValue).toString();
                          });
                        },
                      ),
                      InkWell(
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 50.0,
                        ),
                        onTap: () {
                          int currentValue = int.parse(product_qty.text);
                          setState(() {
                            currentValue--;
                            product_qty.text =
                                (currentValue > 0 ? currentValue : 1).toString();
                          });
                        },
                      ),

                    ],
                  )

                ],
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.teal.shade300,
                padding: EdgeInsets.only(
                    left: 50, right: 50, top: 15, bottom: 15),
              ),
              onPressed: () {
                setState(() {});
                submit();
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Text("Change Product Quantity"),
                        content: Text(
                            "Are you sure want to change the Product  quantity?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Viewcart()));
                               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Customer_Viewcart()));
                              //   Navigator.replace(
                              //     context,
                              //     oldRoute: MaterialPageRoute(builder: (context) =>Merchant_Update_Bottomsheet(data_user: widget.data_user)),
                              //     newRoute: MaterialPageRoute(builder: (context) => Viewcart()),
                              //   );
                              },
                              child: Text("ok")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel")),
                        ],
                      );
                    });
              },
              child: Text("Proceed"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

              },
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.red.shade900,
                padding: EdgeInsets.only(
                    left: 50, right: 50, top: 15, bottom: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
