
class Barang {
  final String id;
  String nama;
  String kategori;
  double harga;
  int stok;
  String? deskripsi;

  Barang({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.stok,
    this.deskripsi,
  });
}
