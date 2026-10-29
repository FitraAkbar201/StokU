
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/barang.dart';
import '../providers/barang_provider.dart';

class EditBarangScreen extends StatefulWidget {
  final String barangId;

  const EditBarangScreen({
    super.key,
    required this.barangId,
  });

  @override
  State<EditBarangScreen> createState() => _EditBarangScreenState();
}

class _EditBarangScreenState extends State<EditBarangScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _deskripsiController = TextEditingController();

  bool _sudahDiisi = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_sudahDiisi) return;

    final barang = context
        .read<BarangProvider>()
        .cariBarang(widget.barangId);

    if (barang != null) {
      _namaController.text = barang.nama;
      _kategoriController.text = barang.kategori;
      _hargaController.text = barang.harga.toString();
      _stokController.text = barang.stok.toString();
      _deskripsiController.text = barang.deskripsi ?? '';
    }

    _sudahDiisi = true;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _simpanPerubahan(Barang barangLama) {
    if (!_formKey.currentState!.validate()) return;

    final harga = double.tryParse(_hargaController.text.trim());
    final stok = int.tryParse(_stokController.text.trim());

    if (harga == null || stok == null) return;

    final barangBaru = Barang(
      id: barangLama.id,
      nama: _namaController.text.trim(),
      kategori: _kategoriController.text.trim(),
      harga: harga,
      stok: stok,
      deskripsi: _deskripsiController.text.trim().isEmpty
          ? null
          : _deskripsiController.text.trim(),
    );

    context.read<BarangProvider>().editBarang(barangBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barang berhasil diperbarui.')),
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
    final barang = context
        .watch<BarangProvider>()
        .cariBarang(widget.barangId);

    if (barang == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Barang')),
        body: const Center(
          child: Text('Barang tidak ditemukan.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Barang')),
      body: SafeArea(
        child: Center(
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
                      'Ubah Informasi Barang',
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
                      ),
                      validator: (nilai) =>
                          _wajibDiisi(nilai, 'Nama barang'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _kategoriController,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
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
                      ),
                      validator: (nilai) {
                        final stok = int.tryParse(
                          nilai?.trim() ?? '',
                        );
                        if (stok == null || stok < 0) {
                          return 'Stok harus bilangan bulat 0 atau lebih.';
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
                      onPressed: () => _simpanPerubahan(barang),
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Simpan Perubahan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
