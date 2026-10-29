
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/barang.dart';
import '../providers/barang_provider.dart';
import 'detail_barang_screen.dart';
import 'tambah_barang_screen.dart';

class DaftarBarangScreen extends StatefulWidget {
  const DaftarBarangScreen({super.key});

  @override
  State<DaftarBarangScreen> createState() =>
      _DaftarBarangScreenState();
}

class _DaftarBarangScreenState extends State<DaftarBarangScreen> {
  String kataKunci = '';

  String rupiah(double harga) {
    return 'Rp ${harga.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BarangProvider>();

    final barangTampil = provider.daftarBarang.where((barang) {
      final nama = barang.nama.toLowerCase();
      final kategori = barang.kategori.toLowerCase();
      final cari = kataKunci.toLowerCase();

      return nama.contains(cari) || kategori.contains(cari);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Barang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahBarangScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final padding = constraints.maxWidth >= 700
                ? 32.0
                : 16.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari nama atau kategori barang...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (nilai) {
                          setState(() {
                            kataKunci = nilai;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: barangTampil.isEmpty
                            ? const Center(
                                child: Text(
                                  'Barang tidak ditemukan.',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.separated(
                                itemCount: barangTampil.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final barang = barangTampil[index];

                                  return _KartuBarang(
                                    barang: barang,
                                    harga: rupiah(barang.harga),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DetailBarangScreen(
                                            barangId: barang.id,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
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

class _KartuBarang extends StatelessWidget {
  final Barang barang;
  final String harga;
  final VoidCallback onTap;

  const _KartuBarang({
    required this.barang,
    required this.harga,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final stokMenipis = barang.stok <= 5;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE3F2E4),
          child: Icon(
            Icons.inventory_2_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          barang.nama,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(barang.kategori),
              const SizedBox(height: 4),
              Text(harga),
              const SizedBox(height: 4),
              Text(
                'Stok: ${barang.stok}',
                style: TextStyle(
                  color: stokMenipis
                      ? Colors.deepOrange
                      : Colors.black54,
                  fontWeight: stokMenipis
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
