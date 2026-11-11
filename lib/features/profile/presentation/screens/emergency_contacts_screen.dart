
import 'package:flutter/material.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState
    extends State<EmergencyContactsScreen> {
  final List<Map<String, String>> _contacts = [
    {
      'name': 'Ibu (Siti Rahmawati)',
      'relation': 'Ibu Kandung',
      'phone': '+62 812-3456-7890',
    },
    {
      'name': 'Budi Santoso',
      'relation': 'Suami / Saudara',
      'phone': '+62 857-1122-3344',
    },
    {
      'name': 'Ketua RT 04 (Pak Joko)',
      'relation': 'Tokoh Lingkungan',
      'phone': '+62 813-9876-5432',
    },
  ];

  bool _smsEnabled = true;
  bool _trackingEnabled = true;

  void _showContactForm({int? index}) {
    final isEditing = index != null;
    final contact = isEditing ? _contacts[index] : null;

    final nameController = TextEditingController(
      text: contact?['name'] ?? '',
    );
    final relationController = TextEditingController(
      text: contact?['relation'] ?? '',
    );
    final phoneController = TextEditingController(
      text: contact?['phone'] ?? '',
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            isEditing ? 'Edit Kontak' : 'Tambah Kontak Darurat',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogInput(nameController, 'Nama Kontak'),
                const SizedBox(height: 12),
                _dialogInput(relationController, 'Hubungan'),
                const SizedBox(height: 12),
                _dialogInput(
                  phoneController,
                  'Nomor Telepon',
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
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
                if (nameController.text.trim().isEmpty ||
                    phoneController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  final newContact = {
                    'name': nameController.text.trim(),
                    'relation': relationController.text.trim(),
                    'phone': phoneController.text.trim(),
                  };

                  if (isEditing) {
                    _contacts[index] = newContact;
                  } else {
                    _contacts.add(newContact);
                  }
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEditing
                          ? 'Kontak berhasil diperbarui.'
                          : 'Kontak berhasil ditambahkan.',
                    ),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogInput(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF0F0FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _showCallInfo(String phone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hubungi Kontak'),
        content: Text('Nomor kontak darurat: $phone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
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
          'Kontak Darurat',
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
            // Protokol keamanan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDCDC),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFFBE0028),
                    child: Icon(
                      Icons.shield,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Protokol Keamanan Aktif',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFBE0028),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Kontak terpilih akan menerima notifikasi '
                          'saat keadaan darurat. Fitur otomatisasi '
                          'memerlukan integrasi layanan.',
                          style: TextStyle(
                            fontSize: 9,
                            height: 1.5,
                            color: Color(0xFF79545B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Judul daftar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kontak Terdaftar',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                Text(
                  '${_contacts.length}/5 Terisi',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Daftar kontak
            ...List.generate(_contacts.length, (index) {
              final contact = _contacts[index];

              return _buildContactCard(contact, index);
            }),

            const SizedBox(height: 8),

            // Tambah kontak
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton.icon(
                onPressed: _contacts.length >= 5
                    ? null
                    : () => _showContactForm(),
                icon: const Icon(
                  Icons.person_add_alt_1,
                  size: 17,
                ),
                label: const Text(
                  'Tambah Kontak Darurat Baru',
                  style: TextStyle(fontSize: 11),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFBE0028),
                  backgroundColor: const Color(0xFFECEBFF),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Otomatisasi & Integrasi Sinyal',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 10),

            _buildAutomationCard(
              icon: Icons.message_outlined,
              title: 'SMS Siaga Otomatis',
              description:
                  'Kirim teks darurat serentak ke semua kontak '
                  'aktif saat tombol SOS ditekan.',
              value: _smsEnabled,
              onChanged: (value) {
                setState(() => _smsEnabled = value);
              },
            ),

            const SizedBox(height: 10),

            _buildAutomationCard(
              icon: Icons.near_me_outlined,
              title: 'Live Tracking Lokasi (1 Jam)',
              description:
                  'Bagikan tautan pelacakan real-time selama '
                  '60 menit pasca aktivasi.',
              value: _trackingEnabled,
              onChanged: (value) {
                setState(() => _trackingEnabled = value);
              },
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFECEBFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 15,
                    color: Color(0xFF3156B8),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Data kontak pada prototype ini dikelola '
                      'sementara di dalam aplikasi.',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF53617C),
                      ),
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

  Widget _buildContactCard(
    Map<String, String> contact,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: index == 0
                ? const Color(0xFFBE0028)
                : const Color(0xFFE5E7EB),
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE6E7FF),
            child: Text(
              contact['name']!.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Color(0xFFBE0028),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name']!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact['relation']!,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact['phone']!,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF3156B8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Hubungi',
            onPressed: () => _showCallInfo(contact['phone']!),
            icon: const Icon(
              Icons.call,
              size: 18,
              color: Color(0xFF3156B8),
            ),
          ),
          IconButton(
            tooltip: 'Edit kontak',
            onPressed: () => _showContactForm(index: index),
            icon: const Icon(
              Icons.edit_outlined,
              size: 18,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationCard({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xFFE6E7FF),
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 9,
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
}
