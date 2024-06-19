import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/registeration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrMobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailOrMobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logging in...')),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  String? _validateEmailOrMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or mobile number';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (emailRegex.hasMatch(value)) {
      return null;
    }

    final mobileRegex = RegExp(r'^\d{10}$');
    if (mobileRegex.hasMatch(value)) {
      return null;
    }

    return 'Please enter a valid email or 10-digit mobile number';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailOrMobileController,
                decoration: InputDecoration(
                  labelText: 'Email or Mobile',
                ),
                validator: _validateEmailOrMobile,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot password ?")],
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? "),
                  GestureDetector(
                    onTap: _navigateToRegister,
                    child: Text(
                      "Register here",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
