import 'package:exam_3/screens/home_page_v1.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(),),
              );
            },
            child: Image.asset(
              "assets/icons/home.png",
              
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Image.asset("assets/icons/orders.png"),
          ),
          TextButton(
            onPressed: () {},
            child: Image.asset("assets/icons/cart.png"),
          ),
          TextButton(
            onPressed: () {},
            child: Image.asset("assets/icons/search.png"),
          ),
          TextButton(
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomePage,),
              // );
            },
            child: Image.asset("assets/icons/profile.png"),
          ),
        ],
      ),
    );
  }
}
