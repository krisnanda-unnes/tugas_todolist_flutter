// ============================================================
// MODEL: Task
// ------------------------------------------------------------
// Kelas sederhana yang merepresentasikan satu item tugas.
// Memisahkan "data" (model) dari "tampilan" (UI) adalah praktik
// yang baik dalam pengembangan aplikasi, agar kode lebih mudah
// dibaca, diuji, dan dikembangkan lebih lanjut.
// ============================================================
class Task {
  /// Judul atau isi dari tugas, contoh: "Belajar Flutter"
  String title;

  /// Status tugas: true jika sudah selesai, false jika belum
  bool isDone;

  Task({
    required this.title,
    this.isDone = false, // nilai default saat tugas baru dibuat
  });
}
