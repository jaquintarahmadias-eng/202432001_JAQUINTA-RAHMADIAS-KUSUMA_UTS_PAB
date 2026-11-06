import 'package:flutter/material.dart';

/// Model kategori pengeluaran (nama, ikon, dan warna).
class Kategori {
  final String nama;
  final IconData ikon;
  final Color warna;

  const Kategori({
    required this.nama,
    required this.ikon,
    required this.warna,
  });
}