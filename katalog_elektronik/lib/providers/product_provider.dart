import 'package:flutter/material.dart';
import 'package:katalog_elektronik/models/product_model.dart'; 

class ProductProvider with ChangeNotifier {
  Product _product;

  ProductProvider(this._product);

  Product get product => _product;

  void updateProduct(Product newProduct) {
    _product = newProduct;
    notifyListeners();
  }
}
