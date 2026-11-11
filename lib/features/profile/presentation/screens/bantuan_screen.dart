
import 'package:flutter/material.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _faqs = [
    {
      'question':
          'Bagaimana cara menekan tombol darurat SOS jika tidak ada internet?',
      'answer':
          'Buka halaman SOS dan tekan tombol darurat. Namun, pengiriman '
          'informasi kepada petugas atau kontak membutuhkan jaringan '
          'atau mekanisme komunikasi alternatif yang tersedia.',
    },
    {
      'question':
          'Berapa lama laporan kecelakaan diverifikasi oleh petugas?',
      'answer':
          'Lama verifikasi bergantung pada jumlah laporan dan proses '
          'pemeriksaan petugas. Status laporan dapat dilihat melalui '
          'halaman Riwayat apabila fitur verifikasi telah terintegrasi.',
    },
    {
      'question':
          'Bagaimana jika saya tidak sengaja salah mengirim laporan?',
      'answer':
          'Periksa kembali informasi laporan sebelum mengirim. Jika '
          'laporan sudah terkirim, hubungi petugas atau pengelola '
          'layanan untuk meminta koreksi.',
    },
    {
      'question':
          'Apakah data pribadi dan identitas saksi pelapor aman?',
      'answer':
          'Data pribadi perlu dilindungi dan hanya digunakan sesuai '
          'kebutuhan layanan. Pada prototype ini, pengamanan dan '
          'penyimpanan data masih memerlukan integrasi lebih lanjut.',
    },
  ];

  List<Map<String, String>> get _filteredFaqs {
    final keyword = _searchController.text.toLowerCase().trim();

    if (keyword.isEmpty) return _faqs;

    return _faqs.where((faq) {
      return faq['question']!.toLowerCase().contains(keyword) ||
          faq['answer']!.toLowerCase().contains(keyword);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final faqs = _filteredFaqs;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7FF),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF172033),
            size: 22,
          ),
        ),
        title: const Text(
          'Bantuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF172033),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Color(0xFFBE0028),
              child: Icon(
                Icons.person,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kolom pencarian
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFECEBFF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Cari panduan darurat, cara lapor, atau bantuan',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7B7890),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0xFF475569),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close, size: 18),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Layanan 24 jam
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFECEBFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundColor: Color(0xFFDCDFFF),
                    child: Icon(
                      Icons.support_agent,
                      size: 22,
                      color: Color(0xFF3156B8),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LAYANAN SIAGA 24 JAM',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3156B8),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Petugas operator tanggap bencana dan medis',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Judul FAQ
            const Row(
              children: [
                Icon(
                  Icons.help_outline,
                  size: 18,
                  color: Color(0xFFBE0028),
                ),
                SizedBox(width: 7),
                Text(
                  'Pertanyaan Umum (FAQ)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Daftar FAQ
            if (faqs.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Text(
                  'Pertanyaan tidak ditemukan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
              )
            else
              ...faqs.map(
                (faq) => Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(
                        14, 0, 14, 16,
                      ),
                      iconColor: const Color(0xFFBE0028),
                      collapsedIconColor: const Color(0xFF79545B),
                      title: Text(
                        faq['question']!,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF263247),
                        ),
                      ),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            faq['answer']!,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.6,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Bantuan tambahan
            Center(
              child: Column(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECEBFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.support_agent,
                      size: 23,
                      color: Color(0xFF3156B8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Masih butuh bantuan lain?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Tim SIGAP siap membantu menyelesaikan\n'
                    'kendala pelaporan Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF8A8798),
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
