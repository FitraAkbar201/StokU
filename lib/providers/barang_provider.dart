
import 'package:flutter/material.dart';
import '../models/barang.dart';

class BarangProvider extends ChangeNotifier {
  final List<Barang> _daftarBarang = [
    Barang(
      id: 'BRG001',
      nama: 'Beras Premium',
      kategori: 'Sembako',
      harga: 75000,
      stok: 12,
      deskripsi: 'Beras premium kemasan 5 kg',
    ),
    Barang(
      id: 'BRG002',
      nama: 'Minyak Goreng',
      kategori: 'Sembako',
      harga: 18000,
      stok: 4,
      deskripsi: 'Minyak goreng kemasan 1 liter',
    ),
    Barang(
      id: 'BRG003',
      nama: 'Gula Pasir',
      kategori: 'Sembako',
      harga: 17000,
      stok: 8,
      deskripsi: 'Gula pasir kemasan 1 kg',
    ),
  ];

  List<Barang> get daftarBarang =>
      List.unmodifiable(_daftarBarang);

  int get jumlahBarang => _daftarBarang.length;

  int get jumlahStokMenipis =>
      _daftarBarang.where((barang) => barang.stok <= 5).length;

  void tambahBarang(Barang barang) {
    _daftarBarang.add(barang);
    notifyListeners();
  }

  Barang? cariBarang(String id) {
    for (final barang in _daftarBarang) {
      if (barang.id == id) {
        return barang;
      }
    }
    return null;
  }

  void editBarang(Barang barangDiperbarui) {
    final index = _daftarBarang.indexWhere(
      (barang) => barang.id == barangDiperbarui.id,
    );

    if (index == -1) return;

    _daftarBarang[index] = barangDiperbarui;
    notifyListeners();
  }

  void hapusBarang(String id) {
    _daftarBarang.removeWhere((barang) => barang.id == id);
    notifyListeners();
  }
}
