
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _earlyWarning = true;
  bool _sosSiren = true;
  bool _verifiedReport = true;

  bool _anonymousIdentity = false;
  bool _biometric = true;

  bool _darkMode = false;

  String _language = 'Bahasa Indonesia';

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Bahasa Aplikasi',
          style: TextStyle(fontSize: 16),
        ),
        content: RadioGroup<String>(
          groupValue: _language,
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              _language = value;
            });

            Navigator.pop(dialogContext);
            _showMessage('Bahasa dipilih: $_language');
          },
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: 'Bahasa Indonesia',
                title: Text(
                  'Bahasa Indonesia',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              RadioListTile<String>(
                value: 'English',
                title: Text(
                  'English',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPinDialog() {
    final pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Kata Sandi & PIN Darurat',
          style: TextStyle(fontSize: 16),
        ),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'Masukkan PIN baru',
            hintText: 'Maksimal 6 digit',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (pinController.text.length < 4) {
                _showMessage('PIN minimal 4 digit.');
                return;
              }

              Navigator.pop(dialogContext);
              _showMessage(
                'Contoh PIN berhasil dimasukkan. '
                'Penyimpanan aman belum diintegrasikan.',
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Bersihkan Data Offline',
          style: TextStyle(fontSize: 16),
        ),
        content: const Text(
          'Apakah kamu yakin ingin membersihkan data offline '
          'yang tersimpan di aplikasi?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBE0028),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              _showMessage(
                'Pembersihan data belum terhubung '
                'dengan penyimpanan offline.',
              );
            },
            child: const Text('Bersihkan'),
          ),
        ],
      ),
    );
  }

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
          ),
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172033),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFFBE0028),
              child: Icon(
                Icons.person,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status proteksi
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Color(0xFFFFE4E6),
                    child: Icon(
                      Icons.shield,
                      size: 18,
                      color: Color(0xFFBE0028),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Proteksi Aktif',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF172033),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Sistem tanggap darurat 24/7 siaga',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'OPTIMAL',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3156B8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _sectionTitle(
              Icons.notifications_active_outlined,
              'NOTIFIKASI & PERINGATAN',
            ),

            _buildSwitchCard(
              icon: Icons.warning_amber_rounded,
              title: 'Peringatan Dini Bencana',
              description:
                  'Radius 5 km mendeteksi gempa, banjir, dan cuaca ekstrem',
              value: _earlyWarning,
              onChanged: (v) => setState(() => _earlyWarning = v),
            ),

            _buildSwitchCard(
              icon: Icons.volume_up_outlined,
              title: 'Sirene SOS Ekstrem',
              description:
                  'Bunyikan alarm darurat walau ponsel dalam mode hening',
              value: _sosSiren,
              onChanged: (v) => setState(() => _sosSiren = v),
            ),

            _buildSwitchCard(
              icon: Icons.verified_user_outlined,
              title: 'Laporan Terverifikasi',
              description:
                  'Hanya terima kabar insiden dari kontributor terpercaya',
              value: _verifiedReport,
              onChanged: (v) => setState(() => _verifiedReport = v),
            ),

            const SizedBox(height: 20),

            _sectionTitle(
              Icons.security_outlined,
              'PRIVASI & KEAMANAN',
            ),

            _buildActionCard(
              icon: Icons.near_me_outlined,
              title: 'Pelacakan GPS Presisi',
              description:
                  'Latar belakang untuk evaluasi cepat',
              trailing: const Text(
                'Selalu Izinkan  ›',
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF3156B8),
                ),
              ),
              onTap: () => _showMessage(
                'Pengaturan izin GPS perangkat belum diintegrasikan.',
              ),
            ),

            _buildSwitchCard(
              icon: Icons.visibility_off_outlined,
              title: 'Samarkan Identitas',
              description:
                  'Tampilkan sebagai Akun Anonim di feed umum',
              value: _anonymousIdentity,
              onChanged: (v) => setState(() => _anonymousIdentity = v),
            ),

            _buildSwitchCard(
              icon: Icons.fingerprint,
              title: 'Autentikasi Biometrik',
              description:
                  'Kunci aplikasi dengan Sidik Jari atau Face ID',
              value: _biometric,
              onChanged: (v) => setState(() => _biometric = v),
            ),

            _buildActionCard(
              icon: Icons.pin_outlined,
              title: 'Kata Sandi & PIN Darurat',
              description: 'Perbarui proteksi 6-digit akses cepat',
              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
                color: Color(0xFF64748B),
              ),
              onTap: _showPinDialog,
            ),

            const SizedBox(height: 20),

            _sectionTitle(
              Icons.tune,
              'PREFERENSI & APLIKASI',
            ),

            _buildActionCard(
              icon: Icons.language,
              title: 'Bahasa Aplikasi',
              description: 'Pilihan antarmuka percakapan',
              trailing: Text(
                '$_language  ›',
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF64748B),
                ),
              ),
              onTap: _showLanguageDialog,
            ),

            _buildThemeCard(),

            _buildActionCard(
              icon: Icons.map_outlined,
              title: 'Peta & Data Offline',
              description: 'Penyimpanan data offline aplikasi',
              trailing: TextButton(
                onPressed: _showClearDialog,
                child: const Text(
                  'Bersihkan',
                  style: TextStyle(fontSize: 9),
                ),
              ),
              onTap: () => _showMessage(
                'Pengelolaan peta offline belum diintegrasikan.',
              ),
            ),

            const SizedBox(height: 18),

            const Center(
              child: Text(
                'SIGAP Tanggap Bencana & Darurat Kota',
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF9B8790),
                ),
              ),
            ),

            const SizedBox(height: 5),

            const Center(
              child: Text(
                'Versi 1.0.0 • Prototype',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF9B8790),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Icon(
            icon,
            size: 13,
            color: const Color(0xFF3156B8),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263247),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchCard({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF1F1F5),
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFFFE4E6),
            child: Icon(
              icon,
              size: 16,
              color: const Color(0xFFBE0028),
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
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 8,
                    height: 1.4,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFBE0028),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF1F1F5),
              ),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFFE6E7FF),
                child: Icon(
                  icon,
                  size: 16,
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
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF172033),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF1F1F5),
          ),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE6E7FF),
            child: Icon(
              Icons.light_mode_outlined,
              size: 16,
              color: Color(0xFF3156B8),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mode Tampilan',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tema kontras tinggi terang',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          _themeOption('Terang', false),
          const SizedBox(width: 5),
          _themeOption('Gelap', true),
        ],
      ),
    );
  }

  Widget _themeOption(String label, bool dark) {
    final selected = _darkMode == dark;

    return InkWell(
      onTap: () {
        setState(() {
          _darkMode = dark;
        });
        _showMessage(
          'Pilihan tema $label dipilih. '
          'Penerapan tema seluruh aplikasi belum diintegrasikan.',
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFE4E6)
              : const Color(0xFFF1F2F8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: selected
                ? const Color(0xFFBE0028)
                : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}
