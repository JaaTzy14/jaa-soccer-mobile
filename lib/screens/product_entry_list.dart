import 'package:flutter/material.dart';
import 'package:jaa_soccer/models/product_entry.dart';
import 'package:jaa_soccer/screens/product_detail.dart';
import 'package:jaa_soccer/widgets/left_drawer.dart';
// import 'package:jaa_soccer/screens/product_detail.dart';
import 'package:jaa_soccer/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key, required this.filterType});
  final String filterType;
  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  String filter = "all";

  @override
  void initState() {
    super.initState();
    filter = widget.filterType;
  }
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('https://mirza-radithya-jaasoccer.pbp.cs.ui.ac.id/json/');
    
    // Decode response to json format
    var data = response;
    
    // Convert json data to ProductEntry objects
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).colorScheme.secondary;
    final Color inactiveColor = Colors.white;
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Entry List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => filter = "all");
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (filter == "all") return activeColor;
                      return inactiveColor;
                    }),
                  ),
                  child: Text(
                    "All Products",
                    style: TextStyle(
                      color: filter == "all" ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() => filter = "mine");
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (filter == "mine") return activeColor;
                      return inactiveColor;
                    }),
                  ),
                  child: Text(
                    "My Products",
                    style: TextStyle(
                      color: filter == "mine" ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<ProductEntry> allProducts = snapshot.data!;
                  List<ProductEntry> displayedProducts = [];
                  if (filter == "all") {
                    displayedProducts = allProducts;
                  } else if (filter == "mine") {
                    displayedProducts = allProducts
                        .where((p) => p.userUsername == request.jsonData['username'])
                        .toList();
                  }
                  if (displayedProducts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.inbox,
                            size: 70,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No products available.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: displayedProducts.length,
                      itemBuilder: (_, index) => ProductEntryCard(
                        product: displayedProducts[index],
                        onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                product: displayedProducts[index],
                              )
                            ),
                         );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );

  }
}