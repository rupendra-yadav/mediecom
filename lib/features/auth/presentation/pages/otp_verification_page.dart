import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/common/app/cache_helper.dart';
import 'package:mediecom/core/common/widgets/full_screen_loader.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/auth/presentation/auth_injection.dart';
import 'package:mediecom/features/auth/presentation/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';

class OtpVerificationPage extends StatefulWidget {
  static const path = '/otp-verification';
  final String phoneNumber;
  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();

  void _verifyOtp() {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colours.accentCoral,
          content: Text('Please enter OTP'),
        ),
      );
      return;
    }

    // Here you can call your Bloc or API for OTP verification
    print('Verifying OTP: $otp for phone: ${widget.phoneNumber}');

    // Trigger Bloc event
    context.read<VerifyOtpBloc>().add(
      MobileVerifyOtpEvent(
        otp: _otpController.text.trim(),
        userId: widget.phoneNumber,
      ),
    );
  }

  void _resendOtp() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Resending OTP...')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<VerifyOtpBloc, VerifyOtpState>(
          listener: (context, state) {
            if (state is VerifyOtpLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const FullScreenLoader(),
              );
            } else if (state is VerifyOtpError) {
              Navigator.of(context, rootNavigator: true).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: AppTextStyles.karala14w800.white,
                  ),
                  backgroundColor: Colours.error,
                ),
              );
            } else if (state is VerifyOtpSuccess) {
              log(state.user.toString());
              final cacheHelper = sl<CacheHelper>();
              cacheHelper.setIsLoggedIn(true);
              // appLog("${cacheHelper.isLoggedIn()}");
              context.push(HomeScreen.path);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colours.success,
                  content: Text('OTP Verified! Logging in...'),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset('assets/images/img_phone.png', height: 80),
                const SizedBox(height: 40),
                const Text(
                  'Verify Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'OTP sent to ${widget.phoneNumber}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                _buildOtpInputField(),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _resendOtp,
                    child: const Text(
                      'Resend OTP?',
                      style: TextStyle(
                        color: Colours.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildVerifyButton(),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Having trouble?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () => print('Get Help'),
                      child: const Text(
                        'Get Help',
                        style: TextStyle(
                          color: Colours.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Enter OTP',
          prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _verifyOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: const Text(
          'Verify & Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
