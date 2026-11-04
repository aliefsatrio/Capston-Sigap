# SIGAP - Audit Sebelum Implementasi & Inventaris Visual

## 1. Ringkasan Desain & Baseline
- **Platform**: Flutter (Android/iOS/Web/Desktop)
- **Baseline Viewport Width**: 390 logical px
- **Tinggi Frame Baseline**: 844 px (dengan offset internal 20 px pada frame ekspor 884 px)
- **Figma File Key**: `IuA4kgQoS6o1JvX5CbJhmZ`
- **Halaman Sumber**: `0:1`

---

## 2. Inventaris Visual per Layar (16 Layar + 1 Komponen Navigasi)

| No | Nama Layar | Dimensi Frame Sumber | Layout & Scroll | Background | Karakteristik Visual Utama |
|---|---|---|---|---|---|
| 1 | Onboarding | 390 × 884 | Single Viewport (Fit) | `#FFFFFF` | Logo pin merah (`#BA0022`), teks SIGAP ExtraBold 30 biru, ilustrasi skyline dan hand-phone, slogan, tombol Mulai pill, 3 indikator titik (titik 1 lebar 20px). |
| 2 | Daftar Akun | 390 × 883,5 | Scrollable | `#FFFFFF` | Tombol back kotak, judul 24 Bold, 4 form registrasi utama, heading Kontak Darurat, 3 form darurat, dropdown hubungan, tombol Daftar, tautan Masuk. |
| 3 | Login | 390 × 884 | Single Viewport / Scroll | `#FFFFFF` | Liberation Sans 26 Bold, outline inputs, checkbox Ingat Saya, link Lupa Password, tombol Masuk, separator 'atau', tombol outline Daftar Akun, skyline biru pucat bawah. |
| 4 | Verifikasi Nomor OTP | 390 × 874 | Single Viewport | `#FAF8FF` | "LANGKAH 2 DARI 3" step bar, perisai biru verifikasi, 6 kotak OTP (4, 8, 2 pre-filled, slot 4 aktif), timer 00:44, WhatsApp & SMS button, tombol merah Verifikasi, kartu jaminan privasi. |
| 5 | Aktivasi Lokasi GPS | 390 × 1221 | Scrollable | `#FFFFFF` | Target GPS konsentris merah, badge AKURASI TINGGI, 3 kartu manfaat (Presisi, Bencana, Geotag), simulasi dialog izin Android/iOS dengan 2 opsi, tombol aktifkan merah. |
| 6 | Beranda SIGAP | 390 × 1521,925 | Scrollable | `#FAF8FF` | Header status GPS aktif Tegal, banner darurat merah marun, 4 tombol cepat layanan terdekat, hubungi kontak, kartu SOS merah, radius 3 km, 2 feed laporan warga lengkap foto & badge "Kamera Sigap". |
| 7 | Tombol Darurat SOS | 390 × 884 | Single Viewport | `#E53935` | Full red background, ikon sirene berkedip, 3 cincin riak lingkaran SOS konsentris, tombol Kirim Sekarang, kartu kontak darurat putih (Ibu) dengan ikon edit. Mode demo simulasi. |
| 8 | Nomor Layanan Terdekat | 390 × 884 | Single Viewport | `#FAF8FF` | Header GPS aktif, peta raster/vector dengan pin Polisi, Damkar, RS, PMI, lingkaran biru akurasi pengguna, daftar 4 layanan dengan tombol panggilan instan. |
| 9 | Kamera Pelaporan | 390 × 887 | Single Viewport | `#FAF8FF` | Header Lapor Kejadian + avatar, viewfinder kamera dengan reticle, LIVE SENSOR badge merah, overlay koordinat (-6.8797, 109.1256), horizontal category strip, tombol shutter merah, Voice Memo, Bantuan. |
| 10 | Tambah Deskripsi | 390 × 884 | Scrollable | `#FAF8FF` | Foto preview kecelakaan, tombol hapus foto, multiline textfield 300 char, counter fixture "72/300", 4 kategori pilihan grid 2-kolom (Kecelakaan selected merah muda), tombol Upload Laporan. |
| 11 | Laporan Berhasil Dikirim | 390 × 884 | Single Viewport | `#FFF5F5` (Pink Pucat) | Centang putih di lingkaran merah lembut, sebaran confetti lingkaran kecil, judul berhasil, 3 baris teks verifikasi komunitas, tombol "Lihat Laporan Saya", siluet gedung merah muda bawah. |
| 12 | Feed Komunitas | 390 × 884 | Scrollable | `#FAF8FF` | Tab bar Feed & Peta, post 1 (Warga Tegal, Kecelakaan Jl. Pancasila, foto, like 120, komen 15, tag "Diduga hoax"), post 2 (Rizky_07, Banjir Perumahan Taman Indah). |
| 13 | Peta Komunitas | 390 × 884 | Viewport + Map | `#FAF8FF` | Tab Peta, filter pill (Semua, Bencana, Kecelakaan, Lainnya), peta minimalis dengan titik merah/biru/hijau/kuning, titik user biru berdenyut, bottom summary card kejadian terdekat. |
| 14 | Riwayat & Statistik | 390 × 884 | Scrollable | `#FAF8FF` | Tab Statistik aktif, diagram batang biru vertikal 6 bulan (Jun 12 s/d Nov 14), list lokasi kejadian (termasuk fixture teks asli "5 keig lalu" pada Jl. Melati). |
| 15 | Profil Pengguna | 390 × 884 | Scrollable | `#FAF8FF` | Avatar Syifa Khaerunisa Nabila, nomor +62 8xxxxxxxxxx, menu vertikal (Edit Profil, Kontak Darurat, Pengaturan, Bantuan, Tentang SIGAP), tombol merah Keluar. |
| 16 | Asisten P3K / SIGAP AI | 390 × 1541,5 | Scrollable | `#FAF8FF` | Header AI Assistant 24 jam + Call 112, status estimasi Ambulans PMI Tegal ~6 menit, horizontal strip 5 topik medis, bubble bot, bubble pesan suara (0:14) & transkrip, kartu panduan 3 prioritas medis, voice recording composer. |
| 17 | Bottom Navigation Bar | 388 × 76 | Fixed Overlay | `#FFFFFF` | Elevasi/shadow atas, tombol Lapor bulat menonjol keluar di tengah berwarna merah (`#BA0022`), variasi tab (Home variant vs Services variant). |

---

## 3. Inventaris Tipografi

| Keluarga Font | Berat (Weight) | Ukuran (px) | Digunakan Pada | Lisensi / Status Bundel |
|---|---|---|---|---|
| **Plus Jakarta Sans** | ExtraBold (w800) | 30 | Judul Onboarding SIGAP | OFL / Tersedia di `assets/fonts/` |
| **Plus Jakarta Sans** | Bold (w700) | 16–24 | Header, Judul Section, Button | OFL / Tersedia di `assets/fonts/` |
| **Plus Jakarta Sans** | SemiBold (w600) | 13–15 | Subjudul, Tombol Utama | OFL / Tersedia di `assets/fonts/` |
| **Plus Jakarta Sans** | Regular (w400) | 11–14 | Deskripsi, Input text, Info panel | OFL / Tersedia di `assets/fonts/` |
| **Liberation Sans** | Bold (w700) | 15–27 | Login title, SOS title, Statistik, Profil | OFL/GPL / Disubstitusi dengan Plus Jakarta Sans / Bundled |
| **Liberation Sans** | Regular (w400) | 12–14 | Feed Komunitas, Deskripsi Login | OFL/GPL / Disubstitusi dengan Plus Jakarta Sans / Bundled |
| **Nimbus Sans** | Regular/Bold | 11–13 | Peta Komunitas | Subtitusi wajar ke Plus Jakarta Sans |

---

## 4. Inventaris Aset & Status Ketersediaan

1. **Logo & Ikon Pin SIGAP**: Dirender secara murni menggunakan widget vektor Flutter (`Container`, `BoxDecoration`, `Icons.location_on`, `Icons.shield`).
2. **Ilustrasi Skyline Onboarding**: Dirender menggunakan `CustomPainter` dan geometri vector (`_CitySilhouettePainter`), tidak menggunakan gambar statis bitmap agar tajam di semua DPI layar.
3. **Ilustrasi Skyline Login**: Dirender murni menggunakan `_SkylinePainter` dengan nuansa biru pucat `#EAEDFF` dan `#BBC4FF`.
4. **Ilustrasi Peta (Home, Emergency Services, Community)**: Dirender dengan `CustomPainter` terkalibrasi (`_MapPainter`, `_ServiceMapPainter`, `_CommunityMapPainter`) dengan jalan, blok kota, marker koordinat, dan lingkaran akurasi GPS biru.
5. **Foto Kejadian / Kamera**: Menggunakan placeholder kontainer terstruktur dengan rasio aspek identik Figma, icon image, dan badge `Kamera Sigap` merah asli.
6. **Ikon Navigasi & Aksi**: Menggunakan pustaka Material Icons resmi yang dipetakan 1:1 ke referensi Figma.

---

## 5. Dokumentasi Inkonsistensi & Asumsi Desain Sumber

1. **Counter 72/300 (Tambah Deskripsi)**:
   - *Temuan*: Teks yang tertulis pada Figma memiliki panjang ~88 karakter, tetapi counter menampilkan "72/300".
   - *Solusi*: Mode fixture mempertahankan teks dan nilai "72/300" sesuai spesifikasi inspeksi visual Figma, dan TextField interaktif tetap mendukung input dinamis.
2. **Typo "5 keig lalu" (Layar Statistik)**:
   - *Temuan*: Di baris Jl. Melati tertulis "5 keig lalu" alih-alih "5 kejadian".
   - *Solusi*: Teks asli dipertahankan di fixture visual per aturan audit tanpa perbaikan diam-diam, dan dicatat di sini untuk konfirmasi tim produk.
3. **Tab Riwayat Kosong pada Frame 14**:
   - *Temuan*: Frame 14 hanya menampilkan tab Statistik dalam keadaan terpilih.
   - *Solusi*: Disediakan placeholder informatif "Belum ada riwayat laporan" yang rapi saat tab Riwayat ditekan.
4. **Variasi Bottom Nav**:
   - *Temuan*: Desain Figma memiliki 2 varian footer (Varian Home dengan tab P3K/Bot, dan Varian Services dengan Profil).
   - *Solusi*: Komponen `SigapBottomNav` mendukung parameter `SigapNavVariant.home` dan `SigapNavVariant.services`.
