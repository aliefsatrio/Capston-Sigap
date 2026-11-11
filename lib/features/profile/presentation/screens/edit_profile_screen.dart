
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController =
      TextEditingController(text: 'Syifa Khaerunisa Nabila');

  final TextEditingController _teleponController =
      TextEditingController(text: '+62 812-3456-7890');

  final TextEditingController _emailController =
      TextEditingController(text: 'syifakhaerunisa@gmail.com');

  final TextEditingController _alamatController =
      TextEditingController(
    text: 'Jl. Pemuda No. 42, Kel. Mintaragen, Kec. Tegal Timur, Kota Tegal',
  );

  DateTime _tanggalLahir = DateTime(2006, 3, 11);
  String _jenisKelamin = 'Wanita';

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  String get tanggalFormatted {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${_tanggalLahir.day} '
        '${bulan[_tanggalLahir.month - 1]} '
        '${_tanggalLahir.year}';
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFBE0028),
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (hasil != null) {
      setState(() {
        _tanggalLahir = hasil;
      });
    }
  }

  void _simpanPerubahan() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perubahan profil berhasil disimpan.'),
        backgroundColor: Color(0xFFBE0028),
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
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF172033),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profil',
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            children: [
              // Informasi identitas
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E7FF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data Identitas Sipil',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF172033),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sinkron dengan sistem respon darurat SIGAP 112',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFFD9DDFB),
                      child: Icon(
                        Icons.verified_user_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Foto profil
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE1E5F2),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 55,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xFFBE0028),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 15,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Fitur ganti foto akan diintegrasikan.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text(
                'Syifa Khaerunisa Nabila',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'NIK: 3328********0004',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 18),

              // Form nama
              _buildTextField(
                title: 'Nama Lengkap (Sesuai KTP)',
                icon: Icons.person_outline,
                controller: _namaController,
              ),

              // Nomor telepon
              _buildTextField(
                title: 'Nomor Handphone (WhatsApp)',
                icon: Icons.phone_outlined,
                controller: _teleponController,
                keyboardType: TextInputType.phone,
                suffix: const Icon(
                  Icons.verified,
                  size: 14,
                  color: Color(0xFF6478C8),
                ),
              ),

              // Email
              _buildTextField(
                title: 'Alamat Email',
                icon: Icons.mail_outline,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              // Tanggal lahir
              _buildDateField(),

              // Jenis kelamin
              _buildGenderField(),

              // Alamat
              _buildTextField(
                title: 'Alamat KTP & Domisili Utama',
                icon: Icons.location_on_outlined,
                controller: _alamatController,
                maxLines: 3,
              ),

              const SizedBox(height: 8),

              // Tombol simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _simpanPerubahan,
                  icon: const Icon(
                    Icons.save_outlined,
                    size: 17,
                  ),
                  label: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE0028),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Perubahan data terenkripsi dan sesuai standar '
                'Pusdatin Kemenkes & SIGAP.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF8A7D83),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk input data
  Widget _buildTextField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Widget? suffix,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 12,
                color: const Color(0xFFBE0028),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF263247),
                  ),
                ),
              ),
              if (suffix != null) suffix,
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF263247),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Bagian ini wajib diisi';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF0F0FF),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: Color(0xFFBE0028),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget tanggal lahir
  Widget _buildDateField() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 12,
                color: Color(0xFFBE0028),
              ),
              SizedBox(width: 5),
              Text(
                'Tanggal Lahir',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263247),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pilihTanggal,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0FF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tanggalFormatted,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF263247),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 16,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pilihan jenis kelamin
  Widget _buildGenderField() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.people_outline,
                size: 12,
                color: Color(0xFFBE0028),
              ),
              SizedBox(width: 5),
              Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263247),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _genderOption('Pria'),
              const SizedBox(width: 8),
              _genderOption('Wanita'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderOption(String value) {
    final selected = _jenisKelamin == value;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _jenisKelamin = value;
          });
        },
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFFFDCDD)
                : const Color(0xFFF0F0FF),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected)
                const Icon(
                  Icons.check,
                  size: 12,
                  color: Color(0xFFBE0028),
                ),
              if (selected) const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? const Color(0xFFBE0028)
                      : const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
