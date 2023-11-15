import 'package:flutter/material.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/network_caller/network_response.dart';
import 'package:task_manager_project/data/utility/urls.dart';
import 'package:task_manager_project/ui/widgets/body_background.dart';
import 'package:task_manager_project/ui/widgets/snack_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Visibility(
                    visible: _signUpInProgress = true,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 45,
                        ),
                        Text(
                          'Join With Us',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: _emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your email address';
                            } else {
                              final RegExp emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[a-zA-Z]{2,})+$');
                              if (!emailRegex.hasMatch(value!)) {
                                return 'Enter a valid email address';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _firstNameTEController,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your First Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _lastNameTEController,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter your Last Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _mobileTEController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isNotEmpty ?? true) {
                              final RegExp mobileRegex = RegExp(r'^\d{11}$');
                              if (!mobileRegex.hasMatch(value!)) {
                                return 'Enter a valid 11-digit Mobile number';
                              }
                            } else {
                              return 'Enter your Mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _passwordTEController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Password';
                            }
                            if (value!.length < 6) {
                              return 'Enter password more than 6 letters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _signUp(),
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
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
                                Navigator.pop(context);
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
        ),
      ),
    );
  }

  Future<void> _signUp() async {
                              if (_formKey.currentState!.validate()) {
                                _signUpInProgress = true;
                                if (mounted) {
                                  setState(() {});
                                }
                                final NetworkResponse response =
                                    await NetworkCaller().postRequest(
                                  Urls.registration,
                                  body: {
                                    "email": _emailTEController.text.trim(),
                                    "firstName":
                                        _firstNameTEController.text.trim(),
                                    "lastName":
                                        _lastNameTEController.text.trim(),
                                    "mobile": _mobileTEController.text.trim(),
                                    "password": _passwordTEController.text,
                                    "photo": "",
                                  },
                                );
                                if (mounted) {
                                  _signUpInProgress = false;
                                  setState(() {});
                                }
                                if (mounted) {
                                  if (response.isSuccess) {
                                    _clearTextFields();
                                    showSnackMessage(context,
                                        'Account has been created! Please login.');
                                  } else {
                                    showSnackMessage(
                                        context,
                                        'Account creating failed! Please try again.',
                                        true);
                                  }
                                }
                              }
                            }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
