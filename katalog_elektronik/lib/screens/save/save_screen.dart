import 'package:flutter/material.dart';
import 'package:katalog_elektronik/helper/database_helper.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class SaveScreen extends StatefulWidget {
  final List<Product> savedProducts;
  final Function(Product) onProductTapped;
  final Function(Product) onProductDeleted;

  const SaveScreen({
    Key? key,
    required this.savedProducts,
    required this.onProductTapped,
    required this.onProductDeleted,
  }) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    getAllProducts(); 
  }

  Future<void> getAllProducts() async {
    final products = await dbHelper.getProducts();
    setState(() {
      widget.savedProducts.clear();
      widget.savedProducts.addAll(products);
    });
  }

  void saveProduct(Product product) async {
    await dbHelper.insertProduct(product);
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Saved Products',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: widget.savedProducts.isNotEmpty
            ? ListView.builder(
                itemCount: widget.savedProducts.length,
                itemBuilder: (context, index) {
                  final product = widget.savedProducts[index];
                  return Card(
                    color: Colors.grey[300],
                    margin: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        widget.onProductTapped(product);
                      },
                      child: ListTile(
                        title: Text(product.name ?? ''),
                        leading: Image.asset(
                          product.imageUrl ?? '',
                          width: 70,
                          height: 70,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Price: IDR ${product.price?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            widget.onProductDeleted(product);
                            setState(() {
                              widget.savedProducts.remove(product);
                            });
                            if (product.id != null) {
                              await dbHelper.deleteProduct(product.id!);
                              getAllProducts(); 
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Text('No saved products yet.'),
      ),
    );
  }
}
