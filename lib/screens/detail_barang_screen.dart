
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/barang.dart';
import '../providers/barang_provider.dart';
import 'edit_barang_screen.dart';

class DetailBarangScreen extends StatelessWidget {
  final String barangId;

  const DetailBarangScreen({
    super.key,
    required this.barangId,
  });

  String _rupiah(double harga) {
    return 'Rp ${harga.toStringAsFixed(0)}';
  }

  Future<void> _hapusBarang(
    BuildContext context,
    Barang barang,
  ) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin ingin menghapus ${barang.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi != true || !context.mounted) return;

    context.read<BarangProvider>().hapusBarang(barang.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BarangProvider>();
    final barang = provider.cariBarang(barangId);

    if (barang == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Barang')),
        body: const Center(
          child: Text('Barang tidak ditemukan.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
        actions: [
          IconButton(
            tooltip: 'Edit barang',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditBarangScreen(
                    barangId: barang.id,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Hapus barang',
            onPressed: () => _hapusBarang(context, barang),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2E4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      size: 76,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    barang.nama,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    barang.kategori,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _InformasiBarang(
                    judul: 'ID Barang',
                    nilai: barang.id,
                  ),
                  _InformasiBarang(
                    judul: 'Harga',
                    nilai: _rupiah(barang.harga),
                  ),
                  _InformasiBarang(
                    judul: 'Jumlah Stok',
                    nilai: '${barang.stok} unit',
                  ),
                  _InformasiBarang(
                    judul: 'Status Stok',
                    nilai: barang.stok <= 5
                        ? 'Stok menipis'
                        : 'Stok tersedia',
                  ),
                  _InformasiBarang(
                    judul: 'Deskripsi',
                    nilai: barang.deskripsi?.isNotEmpty == true
                        ? barang.deskripsi!
                        : 'Tidak ada deskripsi',
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: () => _hapusBarang(context, barang),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus Barang'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InformasiBarang extends StatelessWidget {
  final String judul;
  final String nilai;

  const _InformasiBarang({
    required this.judul,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              nilai,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
