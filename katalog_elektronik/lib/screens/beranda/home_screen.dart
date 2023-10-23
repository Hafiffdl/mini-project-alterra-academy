// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:katalog_elektronik/helper/database_helper.dart';
import 'package:katalog_elektronik/models/product_model.dart';
import 'package:katalog_elektronik/providers/save_provider.dart';
import 'package:katalog_elektronik/screens/beranda/home_screen_viewmodel.dart';
import 'package:katalog_elektronik/screens/news/news_screen.dart';
import 'package:katalog_elektronik/screens/product_detail.dart';
import 'package:katalog_elektronik/screens/profile/profile_screen.dart';
import 'package:katalog_elektronik/screens/save/save_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  const HomeScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences loginData;
  int _currentIndex = 0;
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    getUsernameFromSharedPreferences();
  }

  void getUsernameFromSharedPreferences() async {
    loginData = await SharedPreferences.getInstance();
    final savedUsername = loginData.getString('username');
    if (savedUsername != null) {
      setState(() {
        widget.viewModel.setUsername(savedUsername);
      });
    }
  }

  void navigateToProductDetail(int index) {
    if (index >= 0 && index < widget.viewModel.products.length) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            product: widget.viewModel.products[index],
            onSave: (Product product) {
              widget.viewModel.addToSavedProducts(product);
            },
          ),
        ),
      );
    } else {
      print('Invalid index: $index');
    }
  }

  void navigateFavorite(Product product) {
    final savedProducts = Provider.of<SavedProducts>(context, listen: false);
    if (savedProducts.savedProducts.contains(product)) {
      savedProducts.removeFromSavedProducts(product);
    } else {
      savedProducts.addToSavedProducts(product);
      dbHelper.insertProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedProducts = Provider.of<SavedProducts>(context, listen: false);
    final viewModel = widget.viewModel;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  'Welcome, ${viewModel.username}!',
                  style: GoogleFonts.poppins(
                    color: Colors.teal,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (viewModel.products.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            shadowColor: Colors.teal,
                            color: Colors.grey[300]!,
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              right: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                navigateToProductDetail(startIndex);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    viewModel.products[startIndex].imageUrl ?? '',
                                    fit: BoxFit.fitWidth,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      viewModel.products[startIndex].name ?? '',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'IDR',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${viewModel.products[startIndex].price?.toStringAsFixed(2)}',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          navigateFavorite(viewModel.products[startIndex]);
                                          setState(() {
                                            
                                          });
                                        },
                                        child: Icon(
                                          Icons.bookmark,
                                          color: savedProducts.savedProducts.contains(viewModel.products[startIndex])
                                              ? Colors.black
                                              : Colors.grey,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (startIndex + 1 < viewModel.products.length)
                          Expanded(
                            child: Card(
                              shadowColor: Colors.teal,
                              color: Colors.grey[300]!,
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 10,
                                right: 20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  navigateToProductDetail(startIndex + 1);
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      viewModel.products[startIndex + 1].imageUrl.toString(),
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        viewModel.products[startIndex + 1].name.toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'IDR',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '${viewModel.products[startIndex + 1].price?.toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            navigateFavorite(viewModel.products[startIndex + 1]);
                                            setState(() {
                                            });
                                          },
                                          child: Icon(
                                            Icons.bookmark,
                                            color: savedProducts.savedProducts.contains(viewModel.products[startIndex + 1])
                                                ? Colors.black
                                                : Colors.grey,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // Page 2 (News)
          const NewsScreen(),
          // Page 3 (Save)
          SaveScreen(
            savedProducts: savedProducts.savedProducts,
            dbHelper: dbHelper,
            onProductDeleted: (product) {
            },
          ),
          // Page 4 (Profile)
          ProfileScreen(onUsernameUpdated: widget.viewModel.usernameUpdate),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeOut,
        backgroundColor: Colors.white,
        color: Colors.teal,
        index: _currentIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.newspaper, size: 30, color: Colors.white),
          Icon(Icons.bookmark, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
