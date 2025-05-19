import 'package:tafaling/features/onboarding/injection.dart';

import 'core/injection.dart';
import 'features/auth/injection.dart';
import 'features/post/injection.dart';
import 'features/user/injection.dart';

Future<void> setupDependencies() async {
  await registerCoreServices(); // Core services
  registerOnboardingModule(); // Onboarding module
  registerAuthModule(); // Auth module
  registerPostModule(); // Post module
  registerUserModule(); // User module
}
