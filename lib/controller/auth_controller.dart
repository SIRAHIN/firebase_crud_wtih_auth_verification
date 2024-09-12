import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseall_in_one/pages/login_page.dart';
import 'package:firebaseall_in_one/pages/screens/verify_otp.dart';
import 'package:get/get.dart';

import '../pages/screens/home_page.dart';

class AuthController extends GetxController {

  String verificationId_ = '';
  UserCredential? credential;

  //Creating account using email password varification
  void createAccount(String email, String password, String cPassword) async {
    if (email == '' || password == '' || cPassword == '') {
      Get.snackbar("REQUIRED", "required field is emply");
    } else if (password != cPassword) {
      Get.snackbar("INVALID", "password is not same");
    } else {
      try {
         credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.trim(), password: password);         
        Get.to(LoginPage());
      } on FirebaseAuthException catch (ex) {
        Get.snackbar("Exception", ex.code.toString());
      }
    }
  }

  //Function for login via email and password
  void loginWithEimailAndPassword (String email, String password) async{

   if(email == '' || password == ''){
    Get.snackbar("REQUIRED", "Requied field is empty");
   }else {
    try{
        credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.off(HomePage());
         }on FirebaseAuthException catch (ex){
     Get.snackbar("EXCEPTON", ex.code.toString());
    }
   }

  
  }

  //Signout funciton
  void signOut () async {
   await FirebaseAuth.instance.signOut();
   Get.off(LoginPage());
  }

  //Signing with phoneNumber
  void sendOTP(String pNumber) async{
    String phoneNumber = "+880${pNumber.trim()}";
    await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (phoneAuthCredential) {
      
    }, 
    verificationFailed: (error) {
      Get.snackbar("OTP Failed", error.code.toString());
    }, 
    codeSent: (verificationId, forceResendingToken) {
      verificationId_ = verificationId;
      Get.off(VerifyOTP());
    }, 
    codeAutoRetrievalTimeout: (verificationId) {

    },
    timeout: const Duration(seconds: 15)
    );
    
  }

  //verifing OTP 
  void verifyOTP ({required String otpCode}) async{
  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId_, smsCode: otpCode);
  try{
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    if(userCredential.user != null){
     Get.offAll(HomePage());
    }
  } on FirebaseAuthException {
    Get.snackbar("OTP - Error", "Invalid Code");
  }
  } 
}
