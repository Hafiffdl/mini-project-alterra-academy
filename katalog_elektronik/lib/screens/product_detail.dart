import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:katalog_elektronik/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:katalog_elektronik/providers/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Function(Product) onSave;

  const ProductDetailScreen({
    Key? key,
    required this.product,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late QrImage qrImage;

  @override
  void initState() {
    super.initState();
    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData(widget.product.name ?? '');

    qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider(widget.product), // Menginisialisasi ProductProvider dengan produk yang diterima
      child: Scaffold(
        backgroundColor: Colors.teal[300],
        appBar: AppBar(
          backgroundColor: Colors.teal[300],
          centerTitle: true,
          title: Text(
            widget.product.name ?? 'Product Detail',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                widget.product.imageUrl ?? '',
                height: 200,
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.product.name ?? 'Product Name',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Price: IDR ${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.product.description ?? 'Product description goes here.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<ProductProvider>(
                builder: (context, productProvider, _) {
                  final qrCode = QrCode(
                    8,
                    QrErrorCorrectLevel.H,
                  )..addData(productProvider.product.name ?? '');
                  final updatedQrImage = QrImage(qrCode);
                  return Card(
                    margin: const EdgeInsets.all(90),
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: PrettyQrView(
                      qrImage: updatedQrImage,
                      decoration: const PrettyQrDecoration(
                        image: PrettyQrDecorationImage(
                          image: AssetImage('assets/splashscreen.png'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
