import 'kategori.dart';

/// Model transaksi pengeluaran.
class Transaksi {
  final String id;
  final String judul;
  final int nominal;
  final Kategori kategori;
  final DateTime tanggal;
  final String catatan;

  const Transaksi({
    required this.id,
    required this.judul,
    required this.nominal,
    required this.kategori,
    required this.tanggal,
    this.catatan = '',
  });
}