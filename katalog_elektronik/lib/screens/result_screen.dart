import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katalog_elektronik/models/open_ai_model.dart';

class ResultScreen extends StatelessWidget {
  final GPTData gptResponseData;

  const ResultScreen({
    Key? key,
    required this.gptResponseData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Rekomendasi", style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Rekomendasi Electronic",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: gptResponseData.choices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(gptResponseData.choices[index].text), 
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
