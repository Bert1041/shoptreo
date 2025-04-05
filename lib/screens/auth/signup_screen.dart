import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/config/mixin/validation_mixin.dart';
import 'package:shoptreo/config/routes/app_routes.dart';
import 'package:shoptreo/core/providers/auth_provider.dart';
import 'package:shoptreo/shared/widgets/app_loader.dart';
import 'package:shoptreo/shared/widgets/reusable_app_button.dart';
import 'package:shoptreo/shared/widgets/reusable_app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with FormValidationMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _agreedToTerms = false;
  bool _isLoading = false;

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _selectedCountry = 'Nigeria';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must agree to the terms and privacy policy.'),
        ),
      );
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signup(_email, _password, '$_firstName $_lastName');

    setState(() => _isLoading = false);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.bottomNav,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.white, AppColors.secondary],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontFamily: 'Filson Pro',
                        fontSize: 32.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Welcome to Shoptreo",
                      style: TextStyle(
                        fontFamily: 'Filson Pro',
                        fontSize: 17.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                Spacer(flex: 1),
                // Fields
                Expanded(
                  flex: 4,
                  child: ListView(
                    children: [
                      AppDropdownField<String>(
                        label: 'Select Country',
                        value: _selectedCountry,
                        items:
                            ['Nigeria', 'Ghana', 'Kenya', 'South Africa']
                                .map(
                                  (country) => DropdownMenuItem(
                                    value: country,
                                    child: Text(country),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        onSaved: (val) => _email = val!.trim(),
                        suffixIcon: Icon(Icons.email_outlined),
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        label: 'Password',
                        obscureText: _obscure,
                        validator: validatePassword,
                        onSaved: (val) => _password = val!.trim(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'First Name',
                        validator:
                            (val) =>
                                val == null || val.trim().isEmpty
                                    ? 'First name is required'
                                    : null,
                        onSaved: (val) => _firstName = val ?? '',
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Last Name',
                        validator:
                            (val) =>
                                val == null || val.trim().isEmpty
                                    ? 'Last name is required'
                                    : null,
                        onSaved: (val) => _lastName = val ?? '',
                      ),
                    ],
                  ),
                ),

                // Terms and Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 0.6,
                          child: Switch(
                            value: _agreedToTerms,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              setState(() {
                                _agreedToTerms = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Filson Pro',
                                fontSize: 12.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                const TextSpan(text: 'I agree to Shoptreo '),
                                TextSpan(
                                  text: 'Terms',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          // TODO: Navigate to Terms screen
                                        },
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          // TODO: Navigate to Privacy Policy screen
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _isLoading
                        ? AppLoader()
                        : AppButton(
                          label: 'Next',
                          isPrimary: false,
                          outlineBackgroundColor: AppColors.white,
                          outlineButtonColor: AppColors.primary,
                          onPressed: _agreedToTerms ? () => _submit() : () {},
                          margin: 0,
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
}
