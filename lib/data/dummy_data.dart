import 'package:flutter/material.dart';
import '../models/kategori.dart';
import '../models/transaksi.dart';

const Kategori kMakan = Kategori(
  nama: 'Makan',
  ikon: Icons.restaurant,
  warna: Colors.orange,
);
const Kategori kTransportasi = Kategori(
  nama: 'Transportasi',
  ikon: Icons.directions_bus,
  warna: Colors.blue,
);
const Kategori kKuliah = Kategori(
  nama: 'Kuliah',
  ikon: Icons.school,
  warna: Colors.purple,
);
const Kategori kHiburan = Kategori(
  nama: 'Hiburan',
  ikon: Icons.movie,
  warna: Colors.pink,
);
const Kategori kLainnya = Kategori(
  nama: 'Lainnya',
  ikon: Icons.category,
  warna: Colors.blueGrey,
);

const List<Kategori> daftarKategori = [
  kMakan,
  kTransportasi,
  kKuliah,
  kHiburan,
  kLainnya,
];

/// Dummy data awal (disimpan sementara di memori).
final List<Transaksi> dataTransaksiAwal = [
  Transaksi(
    id: '1',
    judul: 'Makan Siang Kantin',
    nominal: 18000,
    kategori: kMakan,
    tanggal: DateTime(2026, 10, 27),
    catatan: 'Nasi ayam geprek + es teh',
  ),
  Transaksi(
    id: '2',
    judul: 'Ongkos KRL',
    nominal: 6000,
    kategori: kTransportasi,
    tanggal: DateTime(2026, 10, 28),
    catatan: 'Berangkat ke kampus',
  ),
  Transaksi(
    id: '3',
    judul: 'Fotokopi Modul Praktikum',
    nominal: 12000,
    kategori: kKuliah,
    tanggal: DateTime(2026, 10, 29),
    catatan: 'Modul PAB',
  ),
  Transaksi(
    id: '4',
    judul: 'Nonton Bioskop',
    nominal: 50000,
    kategori: kHiburan,
    tanggal: DateTime(2026, 10, 31),
    catatan: 'Bareng teman kelas',
  ),
  Transaksi(
    id: '5',
    judul: 'Ojek Online',
    nominal: 22000,
    kategori: kTransportasi,
    tanggal: DateTime(2026, 11, 2),
    catatan: 'Pulang malam',
  ),
  Transaksi(
    id: '6',
    judul: 'Makan Malam',
    nominal: 25000,
    kategori: kMakan,
    tanggal: DateTime(2026, 11, 3),
  ),
];