import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katalog_elektronik/routes/app_routes.dart';
import 'package:katalog_elektronik/screens/beranda/home_screen.dart';
import 'package:katalog_elektronik/screens/beranda/home_screen_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late SharedPreferences loginData;
  late bool newUser;

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = loginData.getBool("login") ?? true;

    if (newUser == false) {
      final savedUsername = loginData.getString('username');
      final savedPassword = loginData.getString('password');

      if (savedUsername != null && savedPassword != null) {
        _usernameController.text = savedUsername;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login successful"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/tes.png', height: 200, width: 200),
              const SizedBox(height: 70),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your Username",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a Username";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an Email";
                        }
                        final isEmailValid = EmailValidator.validate(value);
                        if (!isEmailValid) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a Password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[300],
                        minimumSize: const Size(double.infinity, 40),
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final username = _usernameController.text;
                          final passwordCurrent = _passwordController.text;

                          final savedUsername = loginData.getString('username');
                          final savedPassword = loginData.getString('password');

                          if (savedUsername == username) {
                            if (savedPassword == passwordCurrent) {
                              loginData.setBool('login', false);
                              showSuccessSnackBar(); // show success login
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(viewModel: HomeScreenViewModel()),
                                ),
                                (route) => false,
                              );
                            } else {
                              // password salah diinputkan
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid Password"),
                                ),
                              );
                            }
                          } else {
                            // username salah diinputkan
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid Username"),
                              ),
                            );
                          }
                        }
                      },
                      child: Text('Login',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onTapLogin(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.loginScreen);
}
