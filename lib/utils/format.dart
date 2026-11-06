/// Mengubah angka menjadi format rupiah, contoh: 25000 -> "Rp 25.000".
String formatRupiah(int nilai) {
  final teks = nilai.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]}.',
      );
  return 'Rp $teks';
}

const List<String> _namaBulan = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

/// Mengubah DateTime menjadi teks, contoh: "5 November 2026".
String formatTanggal(DateTime tgl) {
  return '${tgl.day} ${_namaBulan[tgl.month - 1]} ${tgl.year}';
}