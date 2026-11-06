import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/transaksi.dart';
import '../utils/format.dart';
import 'detail_screen.dart';
import 'form_tambah_screen.dart';

const Color _warnaGaris = Color(0xFFEAEAEA);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Penyimpanan sementara (hilang saat aplikasi ditutup).
  final List<Transaksi> _daftarTransaksi = List.of(dataTransaksiAwal);

  // Nama kategori yang sedang dibuka di tab "Per Kategori".
  String? _kategoriTerbuka;

  int get _totalPengeluaran =>
      _daftarTransaksi.fold(0, (jumlah, t) => jumlah + t.nominal);

  // Navigator.push ke form, lalu menerima data dari Navigator.pop.
  Future<void> _bukaForm() async {
    final hasil = await Navigator.push<Transaksi>(
      context,
      MaterialPageRoute(builder: (_) => const FormTambahScreen()),
    );

    if (hasil != null) {
      setState(() => _daftarTransaksi.insert(0, hasil));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaksi berhasil ditambahkan')),
      );
    }
  }

  // Navigator.push ke detail sambil mengirim objek transaksi.
  void _bukaDetail(Transaksi transaksi) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(transaksi: transaksi)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        // Latar bergradasi hijau muda (tidak putih polos).
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD3EEDF), Color(0xFFF1F8F4)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                children: [
                  _headerTotal(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _tabSemuaTransaksi(),
                        _tabPerKategori(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _bukaForm,
            icon: const Icon(Icons.add),
            label: const Text('Tambah'),
          ),
        ),
      ),
    );
  }

  // AppBar bergradasi dengan logo, nama, dan tagline aplikasi.
  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 80,
      titleSpacing: 16,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F7A55), Color(0xFF1B9E6F), Color(0xFF3CC48F)],
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Koinari',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Catat pengeluaran harianmu',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
      bottom: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.white,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(icon: Icon(Icons.receipt_long), text: 'Semua Transaksi'),
          Tab(icon: Icon(Icons.category), text: 'Per Kategori'),
        ],
      ),
    );
  }

  // Kotak ikon membulat (gaya daftar fitur).
  Widget _kotakIkon(IconData ikon, Color warna, {double ukuran = 52}) {
    return Container(
      width: ukuran,
      height: ukuran,
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(ikon, color: warna),
    );
  }

  // Kartu putih membulat sebagai pembungkus item.
  Widget _kartu({required Widget child, EdgeInsets? margin}) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.black26,
      clipBehavior: Clip.antiAlias,
      margin: margin ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  // Header: gambar dari internet + total pengeluaran.
  Widget _headerTotal() {
    final warnaUtama = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            SizedBox(
              height: 130,
              width: double.infinity,
              child: Image.network(
                'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: warnaUtama),
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              color: Colors.black54,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total pengeluaran',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(_totalPengeluaran),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_daftarTransaksi.length} transaksi tercatat',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tab 1: daftar semua transaksi (ListView.separated).
  Widget _tabSemuaTransaksi() {
    if (_daftarTransaksi.isEmpty) {
      return const Center(child: Text('Belum ada transaksi'));
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
      itemCount: _daftarTransaksi.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) =>
          _kartu(child: _itemTransaksi(_daftarTransaksi[index])),
    );
  }

  // Tab 2: daftar kategori ringkas. Ketuk kategori untuk membuka
  // riwayat transaksi di dalam kategori tersebut.
  Widget _tabPerKategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: Text(
            'Ketuk kategori untuk melihat riwayat transaksinya',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
            itemCount: daftarKategori.length,
            itemBuilder: (context, index) {
              final kategori = daftarKategori[index];
              final terbuka = _kategoriTerbuka == kategori.nama;
              final daftar = _daftarTransaksi
                  .where((t) => t.kategori.nama == kategori.nama)
                  .toList();
              final subtotal =
                  daftar.fold(0, (jumlah, t) => jumlah + t.nominal);

              return _kartu(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      leading: _kotakIkon(kategori.ikon, kategori.warna),
                      title: Text(
                        kategori.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${daftar.length} transaksi',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formatRupiah(subtotal),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            terbuka ? Icons.expand_less : Icons.expand_more,
                            color: kategori.warna,
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _kategoriTerbuka = terbuka ? null : kategori.nama;
                        });
                      },
                    ),
                    if (terbuka)
                      if (daftar.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Belum ada transaksi',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      else
                        ...daftar.map(
                          (t) => Column(
                            children: [
                              const Divider(height: 1, color: _warnaGaris),
                              _itemTransaksi(t),
                            ],
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Satu baris transaksi (dipakai di kedua tab).
  Widget _itemTransaksi(Transaksi t) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: _kotakIkon(t.kategori.ikon, t.kategori.warna),
      title: Text(
        t.judul,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${t.kategori.nama} • ${formatTanggal(t.tanggal)}',
        style: const TextStyle(color: Colors.black54),
      ),
      trailing: Text(
        '- ${formatRupiah(t.nominal)}',
        style: const TextStyle(
          color: Color(0xFFD64545),
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => _bukaDetail(t),
    );
  }
}