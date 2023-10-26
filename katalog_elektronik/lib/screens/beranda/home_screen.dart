// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:katalog_elektronik/helper/database_helper.dart';
import 'package:katalog_elektronik/models/product_model.dart';
import 'package:katalog_elektronik/providers/save_provider.dart';
import 'package:katalog_elektronik/screens/ai_screen.dart';
import 'package:katalog_elektronik/screens/beranda/home_screen_viewmodel.dart';
import 'package:katalog_elektronik/screens/news/news_screen.dart';
import 'package:katalog_elektronik/screens/product_detail.dart';
import 'package:katalog_elektronik/screens/profile/profile_screen.dart';
import 'package:katalog_elektronik/screens/save/save_screen.dart';
import 'package:katalog_elektronik/screens/slider_detail.dart';
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bookmark Product"),
          content: const Text("Do you want to bookmark this product?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (savedProducts.savedProducts.contains(product)) {
                  savedProducts.removeFromSavedProducts(product);
                  dbHelper.deleteProduct(product.id!);
                } else {
                  savedProducts.addToSavedProducts(product);
                  dbHelper.insertProduct(product);
                }
                setState(() {});

                FToast().init(context);
                FToast().showToast(
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
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          savedProducts.savedProducts.contains(product) ? "Bookmarked" : "",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  gravity: ToastGravity.TOP, // Toast position
                  toastDuration: const Duration(seconds: 2), // Toast display duration
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final savedProducts = Provider.of<SavedProducts>(context, listen: false);
    final viewModel = widget.viewModel;
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  'Welcome!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                items: [
                  SingleChildScrollView(
                    child: Container(
                    margin: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => const SliderImageDetail(
                              imageUrl: 'assets/slider1.png')
                            )
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/slider1.png', 
                                fit: BoxFit.cover, 
                                height: 170, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => const SliderImageDetail(
                              imageUrl: 'assets/slider2.png')
                            )
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/slider2.png',
                                fit: BoxFit.cover, 
                                height: 170, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => const SliderImageDetail(
                              imageUrl: 'assets/slider3.png')
                            )
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/slider3.png',
                                fit: BoxFit.cover, 
                                height: 170, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.easeInOut,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
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
                            color: Colors.white,
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
                                          setState(() {});
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
                              color: Colors.white,
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
                                      viewModel.products[startIndex + 1].imageUrl ?? '',
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        viewModel.products[startIndex + 1].name ?? '',
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
                                            setState(() {});
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
              // Handle product deletion here if needed
            },
          ),
          // Page 4 (Profile)
          ProfileScreen(onUsernameUpdated: widget.viewModel.usernameUpdate),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.teal[300],
        height: 60,
        animationCurve: Curves.easeOut,
        backgroundColor: Colors.white,
        color: Colors.teal[300]!,
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
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AiScreen()),
          );
        },
        child: const Icon(Icons.recommend_rounded, color: Colors.teal),
      ),
    );
  }
}
