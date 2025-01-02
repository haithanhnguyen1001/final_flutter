// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Product {
  final String name, image, description, category;
  final double rating;
  final int review, price;
  List<Color> fcolor;
  List<String> size;
  bool isCheck;

  Product({
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.rating,
    required this.review,
    required this.fcolor,
    required this.size,
    required this.price,
    required this.isCheck,
  });
}

List<Product> productList = [
  Product(
    name: "Oversized Fit Printed Mest T-shirt",
    image: "assets/image23.jpg",
    description: "",
    category: "Women",
    rating: 4.9,
    review: 136,
    fcolor: [
      Colors.black,
      Colors.blue,
      Colors.green,
    ],
    size: ["XS", "S", "M"],
    price: 295,
    isCheck: true,
  ),
  Product(
    name: "Oversized Fit Printed Mest T-shirt",
    image: "assets/image23.jpg",
    description: "",
    category: "Women",
    rating: 4.9,
    review: 136,
    fcolor: [
      Colors.black,
      Colors.blue,
      Colors.green,
    ],
    size: ["XS", "S", "M"],
    price: 295,
    isCheck: true,
  ),
  Product(
    name: "Oversized Fit Printed Mest T-shirt",
    image: "assets/image23.jpg",
    description: "",
    category: "Men",
    rating: 4.9,
    review: 136,
    fcolor: [
      Colors.black,
      Colors.blue,
      Colors.green,
    ],
    size: ["XS", "S", "M"],
    price: 295,
    isCheck: true,
  ),
];
