import 'package:final_ecommerce/Models/product_model.dart';
import 'package:final_ecommerce/Utils/colors.dart';
import 'package:final_ecommerce/screens/Detail/items_detail_screen.dart';
import 'package:final_ecommerce/screens/Home/Widgets/banner.dart';
import 'package:final_ecommerce/screens/Home/Widgets/curated_items.dart';
import 'package:final_ecommerce/screens/Search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../Models/category_model.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            //for header part
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/logo.jpg",
                    height: 40,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Iconsax.shopping_bag,
                        size: 28,
                      ),
                      Positioned(
                        right: -3,
                        top: -5,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            //for banner
            const BannerWidget(),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shop By Category",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
            ),
            //for category
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  categoryList.length,
                  (index) => InkWell(
                    onTap: () {
                      //filter products based on the selected category
                      final filterItems = productList
                          .where((item) =>
                              item.category.toLowerCase() ==
                              categoryList[index].name.toLowerCase())
                          .toList();
                      //Navigator TO THE CATEGORY items screens
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchScreen(
                            category: categoryList[index].name,
                            categoryItems: filterItems,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: fbackgroundColor1,
                            backgroundImage: AssetImage(
                              categoryList[index].image,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(categoryList[index].name),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Curated For You",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
            ),

            //for curated items

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  productList.length,
                  (index) {
                    final productItems = productList[index];
                    return Padding(
                      padding: index == 0
                          ? const EdgeInsets.symmetric(horizontal: 20)
                          : const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ItemsDetailScreen(
                                item: productItems,
                              ),
                            ),
                          );
                        },
                        child: CuratedItems(
                            productItems: productItems, size: size),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
