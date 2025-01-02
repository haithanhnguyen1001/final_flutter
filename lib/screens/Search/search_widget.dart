import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/product_provider.dart';
import '../../Models/product_model.dart';
import '../../screens/Detail/items_detail_screen.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  String _selectedSort = 'Name (A to Z)'; // Default sort option

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                _searchProducts(query, productProvider);
              },
            ),
            const SizedBox(height: 20),

            // Sort dropdown
            DropdownButton<String>(
              value: _selectedSort,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSort = newValue!;
                });
                _sortProducts(_selectedSort);
              },
              items: <String>[
                'Name (A to Z)',
                'Name (Z to A)',
                'Price (Low to High)',
                'Price (High to Low)',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Display filtered products or loading indicator
            productProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _filteredProducts.isEmpty
                        ? const Center(child: Text("No products found"))
                        : ListView.builder(
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return ListTile(
                                leading: Image.network(product.thumbnail),
                                title: Text(product.title),
                                subtitle: Text('\$${product.price}'),
                                onTap: () {
                                  // Navigate to product detail screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ItemsDetailScreen(
                                        item: product,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  // Method to filter products based on search query
  void _searchProducts(String query, ProductProvider productProvider) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = productProvider.products;
      } else {
        _filteredProducts = productProvider.products
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });

    // Sort the filtered products after search
    _sortProducts(_selectedSort);
  }

  // Method to sort products based on selected option
  void _sortProducts(String sortOption) {
    setState(() {
      if (sortOption == 'Name (A to Z)') {
        _filteredProducts.sort((a, b) => a.title.compareTo(b.title));
      } else if (sortOption == 'Name (Z to A)') {
        _filteredProducts.sort((a, b) => b.title.compareTo(a.title));
      } else if (sortOption == 'Price (Low to High)') {
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'Price (High to Low)') {
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }
}
