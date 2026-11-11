
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;

  bool _isLoading = true;
  bool _isTakingPicture = false;
  bool _isGettingLocation = true;

  String? _errorMessage;
  String? _locationError;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getCurrentLocation();
  }

  // Mengambil lokasi GPS terkini.
  Future<void> _getCurrentLocation() async {
    if (mounted) {
      setState(() {
        _isGettingLocation = true;
        _locationError = null;
      });
    }

    try {
      bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Layanan lokasi belum aktif.');
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('Izin lokasi ditolak.');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Izin lokasi ditolak permanen. Aktifkan melalui pengaturan perangkat.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      if (!mounted) return;

      setState(() {
        _currentPosition = position;
        _isGettingLocation = false;
        _locationError = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isGettingLocation = false;
        _locationError = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  // Mengaktifkan kamera.
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('Kamera tidak ditemukan.');
      }

      final camera = cameras.first;

      final controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _cameraController = controller;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'Tidak dapat membuka kamera: $e';
      });
    }
  }

  // Mengambil foto sekaligus mengirimkan koordinat GPS.
  Future<void> _takePicture() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isTakingPicture) {
      return;
    }

    try {
      setState(() => _isTakingPicture = true);

      // Pastikan GPS tersedia sebelum foto diambil.
      if (_currentPosition == null) {
        await _getCurrentLocation();
      }

      if (!mounted) return;

      if (_currentPosition == null) {
        setState(() => _isTakingPicture = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _locationError ?? 'Lokasi GPS belum tersedia.',
            ),
            action: SnackBarAction(
              label: 'Coba Lagi',
              onPressed: _getCurrentLocation,
            ),
          ),
        );
        return;
      }

      final XFile photo =
          await _cameraController!.takePicture();

      final photoBytes = await photo.readAsBytes();

      // Simpan koordinat GPS.
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;
      final accuracy = _currentPosition!.accuracy;

      // Lepaskan kamera sebelum berpindah halaman.
      await _cameraController!.dispose();
      _cameraController = null;

      if (!mounted) return;

      await context.push(
        '/description',
        extra: {
          'photoBytes': photoBytes,
          'latitude': latitude,
          'longitude': longitude,
          'accuracy': accuracy,
        },
      );

      // Aktifkan kembali kamera ketika kembali.
      if (mounted) {
        setState(() => _isTakingPicture = false);
        await _initializeCamera();
        await _getCurrentLocation();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() => _isTakingPicture = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil foto: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Lapor Kejadian',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Camera preview
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF263445),
                  borderRadius: BorderRadius.circular(22),
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildCameraPreview(),
              ),
            ),

            // Tombol ambil foto
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 24,
              ),
              child: GestureDetector(
                onTap: _isTakingPicture ? null : _takePicture,
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(
                      color: Colors.red.shade100,
                      width: 8,
                    ),
                  ),
                  child: _isTakingPicture
                      ? const Padding(
                          padding: EdgeInsets.all(18),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 28,
                        ),
                ),
              ),
            ),

            const Text(
              'Tekan tombol untuk mengambil foto kejadian',
              style: TextStyle(
                color: AppColors.textSecondarySlate,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SigapBottomNav(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            context.go('/home');
          } else if (i == 1) {
            context.push('/first-aid');
          } else if (i == 3) {
            context.push('/community');
          } else if (i == 4) {
            context.push('/history');
          }
        },
        variant: SigapNavVariant.home,
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    if (_cameraController == null) {
      return const Center(
        child: Text(
          'Kamera belum tersedia',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_cameraController!),

        // Frame scan.
        Center(
          child: Container(
            width: 230,
            height: 230,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),

        // Status kamera.
        const Positioned(
          top: 16,
          left: 16,
          child: Text(
            '● LIVE CAMERA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Informasi GPS.
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.70),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _isGettingLocation
                      ? const Text(
                          'Mengambil lokasi GPS...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                      : _currentPosition != null
                          ? Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Lokasi GPS Terkini',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_currentPosition!.latitude.toStringAsFixed(6)}, '
                                  '${_currentPosition!.longitude.toStringAsFixed(6)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Akurasi ±${_currentPosition!.accuracy.toStringAsFixed(1)} meter',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              _locationError ?? 'Lokasi belum tersedia',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                ),
                if (!_isGettingLocation && _currentPosition == null)
                  IconButton(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    tooltip: 'Coba GPS lagi',
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
