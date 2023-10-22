
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:katalog_elektronik/helper/database_helper.dart';
import 'package:katalog_elektronik/models/product_model.dart';
import 'package:katalog_elektronik/providers/save_provider.dart';
import 'package:katalog_elektronik/screens/news/news_screen.dart';
import 'package:katalog_elektronik/screens/product_detail.dart';
import 'package:katalog_elektronik/screens/profile/profile_screen.dart';
import 'package:katalog_elektronik/screens/save/save_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late SharedPreferences loginData;
    final List<Product> products = [
    Product(
      name: 'Sharp 32 Inci Led Tv',
      description: 'TV dengan kualitas gambar yang tajam dengan warna yang cerah tidak hanya membuat nyaman di mata tetapi juga dapat memberikan pengalaman menonton yang lebih seru dan menyenangkan. Dengan TV LED persembahan Sharp, Anda akan memasuki dunia baru yang lebih berwarna. Hadir dengan berbagai teknologi serta fitur unggulan seperti, DVB-T2, Desain speaker menara IIOTO, dan Penguat antena. TV ini memiliki desain slim yang stylish serta mudah dipasangkan pada dinding.',
      imageUrl: 'assets/tvsharp.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Samsung 43 Inci Qled',
      description: 'Dengan fitur 100% Color Volume with Quantum Dot yang dapat mengambil cahaya dan mengubahnya menjadi warna menakjubkan menjadikan Samsung QLED 4K Smart TV 43 inci QA43Q60BAKXXD ini mampu memberikan tontonan yang terasa nyata pada tingkat kecerahan apa pun. Dilengkapi Quantum HDR membuat Smart TV ini juga mampu menghadirkan detail dan kontras untuk dapat merasakan kekuatan penuh di setiap gambar. Selain itu, didukung prosesor Quantum Processor Lite 4K untuk mengoptimalkan kualitas suara konten yang Anda tonton. Teknologi 4K Upscaling juga memastikan Anda mendapatkan resolusi hingga 4K untuk konten yang Anda sukai.',
      imageUrl: 'assets/tvsamsung.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Polytron 450 Ltr Kulkas',
      description: 'Lemari es persembahan Polytron ini dilengkapi Inverter Technology yang membuatnya memiliki kinerja maksimal dengan lebih hemat energi hingga 20%. Hadir dengan desain premium yang dilengkapi LCD Display untuk melakukan pengaturan suhu secara digital dengan penampilan layar LCD yang modern menjadikan lemari es ini mampu menciptakan kesan mewah pada dapur dan ruang makan Anda. Selain itu, lemari es Polytron PRS 480X juga sudah dilengkapi dispenser air dengan kapasitas dispenser air dingin hingga 2 liter. Tidak perlu khawatir akan suara bising yang mengganggu, dalam melakukan kinerjanya lemari es ini memiliki tingkat kebisingan Ultra Silent.',
      imageUrl: 'assets/kulkaspolytron.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Lg 635 Ltr Kulkas',
      description: 'Hadir dengan teknologi canggih InstaViewThinQ™ membuat lemari es GC-X257CQES persembahan LG ini memiliki fitur dan tampilan yang begitu modern, karena hanya dengan mengetuk dua kali dan Anda dapat melihat isi kulkas 23% lebih leluasa. Didukung dengan LinearCooling™ yang mampu mengurangi fluktuasi suhu sehingga lemari es ini dapat mempertahankan kesegaran bahan makanan hingga 7 hari. Selain itu, lemari es ini pun memiliki kapasitas besar menjadikan Anda dapat menikmati banyak ruang untuk menyimpan bahan makanan dan minuman dengan lebih maksimal.',
      imageUrl: 'assets/kulkaslg.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Philips 2 Ltr Blender',
      description: 'Blender persembahan Philips ini mampu melumatkan 40% lebih halus dan menghancurkan es dengan sempurna berkat teknologi ProBlend Crush yang dimilikinya. Teknologi ini membantu Anda untuk menghasilkan jus dan smoothie favorit yang lebih segar dengan cepat. Lewat satu tombol, Anda juga dapat menghancurkan es dengan sempurna dan melumat es keras dua kali lebih cepat. Memiliki 5 pengaturan prasetel yang mudah digunakan untuk menghasilkan berbagai tekstur dari smoothie, jus, sup, hingga saus',
      imageUrl: 'assets/blenderphillips.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Kels Set 6 Pcs Nada',
      description: 'Set Mini Blender dari Kels praktis untuk membuat jus, smoothie, hingga menghaluskan bumbu dapur dan makanan bayi. Set ini terdiri dari wadah mangkuk, gelas tinggi, gelas rendah, gelas lebar dan wadah pelumat yang bisa digunakan sesuai kebutuhan di atas mesin utama.',
      imageUrl: 'assets/blenderkels.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Kels Dakota Air Cooler Portable',
      description: 'Miliki kesejukan dan kesegaran udara di dalam ruangan dengan menggunakan Dakota air cooler persembahan Kels. Didesain dengan memiliki ukuran ideal sehingga alat ini dapat ditempatkan di berbagai ruangan seperti ruang tamu, ruang keluarga, ruang kerja, maupun kamar tidur dengan praktis. Air cooler ini menggunakan air sebagai media penyejuk dengan hembusan angin yang berasal dari kipas untuk membantu udara sejuk tersebar merata ke semua area ruangan',
      imageUrl: 'assets/kelsac.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Sharp 30 M2 Air Purifier Cadr',
      description: 'Hadirkan lingkungan tempat tinggal yang sehat dengan udara yang bersih menggunakan alat penjernih udara dari Sharp. Air purifier ini hadir dengan desain minimalis sehingga mudah diletakan di mana saja pada ruangan Anda. Penjernih udara ini tidak hanya membersihkan udara dari kotoran, debu, dan partikel asing lainnya tetapi juga dilengkapi filter untuk menetralkan bau. Sangat ideal digunakan pada ruangan berukuran 30 m².',
      imageUrl: 'assets/sharpairpurifier.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Sharp Air Conditioner 1.5 Pk',
      description: 'AC persembahan Sharp adalah pilihan yang tepat. AC ini memiliki teknologi Jetstream yang mampu mendinginkan udara di dalam ruangan dengan cepat dan optimal ke seluruh bagian.Hanya dengan satu tombol saja, Anda dapat langsung merasakan semburan udara dingin yang lebih menyegarkan. Hembusan udara yang lembut dan tidak langsung juga bisa Anda rasakan dengan mode Coanda gentle cool air. Mode ini mampu menghembuskan udara dingin ke arah atas melalui plafon atau langit-langit. Mode Coanda pada AC ini sangat cocok digunakan untuk kamar anak, orang lanjut usia, atau wanita hamil.',
      imageUrl: 'assets/sharpac.png',
      price: 2300000.00,
    ),
    Product(
      name: 'Panasonic Air Conditioner 1.5 Pk',
      description: 'Air Conditioner atau AC 1.5 pk CS/CU-XPU12XKJ persembahan Panasonic ini dilengkapi teknologi Inverter yang bekerja dengan cara menyesuaikan kecepatan rotasi kompresor, sehingga memberikan metode yang tepat untuk mempertahankan suhu yang diatur. Dengan teknologi inverter ini juga membuat AC menghasilkan lebih hemat energi karena hanya bekerja sesuai dengan beban yang ada di dalam ruangan saja. Selain itu, didukung ECO Mode yaitu pengaturan hemat konsumsi dalam 2 level yaitu 80 % dan 50% dari watt maksimum menjadikannya dapat membatasi watt AC Anda dan Anda tetap dapat menggunakan elektronik lainnya secara bersamaan.',
      imageUrl: 'assets/panasonicac.png',
      price: 2300000.00,
    ),
  ];

  String username = '';

  int _currentIndex = 0;
  List<Product> savedProducts = [];

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    getUsernameFromSharedPreferences();
  }

  void getUsernameFromSharedPreferences() async {
    loginData = await SharedPreferences.getInstance();
    final savedUsername = loginData.getString('username');
    if (savedUsername != null) {
      setState(() {
        username = savedUsername;
      });
    }
  }

  void updateUsername(String newUsername) {
    setState(() {
      username = newUsername;
    });
  }

  void navigateToProductDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: products[index],
        ),
      ),
    );
  }

void navigateFavorite(Product product) {
    final savedProducts = Provider.of<SavedProducts>(context, listen: false);
    if (savedProducts.savedProducts.contains(product)) {
      savedProducts.removeFromSavedProducts(product);
    } else {
      savedProducts.addToSavedProducts(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedProducts = Provider.of<SavedProducts>(context, listen: false);
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
                  'Welcome, $username!',
                  style: GoogleFonts.poppins(
                    color: Colors.teal,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: (products.length / 2).ceil(),
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
                                    products[startIndex].imageUrl ?? '',
                                    fit: BoxFit.fitWidth,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      products[startIndex].name ?? '',
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
                                              '${products[startIndex].price?.toStringAsFixed(2)}',
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
                                          navigateFavorite(products[startIndex]);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: savedProducts.savedProducts.contains(products[startIndex])
                                              ? Colors.red
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
                        if (startIndex + 1 < products.length)
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
                                      products[startIndex + 1].imageUrl.toString(),
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        products[startIndex + 1].name.toString(),
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
                                                '${products[startIndex + 1].price?.toStringAsFixed(2)}',
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
                                            navigateFavorite(products[startIndex + 1]);
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: savedProducts.savedProducts.contains(products[startIndex + 1])
                                                ? Colors.red
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
            onProductDeleted: (product) {
            },
            onProductTapped: (product) {
              navigateToProductDetail(products.indexOf(product));
            },
          ),
          // Page 4 (Profile)
          ProfileScreen(onUsernameUpdated: updateUsername),
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
          Icon(Icons.favorite, size: 30, color: Colors.white),
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