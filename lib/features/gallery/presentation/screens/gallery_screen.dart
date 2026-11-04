import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<Map<String, String>> screens = [
    {
      'no': '1',
      'title': 'Onboarding (Frame 1)',
      'size': '390 × 884',
      'route': '/onboarding',
      'font': 'Plus Jakarta Sans',
      'desc': 'Logo SIGAP, pin darurat, ilustrasi kota, slogan, tombol Mulai',
    },
    {
      'no': '2',
      'title': 'Daftar Akun (Frame 2)',
      'size': '390 × 883.5',
      'route': '/register',
      'font': 'Plus Jakarta Sans',
      'desc': '4 input utama, heading Kontak Darurat, 3 input darurat, tombol Daftar',
    },
    {
      'no': '3',
      'title': 'Login / Masuk ke SIGAP (Frame 3)',
      'size': '390 × 884',
      'route': '/login',
      'font': 'Liberation Sans',
      'desc': 'Input kredensial, Ingat Saya, Lupa Password, skyline biru pucat',
    },
    {
      'no': '4',
      'title': 'Verifikasi Nomor OTP (Frame 4)',
      'size': '390 × 874',
      'route': '/otp',
      'font': 'Plus Jakarta Sans',
      'desc': 'LANGKAH 2 DARI 3, 6 slot OTP prefilled, timer, WhatsApp/SMS, panel privasi',
    },
    {
      'no': '5',
      'title': 'Aktivasi Lokasi GPS (Frame 5)',
      'size': '390 × 1221 (scrollable)',
      'route': '/gps-activation',
      'font': 'Plus Jakarta Sans',
      'desc': 'Target GPS merah berlapis, 3 kartu manfaat, dialog sistem ilustratif',
    },
    {
      'no': '6',
      'title': 'Beranda SIGAP (Frame 6)',
      'size': '390 × 1521.925 (scrollable)',
      'route': '/home',
      'font': 'Plus Jakarta Sans',
      'desc': 'Header, GPS status, banner darurat, 4 layanan, kontak darurat, SOS, feed laporan',
    },
    {
      'no': '7',
      'title': 'Tombol Darurat SOS (Frame 7)',
      'size': '390 × 884',
      'route': '/sos',
      'font': 'Liberation Sans',
      'desc': 'Latar merah, cincin konsentris SOS, simulasi mode demo, kartu kontak',
    },
    {
      'no': '8',
      'title': 'Nomor Layanan Terdekat (Frame 8)',
      'size': '390 × 884',
      'route': '/emergency-services',
      'font': 'Liberation Sans / Plus Jakarta',
      'desc': 'Peta jalan, titik akurasi biru, marker layanan, daftar 4 nomor telepon darurat',
    },
    {
      'no': '9',
      'title': 'Kamera Pelaporan Kejadian (Frame 9)',
      'size': '390 × 887',
      'route': '/camera',
      'font': 'Plus Jakarta Sans',
      'desc': 'Live sensor, reticle kamera, metadata waktu/lokasi, strip kategori, shutter',
    },
    {
      'no': '10',
      'title': 'Tambah Deskripsi Laporan (Frame 10)',
      'size': '390 × 884',
      'route': '/description',
      'font': 'Plus Jakarta Sans',
      'desc': 'Preview foto, input multiline, counter 72/300 fixture, 4 kategori 2-kolom, upload',
    },
    {
      'no': '11',
      'title': 'Laporan Berhasil Dikirim (Frame 11)',
      'size': '390 × 884',
      'route': '/report-success',
      'font': 'Liberation Sans',
      'desc': 'Latar merah muda pucat, ikon centang lembut, konfeti, pesan verifikasi komunitas',
    },
    {
      'no': '12',
      'title': 'Feed Komunitas (Frame 12)',
      'size': '390 × 884',
      'route': '/community',
      'font': 'Liberation Sans',
      'desc': 'Tab Feed aktif, post Warga Tegal dengan tag Darurat, badge Diduga hoax, post Rizky_07',
    },
    {
      'no': '13',
      'title': 'Peta Komunitas Kejadian (Frame 13)',
      'size': '390 × 884',
      'route': '/community',
      'font': 'Nimbus / Plus Jakarta',
      'desc': 'Tab Peta aktif di halaman Komunitas, filter pill, marker multi-warna, kartu ringkas',
    },
    {
      'no': '14',
      'title': 'Riwayat & Statistik (Frame 14)',
      'size': '390 × 884',
      'route': '/history',
      'font': 'Liberation Sans',
      'desc': 'Tab Statistik aktif, grafik batang 6 bulan Jun-Nov, 5 lokasi (Jl. Melati "5 keig lalu")',
    },
    {
      'no': '15',
      'title': 'Profil Pengguna (Frame 15)',
      'size': '390 × 884',
      'route': '/profile',
      'font': 'Liberation Sans',
      'desc': 'Avatar Syifa Khaerunisa Nabila, nomor telepon, kartu menu putih, tombol Keluar',
    },
    {
      'no': '16',
      'title': 'Asisten P3K / SIGAP AI (Frame 16)',
      'size': '390 × 1541.5 (scrollable)',
      'route': '/first-aid',
      'font': 'Plus Jakarta Sans',
      'desc': 'Status ambulans ~6 mnt, topik medis horizontal, bubble voice memo & transkrip, 3 langkah',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      appBar: AppBar(
        title: const Text(
          'Galeri Seluruh Layar SIGAP (16 Layar)',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.home, size: 18, color: AppColors.bluePrimary),
            label: const Text('Ke Beranda', style: TextStyle(color: AppColors.bluePrimary, fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final s = screens[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.blueSurface1,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  s['no']!,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w700,
                    color: AppColors.bluePrimary,
                  ),
                ),
              ),
              title: Text(
                s['title']!,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    s['desc']!,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.bgGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          s['size']!,
                          style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.blueSurface1,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          s['font']!,
                          style: const TextStyle(fontSize: 10, color: AppColors.bluePrimary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
              onTap: () => context.push(s['route']!),
            ),
          );
        },
      ),
    );
  }
}
