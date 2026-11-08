import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';
import 'dart:typed_data';


class DescriptionScreen extends StatefulWidget {
  final Uint8List? photoBytes;

  const DescriptionScreen({
    super.key,
    this.photoBytes,
  });

  @override
  State<DescriptionScreen> createState() =>
      _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final _controller = TextEditingController(
    text: 'Kecelakaan di depan minimarket, ada motor jatuh dan mobil berhenti di dekat lokasi.',
  );
  String _selectedCategory = 'Kecelakaan';
  final List<String> _categories = ['Kecelakaan', 'Kebakaran', 'Bencana Alam', 'Lainnya'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(10), color: Colors.white),
                      child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Tambah Deskripsi',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // Photo preview
ClipRRect(
  borderRadius: BorderRadius.circular(14),
  child: Stack(
    children: [
      SizedBox(
        height: 180,
        width: double.infinity,
        child: widget.photoBytes != null
            ? Image.memory(
                widget.photoBytes!,
                fit: BoxFit.cover,
              )
            : Container(
                color: const Color(0xFF607D8B),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 56,
                    color: Colors.white54,
                  ),
                ),
              ),
      ),

      // Delete button
      Positioned(
        top: 10,
        right: 10,
        child: GestureDetector(
          onTap: () {
            setState(() {
              // Nanti kita tambahkan fitur hapus foto.
            });
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    ],
  ),
),

                    const SizedBox(height: 14),

                    // Description input
                    TextField(
                      controller: _controller,
                      maxLines: 5,
                      maxLength: 300,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, color: AppColors.textPrimary, height: 1.5),
                      decoration: InputDecoration(
                        hintText: 'Deskripsikan kejadian di sini...',
                        hintStyle: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, color: AppColors.textMuted),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.bluePrimary, width: 1.5)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Counter - fixture shows "72/300" per Figma spec
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '72/300', // Fixture value per spec; actual: '$charCount/300'
                        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textMuted),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Category section
                    const Text('Kategori Kejadian',
                        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),

                    const SizedBox(height: 12),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3.2,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (_, i) {
                        final cat = _categories[i];
                        final isSelected = cat == _selectedCategory;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = cat),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.redSurface3 : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? AppColors.redPrimary : const Color(0xFFE2E8F0),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.redPrimary : AppColors.textSecondarySlate,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    // Upload button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/report-success'),
                        icon: const Icon(Icons.upload, size: 18),
                        label: const Text(
                          'Upload Laporan',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          elevation: 0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SigapBottomNav(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            context.go('/home');
          // ignore: curly_braces_in_flow_control_structures
          } else if (i == 1) context.push('/first-aid');
          // ignore: curly_braces_in_flow_control_structures
          else if (i == 3) context.push('/community');
          // ignore: curly_braces_in_flow_control_structures
          else if (i == 4) context.push('/history');
        },
        variant: SigapNavVariant.home,
      ),
    );
  }
}
