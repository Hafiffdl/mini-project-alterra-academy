import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katalog_elektronik/auth/login_screen.dart';
import 'package:katalog_elektronik/auth/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ElectroHub',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'The Electronic Catalog App',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Image.asset('assets/logo1.png', height: 200, width: 500),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  onTapLogin(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                  padding: const EdgeInsets.all(15),
                ),
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18, color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  onTapSignUp(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                  padding: const EdgeInsets.all(15),
                ),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18, color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),      
    );
  }
  void onTapLogin(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}

  void onTapSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }
}
