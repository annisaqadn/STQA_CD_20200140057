import 'package:firebase_core/firebase_core.dart';

/// Mengimpor paket Firebase Core untuk menginisialisasi Firebase
import 'package:flutter/material.dart';

/// Mengimpor paket Flutter untuk membangun aplikasi Flutter
import 'package:redlenshoescleaning/view/splashscreen.dart';

/// Mengimpor SplashScreen dari direktori 'redlenshoescleaning/view'

/// Fungsi main() adalah titik masuk utama aplikasi Flutter
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Pastikan menginisialisasi Flutter Binding
  await Firebase.initializeApp();

  /// Menginisialisasi Firebase
  runApp(const MyApp());

  /// Mulai menjalankan aplikasi dengan widget MyApp
}

/// Kelas MyApp adalah widget utama yang membangun user interface aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      /// Judul aplikasi
      debugShowCheckedModeBanner: false,

      /// Menyembunyikan banner "Debug" saat mode debug
      theme: ThemeData(
        /// Mendefinisikan tema aplikasi
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD9D9D9),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
