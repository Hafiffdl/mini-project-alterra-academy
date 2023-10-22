import 'package:flutter/material.dart';
import 'package:katalog_elektronik/helper/database_helper.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class DBManager with ChangeNotifier {
  List<Product> products = [];
  late DatabaseHelper _databaseHelper;

  List<Product> get product => products;

  DBManager() {
    _databaseHelper = DatabaseHelper();
    getAllProducts();
  }

  void getAllProducts() async {
    products = await _databaseHelper.getProducts();
    notifyListeners();
  }

  void addProductToDB(Product product) async {
    await _databaseHelper.insertProduct(product);
    getAllProducts();
  }

  void updateProductInDB(Product product) async {
    await _databaseHelper.updateProduct(product);
    getAllProducts();
  }

  void deleteProductFromDB(int id) async {
    await _databaseHelper.deleteProduct(id);
    getAllProducts();
  }

  Future<Product> getProductById(int id) async {
    return await _databaseHelper.getProductById(id);
  }
}
