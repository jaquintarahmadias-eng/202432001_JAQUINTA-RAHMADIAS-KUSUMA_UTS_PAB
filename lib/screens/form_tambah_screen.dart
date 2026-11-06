import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/dummy_data.dart';
import '../models/kategori.dart';
import '../models/transaksi.dart';
import '../utils/format.dart';

class FormTambahScreen extends StatefulWidget {
  const FormTambahScreen({super.key});

  @override
  State<FormTambahScreen> createState() => _FormTambahScreenState();
}

class _FormTambahScreenState extends State<FormTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _nominalController = TextEditingController();
  final _catatanController = TextEditingController();

  Kategori? _kategoriDipilih;
  DateTime _tanggal = DateTime.now();

  @override
  void dispose() {
    _judulController.dispose();
    _nominalController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (hasil != null) {
      setState(() => _tanggal = hasil);
    }
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final transaksi = Transaksi(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      judul: _judulController.text.trim(),
      nominal: int.parse(_nominalController.text),
      kategori: _kategoriDipilih!,
      tanggal: _tanggal,
      catatan: _catatanController.text.trim(),
    );

    // Kirim data kembali ke halaman utama.
    Navigator.pop(context, transaksi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Transaksi',
                  prefixIcon: Icon(Icons.edit),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Nominal (Rp)',
                  prefixIcon: Icon(Icons.payments),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nominal tidak boleh kosong';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Nominal harus lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Kategori>(
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  prefixIcon: Icon(Icons.category),
                ),
                items: daftarKategori
                    .map(
                      (k) => DropdownMenuItem<Kategori>(
                        value: k,
                        child: Row(
                          children: [
                            Icon(k.ikon, color: k.warna),
                            const SizedBox(width: 8),
                            Text(k.nama),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => _kategoriDipilih = value,
                validator: (value) =>
                    value == null ? 'Pilih salah satu kategori' : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _pilihTanggal,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(formatTanggal(_tanggal)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _catatanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}