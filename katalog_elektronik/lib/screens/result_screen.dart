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
        title: Text("Recommendation", style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: SingleChildScrollView(
        child: Padding( 
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Electronic Recommendation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset('assets/aiscreen.png'),
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
