import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  

  const ProductDetailScreen({super.key, 
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                product.imageUrl ?? toString(),
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  product.name ?? toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  product.description ?? toString(),
                  style: GoogleFonts.poppins(),
                ),
              ),
              // Tambahkan komponen lainnya yang diperlukan
            ],
          ),
        ),
      ),
    );
  }
}