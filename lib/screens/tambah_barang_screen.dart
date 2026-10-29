
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/barang.dart';
import '../providers/barang_provider.dart';

class TambahBarangScreen extends StatefulWidget {
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() =>
      _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _simpanBarang() {
    if (!_formKey.currentState!.validate()) return;

    final harga = double.tryParse(_hargaController.text.trim());
    final stok = int.tryParse(_stokController.text.trim());

    if (harga == null || stok == null) return;

    final barang = Barang(
      id: 'BRG${DateTime.now().microsecondsSinceEpoch}',
      nama: _namaController.text.trim(),
      kategori: _kategoriController.text.trim(),
      harga: harga,
      stok: stok,
      deskripsi: _deskripsiController.text.trim().isEmpty
          ? null
          : _deskripsiController.text.trim(),
    );

    context.read<BarangProvider>().tambahBarang(barang);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barang berhasil ditambahkan.')),
    );

    Navigator.pop(context);
  }

  String? _wajibDiisi(String? nilai, String label) {
    if (nilai == null || nilai.trim().isEmpty) {
      return '$label wajib diisi.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Barang')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Informasi Barang',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _namaController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Barang',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.inventory_2_outlined),
                          ),
                          validator: (nilai) =>
                              _wajibDiisi(nilai, 'Nama barang'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _kategoriController,
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            hintText: 'Contoh: Sembako',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          validator: (nilai) =>
                              _wajibDiisi(nilai, 'Kategori'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _hargaController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Harga (Rp)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.payments_outlined),
                          ),
                          validator: (nilai) {
                            final harga = double.tryParse(
                              nilai?.trim() ?? '',
                            );
                            if (harga == null || harga <= 0) {
                              return 'Masukkan harga lebih dari 0.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _stokController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Jumlah Stok',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.numbers),
                          ),
                          validator: (nilai) {
                            final stok = int.tryParse(
                              nilai?.trim() ?? '',
                            );
                            if (stok == null || stok < 0) {
                              return 'Masukkan stok berupa bilangan bulat 0 atau lebih.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _deskripsiController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Deskripsi (opsional)',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: _simpanBarang,
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Simpan Barang'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
