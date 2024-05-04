import 'package:firebaseall_in_one/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberScreen extends StatelessWidget {
   PhoneNumberScreen({super.key});

   TextEditingController phoneController = TextEditingController();
   final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number,
                ),
        
                 ElevatedButton(
                  onPressed: () {
                  authController.sendOTP(phoneController.text);
                    
                  },
                  child: const Text('Send OTP'),
                ),
          ],
        ),
      ),
    );
  }
}