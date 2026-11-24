# To-Do List Sederhana (Flutter)

Aplikasi tugas kuliah: daftar tugas (to-do list) sederhana dengan 2 halaman
(Home & Statistik), dibuat dengan Dart + Flutter.

## Cara menjalankan

1. Pastikan Flutter SDK sudah terpasang (`flutter doctor`).
2. Install dependency:
   ```
   flutter pub get
   ```
3. Jalankan di perangkat/emulator Android:
   ```
   flutter run
   ```
   atau paling cepat untuk mengambil screenshot, jalankan di Chrome:
   ```
   flutter run -d chrome
   ```

## Struktur kode

```
lib/
 ├─ main.dart                 # entry point + tema aplikasi
 ├─ models/task.dart          # model data satu tugas
 └─ screens/
     ├─ home_screen.dart      # halaman utama: tambah/centang/hapus tugas
     └─ statistik_screen.dart # halaman kedua: ringkasan statistik tugas
```

## Fitur

- Tambah tugas baru lewat kolom input
- Tandai tugas selesai (checkbox, teks jadi dicoret)
- Hapus tugas
- Halaman Statistik: total, selesai, belum selesai, progress bar persen
