import 'package:flutter/material.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class SavedProducts with ChangeNotifier {
  final List<Product> _savedProducts = [];

  List<Product> get savedProducts => _savedProducts;

  void addToSavedProducts(Product product) {
    _savedProducts.add(product);
    notifyListeners();
  }

  void removeFromSavedProducts(Product product) {
    _savedProducts.remove(product);
    notifyListeners();
  }
}
