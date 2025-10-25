import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';

class PhoneOtpLoginPage extends StatefulWidget {
  static const path = '/phone-otp';
  const PhoneOtpLoginPage({super.key});

  @override
  State<PhoneOtpLoginPage> createState() => _PhoneOtpLoginPageState();
}

class _PhoneOtpLoginPageState extends State<PhoneOtpLoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  void _sendOtp() {
    // In a real app, you would send the phone number to a backend
    // to trigger OTP generation and sending.
    print('Sending OTP to ${_phoneController.text}');
    setState(() {
      _otpSent = true;
    });
    // For demonstration, we'll just simulate OTP sent.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP sent to your phone number.')),
    );
  }

  void _verifyOtp() {
    // In a real app, you would send the phone number and OTP to a backend
    // for verification.
    print(
      'Verifying OTP: ${_otpController.text} for phone: ${_phoneController.text}',
    );
    // For demonstration, just show a message.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP Verified! Logging in...')),
    );
    // Navigate to home screen or dashboard upon successful login
    context.go(HomeScreen.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decorations (similar to the Dribbble design)
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset(
          //     'assets/top_decoration.png', // Replace with your top decoration image
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset(
          //     'assets/bottom_decoration.png', // Replace with your bottom decoration image
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80), // Space for top decoration
                  Image.asset(
                    'assets/metrocery_logo.png', // Replace with your logo image
                    height: 80,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _otpSent ? 'Verify Your Account' : 'Sign in with Phone',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildPhoneInputField(),
                  if (_otpSent) ...[
                    const SizedBox(height: 20),
                    _buildOtpInputField(),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Resend OTP logic
                          print('Resending OTP');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Resending OTP...')),
                          );
                        },
                        child: const Text(
                          'Resend OTP?',
                          style: TextStyle(
                            color: Colours.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                  _buildActionButton(),
                  const SizedBox(height: 20),
                  // Text(
                  //   'Or sign in with',
                  //   style: TextStyle(color: Colors.grey[600]),
                  // ),
                  const SizedBox(height: 20),
                  // _buildSocialLoginButtons(),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _otpSent
                            ? 'Having trouble?'
                            : 'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to Sign Up page or support page
                          print(_otpSent ? 'Need help?' : 'Sign Up');
                        },
                        child: Text(
                          _otpSent ? 'Get Help' : 'Sign Up',
                          style: const TextStyle(
                            color: Colours.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50), // Space for bottom decoration
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneInputField() {
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
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Enter Your Phone Number',
          prefixIcon: const Icon(Icons.phone_android, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
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
        obscureText: false, // OTP is usually visible or just numbers
        decoration: InputDecoration(
          hintText: 'Enter OTP',
          prefixIcon: const Icon(Icons.vpn_key_outlined, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _otpSent ? _verifyOtp : _sendOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.primaryColor, // Background color
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: Text(
          _otpSent ? 'Verify & Login' : 'Send OTP',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('assets/google_logo.png', () {
          print('Google login tapped');
        }), // Replace with your Google logo
        const SizedBox(width: 20),
        _buildSocialButton('assets/facebook_logo.png', () {
          print('Facebook login tapped');
        }), // Replace with your Facebook logo (if needed)
      ],
    );
  }

  Widget _buildSocialButton(String imagePath, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(imagePath, height: 24),
      ),
    );
  }
}
