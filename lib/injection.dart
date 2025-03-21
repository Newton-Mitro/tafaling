import 'core/injection.dart';
import 'features/auth/injection.dart';
import 'features/post/injection.dart';
import 'features/user/injection.dart';

Future<void> setupDependencies() async {
  await registerCoreServices(); // Core services
  registerAuthModule(); // Auth module
  registerPostModule(); // Post module
  registerUserModule(); // User module
}
