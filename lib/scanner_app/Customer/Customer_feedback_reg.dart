import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


import '../../main.dart';

class Customer_feedback_reg extends StatefulWidget {
  @override
  _Customer_feedback_regState createState() =>
      _Customer_feedback_regState();
}

class _Customer_feedback_regState
    extends State<Customer_feedback_reg> {
  TextEditingController feedback = new TextEditingController();



  late bool status;
  late String message;

  @override
  void initState() {
    feedback = TextEditingController();



    status = false;
    message = "";

    super.initState();
  }

  Future<void> submitData() async {
    var send = await http.post(
        Uri.parse(
            "http://$ip_address/MySampleApp/Scanner_App/Customer/customer_feedback_reg.php"),
        body: {
          "feedback": feedback.text,

        });

    if (send.statusCode == 200) {
      var data = json.decode(send.body);
      var responseMessage = data["message"];
      var responseError = data["error"];
      if (responseError) {
        setState(() {
          status = false;
          message = responseMessage;
        });
      } else {
        feedback.clear();


        setState(() {
          status = true;
          message = responseMessage;
        });
      }
    } else {
      setState(() {
        message = "Error:Server error";
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Feedback",
          style: GoogleFonts.prompt(fontSize: 25, color: Colors.pink.shade900),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Icon(
        //     Icons.arrow_back_rounded, color: Colors.pink.shade300,
        //     size: 35, // add custom icons also
        //   ),
       // ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(

              child: Column(
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      maxLines: 5,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "feedback Should not empty!";
                        }

                        return null;
                      },
                      controller: feedback,
                      decoration: InputDecoration(
                        labelText: "Enter your feedback",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.pink.shade900,
                      padding: EdgeInsets.only(
                          left: 110, right: 110, top: 20, bottom: 20),
                    ),
                    onPressed: () {

                        setState(() {
                          submitData();
                        });
                        feedback.clear();


                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 15,),
                  Text(status ? message : message,style: GoogleFonts.adamina(),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
