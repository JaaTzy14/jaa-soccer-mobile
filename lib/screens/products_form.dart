import 'package:flutter/material.dart';
import 'package:jaa_soccer/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _category = "jersey"; // default
  int _stock = 0;
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  bool _isFeatured = false; // default

  final Map<String, String> _categories = {
    'jersey': 'Jersey',
    'boots': 'Football Boots',
    'ball': 'Football',
    'accessories': 'Accessories',
    'training': 'Training Equipment',
    'merchandise': 'Merchandise',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Kick Off a New Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              // === Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter product name",
                    labelText: "Name",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Product name can't be empty!";
                    }
                    if (value.length > 255) {
                      return "Name too long (max 255 characters)";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                  ),
                  initialValue: _category,
                  items: _categories.entries
                      .map((cat) => DropdownMenuItem<String>(
                            value: cat.key,
                            child: Text(
                                cat.value),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Stock ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter product stock",
                    labelText: "Stock",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _stock = int.tryParse(value ?? '') ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Stock can't be empty!";
                    }
                    final intValue = int.tryParse(value);
                    if (intValue == null) {
                      return "Stock must be a number!";
                    }
                    if (intValue < 0) {
                      return "Stock can't be negative!";
                    }
                    return null;
                  },
                ),
              ),

              // === Price ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter product price",
                    labelText: "Price",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.tryParse(value ?? '') ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Price can't be empty!";
                    }
                    final intValue = int.tryParse(value);
                    if (intValue == null) {
                      return "Price must be a number!";
                    }
                    if (intValue < 0) {
                      return "Price can't be negative!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter product description",
                    labelText: "Description",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Product description can't be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://example.com/image.jpg",
                    labelText: "Thumbnail URL",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Thumbnail URL can't be empty!";
                    }
                    final urlPattern = RegExp(r'^(http|https):\/\/[^\s$.?#].[^\s]*$');
                    if (!urlPattern.hasMatch(value)) {
                      return "Enter a valid URL!";
                    }
                    return null;
                  },
                ),
              ),

              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Featured Product"),
                  value: _isFeatured,
                  activeThumbColor: Theme.of(context).colorScheme.primary,
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  inactiveThumbColor: Colors.grey.shade300,
                  inactiveTrackColor: Colors.grey.shade400,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary
                      )
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Product added succesfully!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $_name'),
                                    Text('Category: ${_categories[_category]}'),
                                    Text('Stock: $_stock'),
                                    Text('Price: $_price'),
                                    Text('Description: $_description'),
                                    Text('Thumbnail URL: $_thumbnail'),
                                    Text('Featured: ${_isFeatured ? "Yes" : "No"}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                        setState(() { 
                          _name = ''; 
                          _price = 0; 
                          _stock = 0; 
                          _description = ''; 
                          _thumbnail = ''; 
                          _isFeatured = false; 
                          _category = 'jersey';
                        });
                      }
                    },
                    child: const Text(
                      "Launch Product",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ),
            ]
          )
        ),
      ),
    );
  }
}