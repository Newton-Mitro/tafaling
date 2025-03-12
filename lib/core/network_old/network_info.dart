import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

class NetworkService {
  Future<bool> get isConnected async {
    bool isWeb = identical(0, 0.0); // Check if running on the web
    if (isWeb) {
      // Handle web case, return true or false based on your logic
      return true; // or implement your web-specific check
    } else {
      return await DataConnectionChecker().hasConnection;
    }
  }

  Stream<DataConnectionStatus> get statusStream {
    bool isWeb = identical(0, 0.0); // Check if running on the web
    if (isWeb) {
      // Provide a fallback or alternative implementation for web
      // For example, using a simple timer or polling mechanism
      return Stream.value(DataConnectionStatus.connected); // Fallback
    } else {
      return DataConnectionChecker().onStatusChange;
    }
  }
}
