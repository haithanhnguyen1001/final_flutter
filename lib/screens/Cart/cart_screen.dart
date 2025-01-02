import 'package:final_ecommerce/Provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utils/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;

    // Tính tổng giá trị giỏ hàng
    double totalPrice = cartProvider.cartItems.fold(0.0, (total, item) {
      return total + item.price;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: fbackgroundColor2,
        centerTitle: true,
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
              child: Text("Your cart is empty!"),
            )
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Image.network(
                          product.thumbnail,
                          width: size.width * 0.3,
                          height: size.height * 0.15,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${product.price.toStringAsFixed(2)}", // Hiển thị giá với 2 chữ số thập phân
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cartProvider.removeFromCart(product);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartProvider.cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // Thực hiện thanh toán hoặc tiếp tục mua sắm
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  "Checkout - \$${totalPrice.toStringAsFixed(2)}", // Hiển thị tổng giá giỏ hàng với 2 chữ số thập phân
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
    );
  }
}
