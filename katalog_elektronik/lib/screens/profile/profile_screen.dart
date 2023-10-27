import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katalog_elektronik/screens/profile/profile_detail.dart';
import 'package:katalog_elektronik/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final Function(String) onUsernameUpdated;

  const ProfileScreen({Key? key, required this.onUsernameUpdated}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences loginData;
  String username = '';
  final TextEditingController _newUsernameController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username') ?? '';
    });
  }

  Future<void> saveNewUsername(String newUsername) async {
    loginData.setString('username', newUsername);
    widget.onUsernameUpdated(newUsername);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Username updated successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Do you want to Logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                loginData.setBool('login', false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false,
                );
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: GoogleFonts.poppins(color: Colors.white),),
        backgroundColor: Colors.teal[300],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailScreen(username: username),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/tes.png'),
                ),
              ),
              const SizedBox(height: 16),
              if (_isEditing)
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _newUsernameController,
                          decoration: const InputDecoration(labelText: 'New Username'),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () async {
                                if (_newUsernameController.text.isNotEmpty) {
                                  await saveNewUsername(_newUsernameController.text);
                                  // username di layar setelah pembaruan
                                  setState(() {
                                    username = _newUsernameController.text;
                                  });
                                }
                              },
                              child: Text(
                                'Save',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  color: Colors.teal[300],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = false;
                                });
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      username,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                          _newUsernameController.clear();
                        });
                      },
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[300]),
                ),
                onPressed: () {
                  _showLogoutDialog(); // Memanggil dialog konfirmasi logout
                },
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
