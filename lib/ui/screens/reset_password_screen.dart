import 'package:flutter/material.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/network_caller/network_response.dart';
import 'package:task_manager_project/data/utility/urls.dart';
import 'package:task_manager_project/ui/screens/login_screen.dart';
import 'package:task_manager_project/ui/widgets/body_background.dart';
import 'package:task_manager_project/ui/widgets/snack_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _resetPasswordVerificationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Minimum length passwod 8 character with',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const Text(
                      'Latter and number combination',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter New Password!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Confirm New Password!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _resetPasswordVerificationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: resetPasswordVerification,
                          child: const Text('Confirm'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 16,
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
        ),
      ),
    );
  }

  Future<void> resetPasswordVerification() async {
    if(!_formKey.currentState!.validate()){
      return;
    }

    if (_passwordTEController.text.isNotEmpty &&
        _passwordTEController.text == _confirmPasswordTEController.text &&
        _passwordTEController.text.length >= 6) {
      _resetPasswordVerificationInProgress = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response = await NetworkCaller().postRequest(
        Urls.resetPassword,
        body: {
          'email': widget.email,
          'OTP': widget.otp,
          'password': _passwordTEController.text,
        },
      );
      _resetPasswordVerificationInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        if (mounted) {
          showSnackMessage(context, 'Reset Password Successful!!');
        }
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      } else {
        if (response.statusCode == 401) {
          if (mounted) {
            showSnackMessage(context, 'Please check password', true);
          }
        } else {
          if (mounted) {
            showSnackMessage(
                context, 'Password Reset failed. Try Again!', true);
          }
        }
      }
    } else {
      if (mounted) {
        showSnackMessage(context,
            'Passwords Does Not Match or less than 6 digit! Try Again!!', true);
      }
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
