# StokU — Aplikasi Manajemen Stok Barang

StokU adalah aplikasi manajemen stok barang berbasis Flutter yang dirancang untuk membantu pelaku UMKM, khususnya toko kelontong atau toko sembako, dalam mencatat dan mengelola persediaan barang dengan lebih mudah.

Aplikasi ini dikembangkan sebagai proyek Capstone pada mata kuliah Pemrograman Perangkat Bergerak (PPB).

## Latar Belakang

Pengelolaan stok secara manual dapat menyebabkan ketidaksesuaian jumlah barang, kesulitan mencari informasi produk, serta keterlambatan mengetahui barang yang stoknya hampir habis.

StokU dikembangkan sebagai solusi untuk membantu pemilik atau pengelola toko dalam melihat, menambahkan, mencari, mengubah, dan menghapus data barang melalui aplikasi dengan antarmuka yang sederhana.

## Fitur Utama

Fitur yang telah diimplementasikan pada Gate 1:

- **Dashboard:** menampilkan ringkasan informasi stok barang.
- **Daftar Barang:** menampilkan data barang yang tersedia.
- **Pencarian Barang:** membantu pengguna menemukan barang berdasarkan informasi yang tersedia.
- **Tambah Barang:** menambahkan data barang baru.
- **Detail Barang:** menampilkan informasi barang yang dipilih.
- **Edit Barang:** mengubah informasi barang.
- **Hapus Barang:** menghapus data barang.
- **Validasi Input:** membantu memastikan data yang dimasukkan memenuhi ketentuan form.

## Status Pengembangan

### Gate 1 — Fondasi Aplikasi

Tahap Gate 1 berfokus pada pembangunan fondasi aplikasi, navigasi antarlayar, pemisahan model data dari antarmuka, pengelolaan state menggunakan Provider, dan implementasi alur utama pengelolaan barang.

Data barang pada tahap ini masih disimpan sementara di memori aplikasi. Penyimpanan permanen dan integrasi layanan backend belum menjadi bagian dari implementasi Gate 1.

- **Branch:** `main`
- **Tag:** `gate-1`
- **Commit Gate 1:** `b1ea6f5`

## Cara Menjalankan Aplikasi

Pastikan Flutter SDK telah terpasang dan dapat diakses melalui terminal.

1. Clone repository:

   ```bash
   git clone https://github.com/FitraAkbar201/StokU.git
   ```

2. Masuk ke direktori proyek:

   ```bash
   cd StokU
   ```

3. Unduh dependency:

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi pada perangkat atau emulator yang tersedia:

   ```bash
   flutter run
   ```

## Pengujian

Untuk memeriksa kualitas kode, jalankan:

```bash
flutter analyze
flutter test
```

Pada pengujian terakhir Gate 1, analisis kode dan pengujian otomatis berhasil dijalankan.

## Pengembangan Selanjutnya

Pengembangan berikutnya akan mengikuti tahapan capstone yang ditetapkan, dengan penyempurnaan fitur serta pengembangan penyimpanan data dan kemampuan aplikasi sesuai kebutuhan pada gate selanjutnya.

## Pengembang

**Fitra Akbar**  
Program Studi Teknik Informatika  
Universitas Dian Nuswantoro
