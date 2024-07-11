library user_repository;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_model.dart';

export 'src/entities/entities.dart';
export 'src/models/models.dart';
export 'src/user_repo.dart';
export 'src/firebase_user_repo.dart';

 class UserRepositories1 extends GetxController{
  static UserRepositories1 get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  createNotes(UserModel user) async{
    await _db.collection("Notes").add(user.toJson()).whenComplete(
      () => Get.snackbar("Success", "You notes have been saved.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green),
    )
    .catchError((error, StackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red);
      print(error.toString());
    })
    
    
    ;
    
  }
 }