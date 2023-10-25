// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katalog_elektronik/screens/result_screen.dart';
import 'package:katalog_elektronik/services/recommendation_service.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _electronicController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  
  bool isLoading = false;

  void _getRecommendations() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await RecommendationService.getRecommendation(
        budget: _budgetController.text,
        electronic: _electronicController.text,
        brand: _brandController.text,

      );

      _budgetController.clear();
      _electronicController.clear();
      _brandController.clear(); 

if (mounted) {
  setState(() {
    isLoading = false;
  });
}

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            gptResponseData: result,
          ),
        ),
      );
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Gagal mendapatkan rekomendasi'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Electronic Recommendation", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Pilih Recommendation"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Electronic Budget",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input Electronic Budget';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _electronicController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Product Electronic",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input Product Electronic';
                      }
                      return null;
                    },
                  ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _brandController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Brand Product Electronic",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Input brand Electronic';
                      }
                      return null;
                    },
                  ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading &&
                  _formKey.currentState!.validate() != false
                      ? const Center(
                        child: CircularProgressIndicator()
                        )
                      : ElevatedButton(
                        onPressed: _getRecommendations,
                          child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Dapatkan Rekomendasi"),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}