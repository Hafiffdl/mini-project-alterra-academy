import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderImageDetail extends StatelessWidget {
  final String imageUrl;

  const SliderImageDetail({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[300],
        title: Text('Detail Image',
        style: GoogleFonts.poppins(
          color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
