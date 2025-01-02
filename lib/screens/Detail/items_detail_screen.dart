import 'package:final_ecommerce/Models/product_model.dart';
import 'package:final_ecommerce/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ItemsDetailScreen extends StatefulWidget {
  final Product item;
  const ItemsDetailScreen({super.key, required this.item});

  @override
  State<ItemsDetailScreen> createState() => _ItemsDetailScreenState();
}

class _ItemsDetailScreenState extends State<ItemsDetailScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbackgroundColor2,
        title: const Text("Detail Product"),
        actions: [
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
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: fbackgroundColor2,
            height: size.height * 0.46,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Hero(
                      tag: widget.item.image,
                      child: Image.asset(
                        widget.item.image,
                        height: size.height * 0.4,
                        width: size.width * 0.85,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          margin: const EdgeInsets.only(right: 4),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    Text(widget.item.rating.toString()),
                    Text(
                      "(${widget.item.review})",
                      style: const TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.favorite_border),
                  ],
                ),
                Text(
                  widget.item.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$${widget.item.price.toString()}.00",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.pink,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (widget.item.isCheck == true)
                      Text(
                        "\$${widget.item.price + 250}.00",
                        style: const TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black26,
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "Elevate your casual wardrobe with our ${widget.item.name}. Craft from premium cotton for maximum comfort, this relaxed-fit tee features.",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.shopping_bag,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "ADD TO CART",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: -1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  color: Colors.black,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "BUY NOW",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
