import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// ============================================================
// TITIK MASUK (ENTRY POINT) APLIKASI
// ------------------------------------------------------------
// Fungsi main() adalah fungsi pertama yang dijalankan.
// runApp() memasang widget utama (MyApp) ke layar perangkat.
// ============================================================
void main() {
  runApp(const MyApp());
}

// MyApp adalah widget akar (root) dari seluruh aplikasi.
// StatelessWidget dipakai karena widget ini sendiri tidak
// punya data yang berubah-ubah.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List Sederhana',

      // Menyembunyikan label "DEBUG" di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // Tema warna aplikasi menggunakan Material 3.
      // ColorScheme.fromSeed otomatis membuat palet warna
      // yang serasi hanya dari satu warna dasar (seedColor).
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),

      // Halaman pertama yang ditampilkan saat aplikasi dibuka
      home: const HomeScreen(),
    );
  }
}
