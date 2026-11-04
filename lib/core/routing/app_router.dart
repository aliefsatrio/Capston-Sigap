import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/location/presentation/screens/gps_activation_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/sos/presentation/screens/sos_screen.dart';
import '../../features/location/presentation/screens/emergency_services_screen.dart';
import '../../features/report/presentation/screens/camera_screen.dart';
import '../../features/report/presentation/screens/description_screen.dart';
import '../../features/report/presentation/screens/report_success_screen.dart';
import '../../features/community/presentation/screens/community_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/first_aid/presentation/screens/first_aid_screen.dart';
import '../../features/gallery/presentation/screens/gallery_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(path: '/gallery', builder: (ctx, state) => const GalleryScreen()),
      GoRoute(path: '/onboarding', builder: (ctx, state) => const OnboardingScreen()),
      GoRoute(path: '/register', builder: (ctx, state) => const RegisterScreen()),
      GoRoute(path: '/login', builder: (ctx, state) => const LoginScreen()),
      GoRoute(path: '/otp', builder: (ctx, state) => const OtpScreen()),
      GoRoute(path: '/gps-activation', builder: (ctx, state) => const GpsActivationScreen()),
      GoRoute(path: '/home', builder: (ctx, state) => const HomeScreen()),
      GoRoute(path: '/sos', builder: (ctx, state) => const SosScreen()),
      GoRoute(path: '/emergency-services', builder: (ctx, state) => const EmergencyServicesScreen()),
      GoRoute(path: '/camera', builder: (ctx, state) => const CameraScreen()),
      GoRoute(path: '/description', builder: (ctx, state) => const DescriptionScreen()),
      GoRoute(path: '/report-success', builder: (ctx, state) => const ReportSuccessScreen()),
      GoRoute(path: '/community', builder: (ctx, state) => const CommunityScreen()),
      GoRoute(path: '/history', builder: (ctx, state) => const HistoryScreen()),
      GoRoute(path: '/profile', builder: (ctx, state) => const ProfileScreen()),
      GoRoute(path: '/first-aid', builder: (ctx, state) => const FirstAidScreen()),
    ],
  );
});
