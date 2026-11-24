import 'package:flutter/material.dart';
import '../models/task.dart';
import 'statistik_screen.dart';

// ============================================================
// SCREEN 1: HomeScreen
// ------------------------------------------------------------
// Halaman utama aplikasi To-Do List.
// Menggunakan StatefulWidget karena halaman ini memiliki data
// (daftar tugas) yang bisa berubah-ubah seiring interaksi user:
// menambah tugas, menandai selesai, dan menghapus tugas.
// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller untuk membaca teks yang diketik user di TextField
  final TextEditingController _controller = TextEditingController();

  // "Database" sementara di memori (akan hilang saat app ditutup).
  // Untuk tugas sederhana ini cukup, tidak perlu database sungguhan.
  final List<Task> _tasks = [];

  // --------------------------------------------------------
  // FUNGSI: Menambah tugas baru ke dalam list
  // --------------------------------------------------------
  void _tambahTugas() {
    final String teks = _controller.text.trim();

    // Validasi sederhana: jangan tambahkan tugas kosong
    if (teks.isEmpty) return;

    setState(() {
      // setState() memberi tahu Flutter bahwa data berubah,
      // sehingga tampilan (UI) perlu digambar ulang.
      _tasks.add(Task(title: teks));
    });

    _controller.clear(); // kosongkan kolom input setelah ditambahkan
  }

  // --------------------------------------------------------
  // FUNGSI: Mengubah status selesai/belum suatu tugas
  // --------------------------------------------------------
  void _toggleSelesai(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  // --------------------------------------------------------
  // FUNGSI: Menghapus tugas dari list
  // --------------------------------------------------------
  void _hapusTugas(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // --------------------------------------------------------
  // FUNGSI: Berpindah ke halaman Statistik (Screen 2)
  // --------------------------------------------------------
  void _bukaStatistik() {
    Navigator.push(
      context,
      MaterialPageRoute(
        // List tugas saat ini dikirim sebagai data ke halaman kedua
        builder: (context) => StatistikScreen(tasks: _tasks),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // membersihkan controller saat widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List Saya'),
        actions: [
          // Tombol di AppBar untuk pindah ke halaman Statistik
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Lihat Statistik',
            onPressed: _bukaStatistik,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ---------- BAGIAN INPUT ----------
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Tulis tugas baru...',
                      border: OutlineInputBorder(),
                    ),
                    // Memungkinkan user menekan "Enter" untuk menambah
                    onSubmitted: (_) => _tambahTugas(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _tambahTugas,
                  child: const Text('Tambah'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ---------- BAGIAN DAFTAR TUGAS ----------
            Expanded(
              child: _tasks.isEmpty
                  // Tampilan saat belum ada tugas sama sekali
                  ? const Center(
                      child: Text(
                        'Belum ada tugas.\nTambahkan tugas pertamamu!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  // ListView.builder dipakai agar efisien untuk
                  // daftar yang panjang (hanya me-render item yang terlihat)
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            // Checkbox untuk menandai selesai/belum
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (_) => _toggleSelesai(index),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                // Coret teks jika tugas sudah selesai
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: task.isDone ? Colors.grey : Colors.black,
                              ),
                            ),
                            // Tombol hapus di sisi kanan
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _hapusTugas(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
