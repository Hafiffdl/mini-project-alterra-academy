import 'package:flutter/material.dart';
import 'package:katalog_elektronik/models/product_model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  String username = '';
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
      price: 9400000.00,
    ),
    Product(
      name: 'Polytron 450 Ltr Kulkas',
      description: 'Lemari es persembahan Polytron ini dilengkapi Inverter Technology yang membuatnya memiliki kinerja maksimal dengan lebih hemat energi hingga 20%. Hadir dengan desain premium yang dilengkapi LCD Display untuk melakukan pengaturan suhu secara digital dengan penampilan layar LCD yang modern menjadikan lemari es ini mampu menciptakan kesan mewah pada dapur dan ruang makan Anda. Selain itu, lemari es Polytron PRS 480X juga sudah dilengkapi dispenser air dengan kapasitas dispenser air dingin hingga 2 liter. Tidak perlu khawatir akan suara bising yang mengganggu, dalam melakukan kinerjanya lemari es ini memiliki tingkat kebisingan Ultra Silent.',
      imageUrl: 'assets/kulkaspolytron.png',
      price: 9600000.00,
    ),
    Product(
      name: 'iPhone 14 Pro Max',
      description: 'iPhone 14 Pro Max. Memotret detail menakjubkan dengan kamera Utama 48 MP. Nikmati iPhone dalam cara yang sepenuhnya baru dengan layar yang Selalu Aktif dan Dynamic Island. Deteksi Tabrakan,1 sebuah fitur keselamatan baru, memanggil bantuan saat Anda tak bisa.',
      imageUrl: 'assets/iphone_14_promax.png',
      price: 19499000.00,
    ),
    Product(
      name: 'iPad Pro (Gen-6)',
      description: 'iPad Pro. Dengan performa yang menakjubkan, konektivitas nirkabel super cepat, dan pengalaman Apple Pencil generasi berikutnya. Ditambah, fitur produktivitas dan kolaborasi baru yang andal di iPadOS 16. iPad Pro adalah pengalaman iPad terbaik.',
      imageUrl: 'assets/ipad_pro.png',
      price: 14999000.00,
    ),
    Product(
      name: 'iPhone 15 Pro Max',
      description: 'LAHIR DARI TITANIUM — iPhone 15 Pro Max memiliki desain titanium sekelas industri dirgantara yang kuat dan ringan dengan bagian belakang kaca matte bertekstur. Dilengkapi juga dengan bagian depan Ceramic Shield yang lebih tangguh dibanding kaca ponsel pintar mana pun. Dan tahan cipratan, air, dan debu.',
      imageUrl: 'assets/iphone15_promax.png',
      price: 24999000.00,
    ),
    Product(
      name: 'Kels Dakota Air Cooler',
      description: 'Miliki kesejukan dan kesegaran udara di dalam ruangan dengan menggunakan Dakota air cooler persembahan Kels. Didesain dengan memiliki ukuran ideal sehingga alat ini dapat ditempatkan di berbagai ruangan seperti ruang tamu, ruang keluarga, ruang kerja, maupun kamar tidur dengan praktis. Air cooler ini menggunakan air sebagai media penyejuk dengan hembusan angin yang berasal dari kipas untuk membantu udara sejuk tersebar merata ke semua area ruangan',
      imageUrl: 'assets/kelsac.png',
      price: 400000.00,
    ),
    Product(
      name: 'MacBook Air M2 (2022)',
      description: 'Bertenaga super berkat chip M2 generasi berikutnya, MacBook Air yang didesain ulang menggabungkan performa andal dengan kekuatan baterai hingga 18 jam ke dalam penutup berbahan aluminium yang luar biasa tipis.',
      imageUrl: 'assets/macbook_air_m2.png',
      price: 18999000.00,
    ),
    Product(
      name: 'Sharp Air Conditioner 1.5 Pk',
      description: 'AC persembahan Sharp adalah pilihan yang tepat. AC ini memiliki teknologi Jetstream yang mampu mendinginkan udara di dalam ruangan dengan cepat dan optimal ke seluruh bagian.Hanya dengan satu tombol saja, Anda dapat langsung merasakan semburan udara dingin yang lebih menyegarkan. Hembusan udara yang lembut dan tidak langsung juga bisa Anda rasakan dengan mode Coanda gentle cool air. Mode ini mampu menghembuskan udara dingin ke arah atas melalui plafon atau langit-langit. Mode Coanda pada AC ini sangat cocok digunakan untuk kamar anak, orang lanjut usia, atau wanita hamil.',
      imageUrl: 'assets/sharpac.png',
      price: 5600000.00,
    ),
    Product(
      name: 'Panasonic Air Conditioner 1.5 Pk',
      description: 'Air Conditioner atau AC 1.5 pk CS/CU-XPU12XKJ persembahan Panasonic ini dilengkapi teknologi Inverter yang bekerja dengan cara menyesuaikan kecepatan rotasi kompresor, sehingga memberikan metode yang tepat untuk mempertahankan suhu yang diatur. Dengan teknologi inverter ini juga membuat AC menghasilkan lebih hemat energi karena hanya bekerja sesuai dengan beban yang ada di dalam ruangan saja. Selain itu, didukung ECO Mode yaitu pengaturan hemat konsumsi dalam 2 level yaitu 80 % dan 50% dari watt maksimum menjadikannya dapat membatasi watt AC Anda dan Anda tetap dapat menggunakan elektronik lainnya secara bersamaan.',
      imageUrl: 'assets/panasonicac.png',
      price: 6650000.00,
    ),
    Product(
      name: 'Apple Watch Trail Loop',
      description: 'Apple Watch paling tangguh dan andal yang pernah ada, dirancang untuk penjelajahan, petualangan, dan ketahanan. Dengan casing titanium 49 mm sekelas industri dirgantara, kekuatan baterai yang lebih lama,1 aplikasi khusus yang berfungsi dengan sensor canggih, dan tombol Tindakan baru yang dapat disesuaikan.',
      imageUrl: 'assets/applewatch.png',
      price: 13999000.00,
    ),
    Product(
      name: 'Apple Watch Series 8',
      description: 'Apple Watch Series 8 dilengkapi aplikasi dan sensor kesehatan canggih, sehingga Anda dapat melakukan pengukuran EKG,1 detak jantung, dan kadar oksigen darah,2 serta memantau perubahan suhu3 untuk informasi mendalam tentang siklus menstruasi Anda.4 Dan dengan Deteksi Tabrakan, pemantauan tahap tidur, serta metrik olahraga canggih, Apple Watch Series 8 membantu Anda tetap aktif, sehat, selamat, dan terhubung.',
      imageUrl: 'assets/applewatch8.png',
      price: 6999000.00,
    ),
  ];
  final List<Product> savedProducts = [];

  int currentIndex = 0;

  void usernameUpdate(String newUsername) {
  username = newUsername;
  }

  void setUsername(String newUsername) {
    username = newUsername;
    notifyListeners();
  }

  void addToSavedProducts(Product product) {
    savedProducts.add(product);
    notifyListeners();
  }

  void removeFromSavedProducts(Product product) {
    savedProducts.remove(product);
    notifyListeners();
  }

  void changePageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}