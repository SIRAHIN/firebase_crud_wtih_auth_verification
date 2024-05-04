import 'package:firebaseall_in_one/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOTP extends StatelessWidget {
   VerifyOTP({super.key});

   TextEditingController otpController = TextEditingController();
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
                  controller: otpController,
                  decoration: const InputDecoration(
                  counterText: '',
                  labelText: '6 - digit otp'),
                  keyboardType: TextInputType.number,
                 
                  maxLength: 6,
                  
                ),
        
                 ElevatedButton(
                  onPressed: () {
                  authController.verifyOTP(otpCode: otpController.text.trim());
                  },
                  child: const Text('Send OTP'),
                ),
          ],
        ),
      ),
    );
  }
}