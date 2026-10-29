
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/barang_provider.dart';
import 'daftar_barang_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BarangProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StokU',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFE3F2E4),
              child: Icon(
                Icons.inventory_2_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            final padding = lebar >= 700 ? 32.0 : 20.0;

            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat datang!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Pantau persediaan barang toko kamu '
                          'dengan lebih mudah.',
                        ),
                        const SizedBox(height: 24),
                        LayoutBuilder(
                          builder: (context, innerConstraints) {
                            final kolom =
                                innerConstraints.maxWidth >= 600 ? 2 : 1;

                            return GridView.count(
                              crossAxisCount: kolom,
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio:
                                  kolom == 2 ? 2.2 : 2.2,
                              children: [
                                _KartuRingkasan(
                                  judul: 'Total Jenis Barang',
                                  nilai: '${provider.jumlahBarang}',
                                  ikon: Icons.inventory_2_outlined,
                                  warna: const Color(0xFF2E7D32),
                                ),
                                _KartuRingkasan(
                                  judul: 'Stok Menipis',
                                  nilai: '${provider.jumlahStokMenipis}',
                                  ikon: Icons.warning_amber_rounded,
                                  warna: const Color(0xFFEF8F00),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Menu Utama',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE3F2E4),
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            title: const Text(
                              'Daftar Barang',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: const Text(
                              'Lihat dan kelola persediaan barang',
                            ),
                            trailing:
                                const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const DaftarBarangScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Data stok diperbarui melalui menu '
                          'Daftar Barang.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
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

class _KartuRingkasan extends StatelessWidget {
  final String judul;
  final String nilai;
  final IconData ikon;
  final Color warna;

  const _KartuRingkasan({
    required this.judul,
    required this.nilai,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(ikon, color: warna, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    nilai,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
