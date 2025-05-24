import 'dart:io';

import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login(String? email, String? password);
  Future<AuthUserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<void> logout();

  Future<String> resendAccountVerificationOtp(String email);

  Future<AuthUserModel> verifiyAccountEmail(
    String userAgent,
    String ip,
    String email,
    String otp,
  );

  // Future<UserOtpModel> forgotPassword(String email);

  // Future<UserOtpModel> resendForgotPasswordOtp(String email);

  // Future<UserOtpModel> verifyForgotPasswordOtp(String email, String otp);

  // Future<UserOtpModel> resetPassword(
  //   String email,
  //   String password,
  //   String passwordConfirmation,
  //   String token,
  // );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AuthUserModel> login(String? email, String? password) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        return AuthUserModel.fromJson(data);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data!['data'];
        return AuthUserModel.fromJson(data);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await apiService.get('/auth/logout');

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Logout failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> resendAccountVerificationOtp(String email) async {
    try {
      final response = await apiService.post(
        '/account/email/resend',
        data: {'email': email},
      );

      if (response.statusCode == HttpStatus.ok) {
        // Assuming the API returns a message or token as a string under 'message'
        return response.data!['message'] ?? 'OTP sent successfully';
      } else {
        throw Exception('Failed to resend OTP');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUserModel> verifiyAccountEmail(
    String userAgent,
    String ip,
    String email,
    String otp,
  ) async {
    try {
      final response = await apiService.post(
        '/account/email/verify',
        data: {'user_agent': userAgent, 'ip': ip, 'email': email, 'otp': otp},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        return AuthUserModel.fromJson(data);
      } else {
        throw Exception('Email verification failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<UserOtpModel> forgotPassword(String email) async {
  //   try {
  //     final response = await apiService.post(
  //       '/auth/forgot-password',
  //       data: {'email': email},
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final data = response.data!['data'];
  //       return UserOtpModel.fromJson(data);
  //     } else {
  //       throw Exception('Failed to send forgot password OTP');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<UserOtpModel> resendForgotPasswordOtp(String email) async {
  //   try {
  //     final response = await apiService.post(
  //       '/auth/verify-forgot-password-otp',
  //       data: {'email': email},
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final data = response.data!['data'];
  //       return UserOtpModel.fromJson(data);
  //     } else {
  //       throw Exception('Failed to resend forgot password OTP');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<UserOtpModel> verifyForgotPasswordOtp(String email, String otp) async {
  //   try {
  //     final response = await apiService.post(
  //       '/auth/verify-forgot-password-otp/verify',
  //       data: {'email': email, 'otp': otp},
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final data = response.data!['data'];
  //       return UserOtpModel.fromJson(data);
  //     } else {
  //       throw Exception('OTP verification failed');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<UserOtpModel> resetPassword(
  //   String email,
  //   String password,
  //   String passwordConfirmation,
  //   String token,
  // ) async {
  //   try {
  //     final response = await apiService.post(
  //       '/auth/reset-password',
  //       data: {
  //         'email': email,
  //         'password': password,
  //         'password_confirmation': passwordConfirmation,
  //         'token': token,
  //       },
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final data = response.data!['data'];
  //       return UserOtpModel.fromJson(data);
  //     } else {
  //       throw Exception('Password reset failed');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
