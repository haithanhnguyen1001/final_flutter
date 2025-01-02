import 'package:final_ecommerce/screens/Cart/cart_screen.dart';
import 'package:final_ecommerce/screens/Favourite/favourite.dart';
import 'package:final_ecommerce/screens/Home/app_home_screen.dart';
import 'package:final_ecommerce/screens/Search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'Profile/user_info_screen.dart';
import 'Search/search_widget.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  final List pages = [
    const AppHomeScreen(),
    const Favorite(),
    const SearchWidget(),
    UserInfoScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
