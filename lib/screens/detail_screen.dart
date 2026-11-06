import 'package:flutter/material.dart';
import '../models/transaksi.dart';
import '../utils/format.dart';

class DetailScreen extends StatelessWidget {
  final Transaksi transaksi;

  const DetailScreen({super.key, required this.transaksi});

  @override
  Widget build(BuildContext context) {
    final kategori = transaksi.kategori;
    final warnaUtama = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _kotakIkon(kategori.ikon, kategori.warna, ukuran: 80),
            const SizedBox(height: 12),
            Text(
              transaksi.judul,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '- ${formatRupiah(transaksi.nominal)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD64545),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFEAEAEA)),
              ),
              child: Column(
                children: [
                  _baris(Icons.title, 'Judul', transaksi.judul, warnaUtama),
                  _pemisah(),
                  _baris(kategori.ikon, 'Kategori', kategori.nama,
                      kategori.warna),
                  _pemisah(),
                  _baris(Icons.calendar_today, 'Tanggal',
                      formatTanggal(transaksi.tanggal), warnaUtama),
                  _pemisah(),
                  _baris(
                    Icons.notes,
                    'Catatan',
                    transaksi.catatan.isEmpty ? '-' : transaksi.catatan,
                    warnaUtama,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pemisah() => const Divider(height: 1, color: Color(0xFFEAEAEA));

  // Kotak ikon membulat (gaya daftar fitur).
  Widget _kotakIkon(IconData ikon, Color warna, {double ukuran = 56}) {
    return Container(
      width: ukuran,
      height: ukuran,
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(ukuran * 0.28),
      ),
      child: Icon(ikon, color: warna, size: ukuran * 0.45),
    );
  }

  // Satu baris informasi: nilai tebal, label abu-abu.
  Widget _baris(IconData ikon, String label, String nilai, Color warna) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: _kotakIkon(ikon, warna),
      title: Text(
        nilai,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(label, style: const TextStyle(color: Colors.black54)),
    );
  }
}