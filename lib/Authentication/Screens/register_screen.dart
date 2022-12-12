import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Provider/auth_provider.dart';
import 'Login_Screen.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Name'),
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                validator: (value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    return "Please enter your email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Email'),
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _password,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Please enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  label: const Text('Password'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.remove_red_eye),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    Provider.of<AuthProvider>(context,listen: false).register(email: _email.text, password: _password.text,name: _name.text);

                  }
                },
                child: const Text('Sign Up', style: TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: const Text('Login'),
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
