import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'dashboard.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _agree = false;
  bool _termsViewed = false;
  bool _obscure = true;
  bool _loading = false;

  String? _nameError;
  String? _usernameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms and Conditions', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const SingleChildScrollView(
            child: Text(
              'By signing up you agree to our terms and conditions. Use responsibly and help promote sustainability.',
              style: TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _termsViewed = true;
                });
              },
              child: const Text('I Understand'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignUp() async {
    setState(() {
      _loading = true;
      _nameError = null;
      _usernameError = null;
      _phoneError = null;
      _emailError = null;
      _passwordError = null;
    });

    final name = _nameCtrl.text.trim();
    final username = _usernameCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    bool hasError = false;

    if (name.isEmpty) {
      _nameError = 'Full name is required';
      hasError = true;
    }

    if (username.isEmpty) {
      _usernameError = 'Username is required';
      hasError = true;
    }

    if (phone.isEmpty) {
      _phoneError = 'Phone number is required';
      hasError = true;
    } else if (!RegExp(r'^\+?\d{9,15}$').hasMatch(phone)) {
      _phoneError = 'Enter a valid phone number';
      hasError = true;
    }

    if (email.isEmpty) {
      _emailError = 'Email is required';
      hasError = true;
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+').hasMatch(email)) {
      _emailError = 'Invalid email address';
      hasError = true;
    }

    if (password.isEmpty) {
      _passwordError = 'Password is required';
      hasError = true;
    } else if (password.length < 6) {
      _passwordError = 'At least 6 characters';
      hasError = true;
    }

    if (!_termsViewed) {
      _showError('Please view the terms first.');
      setState(() => _loading = false);
      return;
    }

    if (!_agree) {
      _showError('You must agree to the terms.');
      setState(() => _loading = false);
      return;
    }

    if (hasError) {
      setState(() => _loading = false);
      return;
    }

    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      Navigator.of(context).pushReplacementNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      setState(() => _loading = false);
      String message = 'Sign up failed';
      if (e.code == 'email-already-in-use') {
        message = 'Email already exists';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      } else if (e.code == 'weak-password') {
        message = 'Password too weak';
      }
      _showError(message);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const inputFill = Color(0xFFE8F4EC);
    const primaryGreen = Color(0xFF7CF4A4);
    const navyText = Color(0xFF0A244E);
    const linkText = Color(0xFF7CA78C);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        filled: true,
                        fillColor: inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorText: _nameError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameCtrl,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        filled: true,
                        fillColor: inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorText: _usernameError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        filled: true,
                        fillColor: inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorText: _phoneError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        filled: true,
                        fillColor: inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorText: _emailError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                        errorText: _passwordError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _agree,
                          onChanged: _termsViewed ? (v) => setState(() => _agree = v!) : null,
                          activeColor: primaryGreen,
                        ),
                        GestureDetector(
                          onTap: _showTermsAndConditions,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'I agree with the ',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                TextSpan(
                                  text: 'terms and conditions',
                                  style: TextStyle(
                                    color: linkText,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: const StadiumBorder(),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: navyText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
                      child: Text(
                        'Already have an account? Log in',
                        style: TextStyle(color: linkText),
                      ),
                    ),
                  ],
                ),
              ),
              if (_loading)
                Container(
                  color: Colors.black.withOpacity(0.1),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
