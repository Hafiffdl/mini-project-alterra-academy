import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:katalog_elektronik/helper/database_helper.dart';
import 'package:katalog_elektronik/models/product_model.dart';
import 'package:katalog_elektronik/screens/product_detail.dart';

class SaveScreen extends StatefulWidget {
  final List<Product> savedProducts;
  final Function(Product) onProductDeleted;
  final DatabaseHelper dbHelper;

  const SaveScreen({
    Key? key,
    required this.savedProducts,
    required this.onProductDeleted,
    required this.dbHelper,
  }) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late DatabaseHelper dbHelper;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    fToast = FToast();
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

  void _showToast(String message) {
    fToast.init(context);
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.teal,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
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
                    color: Colors.white,
                    margin: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                              onSave: saveProduct,
                            ),
                          ),
                        );
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete Product"),
                                  content: const Text("Are you sure you want to delete this product?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        widget.onProductDeleted(product);
                                        setState(() {
                                          widget.savedProducts.remove(product);
                                        });
                                        if (product.id != null) {
                                          await dbHelper.deleteProduct(product.id!);
                                          getAllProducts();
                                          _showToast("Product deleted");
                                        }
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
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
