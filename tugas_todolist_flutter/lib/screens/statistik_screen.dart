import 'package:flutter/material.dart';
import '../models/task.dart';

// ============================================================
// SCREEN 2: StatistikScreen
// ------------------------------------------------------------
// Halaman kedua aplikasi. Menampilkan ringkasan/statistik dari
// daftar tugas yang dikirim (passing data) dari HomeScreen.
// Halaman ini TIDAK mengubah data, hanya menampilkan (read-only),
// sehingga cukup menggunakan StatelessWidget.
// ============================================================
class StatistikScreen extends StatelessWidget {
  // Daftar tugas dikirim dari halaman sebelumnya lewat constructor
  final List<Task> tasks;

  const StatistikScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    // --- Perhitungan statistik sederhana ---
    final int total = tasks.length;
    final int selesai = tasks.where((t) => t.isDone).length;
    final int belum = total - selesai;

    // Persentase penyelesaian (dijaga agar tidak membagi dengan 0)
    final double persen = total == 0 ? 0 : selesai / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Tugas'),
        // Tombol kembali otomatis disediakan oleh Flutter saat
        // halaman ini dibuka lewat Navigator.push
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Kartu ringkasan total tugas
            _buildKartuStat(
              context,
              label: 'Total Tugas',
              value: '$total',
              warna: Colors.indigo,
              ikon: Icons.list_alt,
            ),
            const SizedBox(height: 16),

            // Kartu ringkasan tugas selesai
            _buildKartuStat(
              context,
              label: 'Sudah Selesai',
              value: '$selesai',
              warna: Colors.green,
              ikon: Icons.check_circle,
            ),
            const SizedBox(height: 16),

            // Kartu ringkasan tugas belum selesai
            _buildKartuStat(
              context,
              label: 'Belum Selesai',
              value: '$belum',
              warna: Colors.orange,
              ikon: Icons.pending_actions,
            ),
            const SizedBox(height: 32),

            // Progress bar visual persentase penyelesaian
            Text(
              'Progres Penyelesaian: ${(persen * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: persen, // 0.0 - 1.0
                minHeight: 14,
                backgroundColor: Colors.grey.shade300,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 32),
            if (total == 0)
              const Text(
                'Belum ada tugas yang ditambahkan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  // Widget bantu (helper) agar kode kartu statistik tidak diulang 3x
  Widget _buildKartuStat(
    BuildContext context, {
    required String label,
    required String value,
    required Color warna,
    required IconData ikon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: warna.withOpacity(0.15),
          child: Icon(ikon, color: warna),
        ),
        title: Text(label),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: warna,
          ),
        ),
      ),
    );
  }
}
