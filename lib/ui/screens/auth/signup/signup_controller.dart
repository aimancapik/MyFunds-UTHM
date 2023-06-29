import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfundsuthm/ui/screens/auth/repository/authentication_repository.dart';


class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();


final username = TextEditingController();
final email = TextEditingController();
final password = TextEditingController();
final phoneNo = TextEditingController();



void registerUser (String email, String password){
AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
}
}