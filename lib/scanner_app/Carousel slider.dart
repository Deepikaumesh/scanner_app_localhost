import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel_slider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        //1st Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage("assets/images/p1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage("assets/images/p2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),


        //2nd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage("assets/images/p3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        //
      //  3rd Image of Slider
      //   Container(
      //     margin: EdgeInsets.all(6.0),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(8.0),
      //       image: DecorationImage(
      //         image: AssetImage("assets/images/pay4.jpg"),
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
        //
        //4th Image of Slider
        // Container(
        //   margin: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.0),
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/pay5.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),

        // //5th Image of Slider
        // Container(
        //   margin: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.0),
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/pay6.png"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.0),
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/pay6.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.all(6.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.0),
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/pay7.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
      ],

      //Slider Container properties
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        viewportFraction: 0.8,
      ),
    );
  }
}
