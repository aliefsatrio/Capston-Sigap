
import 'package:flutter/material.dart';

class AboutSigapScreen extends StatelessWidget {
  const AboutSigapScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Tentang Sigap',
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
            // Logo dan identitas aplikasi
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBE0028),
                          Color(0xFFEF4444),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFBE0028).withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'SIGAP',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEBFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '● Versi 2.4.1 (Build 2026.11)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF3156B8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Sistem Informasi Pelaporan Kejadian Darurat\n'
                    'untuk Mendukung Pelayanan Publik',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Color(0xFF8A6570),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Misi kami
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        size: 19,
                        color: Color(0xFFBE0028),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Misi Kami',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF172033),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'SIGAP hadir untuk mempercepat respon tanggap '
                    'darurat terpadu lewat sinkronisasi panggilan '
                    'darurat 112, Kepolisian RI, Pemadam Kebakaran, '
                    'layanan ambulans, serta BPBD. Melalui pendekatan '
                    'partisipasi aktif masyarakat, SIGAP menggalang '
                    'budaya gotong-royong demi keselamatan lingkungan '
                    'yang inklusif, akurat, dan terpercaya.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: Color(0xFF806A72),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _missionStat(
                          Icons.bolt,
                          'Respon Cepat',
                          const Color(0xFFBE0028),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: _missionStat(
                          Icons.hub_outlined,
                          'Terpadu 112',
                          const Color(0xFF3156B8),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: _missionStat(
                          Icons.groups_outlined,
                          'Warga Siaga',
                          const Color(0xFF9A6A00),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Instansi terhubung
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Instansi Terhubung',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                Text(
                  '3 LEMBAGA',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _agencyCard(
                    Icons.fire_truck_outlined,
                    'Damkar',
                    'Penyelamatan & Kebakaran',
                    const Color(0xFFBE0028),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _agencyCard(
                    Icons.shield_outlined,
                    'Kepolisian RI',
                    'Kamtibmas & Lantas',
                    const Color(0xFF3156B8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.48,
              child: _agencyCard(
                Icons.medical_services_outlined,
                'Rumah Sakit',
                'Ambulans',
                const Color(0xFFBE0028),
              ),
            ),

            const SizedBox(height: 24),

            // Legalitas dan kebijakan
            const Text(
              'Legalitas & Kebijakan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _legalItem(
                    Icons.description_outlined,
                    'Syarat & Ketentuan Layanan',
                    'Ketentuan penggunaan aplikasi bagi publik',
                    () => _showInfo(context, 'Syarat & Ketentuan'),
                  ),
                  _divider(),
                  _legalItem(
                    Icons.lock_outline,
                    'Kebijakan Privasi',
                    'Perlindungan data pribadi & lokasi pelapor',
                    () => _showInfo(context, 'Kebijakan Privasi'),
                  ),
                  _divider(),
                  _legalItem(
                    Icons.code,
                    'Lisensi Sumber Terbuka',
                    'Daftar pustaka & modul perangkat lunak',
                    () => _showInfo(context, 'Lisensi Sumber Terbuka'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            const Center(
              child: Text(
                '© 2026 SIGAP Indonesia.',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8A8798),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _missionStat(
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1FF),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF263247),
            ),
          ),
        ],
      ),
    );
  }

  Widget _agencyCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFECEBFF),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF263247),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.3,
                    color: Color(0xFF8A8798),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legalItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFFECEBFF),
              child: Icon(
                icon,
                size: 17,
                color: const Color(0xFF3156B8),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF263247),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.3,
                      color: Color(0xFF8A8798),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Color(0xFF79545B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      indent: 12,
      endIndent: 12,
      color: Color(0xFFF1F1F5),
    );
  }

  void _showInfo(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        content: const Text(
          'Informasi lengkap bagian ini akan ditambahkan '
          'pada pengembangan aplikasi SIGAP berikutnya.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
