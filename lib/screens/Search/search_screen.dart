import 'package:final_ecommerce/Models/product_model.dart';
import 'package:final_ecommerce/Utils/colors.dart';
import 'package:final_ecommerce/screens/Detail/items_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatelessWidget {
  final String category;
  final List<Product> categoryItems;
  const SearchScreen(
      {super.key, required this.category, required this.categoryItems});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintText: "$category's Fashion",
                          hintStyle: const TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: fbackgroundColor2,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Iconsax.search_normal,
                            color: Colors.black38,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: categoryItems.isEmpty
                  ? const Center(
                      child: Text(
                        "No items available in this category.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categoryItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final item = categoryItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemsDetailScreen(item: item),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: item.image,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: fbackgroundColor2,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(item.image),
                                    ),
                                  ),
                                  height: size.height * 0.25,
                                  width: size.width * 0.5,
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.black26,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "H&M",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 17,
                                  ),
                                  Text(item.rating.toString()),
                                  Text(
                                    "(${item.review})",
                                    style: const TextStyle(
                                      color: Colors.black26,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.5,
                                child: Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${item.price.toString()}.00",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.pink,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  if (item.isCheck == true)
                                    Text(
                                      "\$${item.price + 250}.00",
                                      style: const TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black26,
                                      ),
                                    )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
