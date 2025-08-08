import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Login Page',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please accept Terms & Conditions")),
        );
        return;
      }

      String email = _emailCtrl.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logging in as $email")),
      );
    }
  }

  void _loginWithGoogle() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Google Sign-In coming soon...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(Icons.lock, size: 100, color: Colors.teal),
              SizedBox(height: 20),

              // Email
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val != null && val.contains('@')
                    ? null
                    : "Enter valid email",
              ),
              SizedBox(height: 20),

              // Password
              TextFormField(
                controller: _passCtrl,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (val) =>
                    val != null && val.length >= 6 ? null : "Min 6 characters",
              ),
              SizedBox(height: 20),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (val) => setState(() => _acceptTerms = val!),
                  ),
                  Flexible(child: Text("I accept the Terms and Conditions")),
                ],
              ),
              SizedBox(height: 10),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Text("Login", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: 20),

              // OR Divider
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),

              // Google Login Button (design only)
              OutlinedButton.icon(
                onPressed: _loginWithGoogle,
                icon: Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Login with Google",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey),
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
