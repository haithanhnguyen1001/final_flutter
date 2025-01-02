import 'package:final_ecommerce/Models/product_model.dart';
import 'package:final_ecommerce/Utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../Provider/favourite_provider.dart';

class CuratedItems extends StatelessWidget {
  final Product productItems;
  final Size size;
  const CuratedItems(
      {super.key, required this.productItems, required this.size});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: productItems.thumbnail,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: fbackgroundColor2,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productItems.thumbnail),
              ),
            ),
            height: size.height * 0.25,
            width: size.width * 0.5,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black26,
                  child: GestureDetector(
                    onTap: () {
                      provider.toggleFavorite(productItems);
                    },
                    child: Icon(
                      provider.isExist(productItems)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
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
            Text(productItems.rating.toString()),
          ],
        ),
        SizedBox(
          width: size.width * 0.5,
          child: Text(
            productItems.title,
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
              "\$${productItems.price.toString()}.00",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.pink,
                height: 1.5,
              ),
            ),
            const SizedBox(width: 5),
            if (productItems.discountPercentage > 0)
              Text(
                "\$${(productItems.price * (1 + productItems.discountPercentage)).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black26,
                ),
              )
          ],
        )
      ],
    );
  }
}
