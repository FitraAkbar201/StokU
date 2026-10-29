# Changelog

## Gate 1 — Fondasi Aplikasi StokU

### Jadi
- Menambahkan struktur folder `models`, `providers`, dan `screens`.
- Membuat model data barang dan pengelolaan data menggunakan Provider.
- Mengimplementasikan halaman Dashboard, Daftar Barang, Tambah Barang, Detail Barang, dan Edit Barang.
- Mengimplementasikan alur pengelolaan data barang menggunakan data sementara.
- Menambahkan pencarian dan validasi input barang.

### Macet
- Mengalami stuck pada saat run aplikasi menggunakan device emulator android dan saat mengakses pengaturan ukuran teks.
- Mengalami kesalahan referensi kelas pada aplikasi dan masalah *overflow* di dashboard ketika skala teks diperbesar menjadi 150%.

### Keputusan
- Melakukan *cold boot* pada emulator android yang digunakan.
- Menambahkan code sementara pada lib/main.dart agar skala teks menjadi 150% yang digunakan sebagai validasi pengujian tampilan.
- Menghapus kembali kode simulasi skala teks setelah pengujian selesai agar aplikasi menggunakan skala teks normal.

### AI
- Menggunakan ChatGPT untuk membantu penyusunan struktur kode, penjelasan error beserta solusinya, dan panduan pengujian aplikasi.
- Prompt utama yang digunakan:

  > Bantu saya untuk menyelesaikan pembuatan tahap G1. Untuk ketentuannya sudah saya cantumkan di dalam file. Sebelum lanjut ke tahap pengerjaan, berikan saya penjelasan mengenai apa saja yang harus diselesaikan di tahap ini, kemudian beri saya panduan lengkap mengenai alur pengerjaannya.
- Melakukan penyesuaian kode secara manual berdasarkan hasil pengujian dan arahan yang diberikan, termasuk perubahan `childAspectRatio` pada `lib/screens/dashboard_screen.dart` serta beberapa bagian kode lainnya.

#### Vidio Demo G1
- Link vidio : https://youtu.be/UgO-c-pmF00