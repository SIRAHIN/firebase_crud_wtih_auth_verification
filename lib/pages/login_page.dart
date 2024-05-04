import 'package:firebaseall_in_one/controller/auth_controller.dart';
import 'package:firebaseall_in_one/pages/screens/phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SignupPage.dart';

class LoginPage extends StatelessWidget {

  
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   

  final authController = Get.put(AuthController());

  LoginPage({super.key});  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                authController.loginWithEimailAndPassword(_emailController.text, _passwordController.text);
                
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20.0),
              const Text('Or'),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the signup page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Create an Account'),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton.icon(
                onPressed: () {
                Get.to(PhoneNumberScreen());
                },
                icon: const Icon(Icons.phone),
                label: const Text('Login with Phone'),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Login with Google'),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.facebook),
                label: const Text('Login with Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}