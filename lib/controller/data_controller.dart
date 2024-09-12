import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {

TextEditingController noteTextController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("======== ${getUser()} =========");
    getUser();
  }

  

  //get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection("notes");
  FirebaseAuth auth = FirebaseAuth.instance;

  //Create : add new note
  addNote (String note) {
    notes.add({
    'note' : note,
    'timeStmp' : Timestamp.now()
    });
    // notes.doc(auth.currentUser!.email).set({
    //  'note' : note,
    // 'timeStmp' : Timestamp.now()
    // }).then((value) => Get.snackbar("Success", "Post Added Successfully"),);
  }
   
Stream<List<Map<String, dynamic>>> getUser() {
  return notes.snapshots().map((event) {
    // Extract data from each document and collect into a list
    return event.docs.map((e) {
      print('---------------------'); print(e.data());
      return e.data() as Map<String, dynamic>;
    }).toList();
  });
}



  //READ : featch all notes
  Stream<QuerySnapshot> getAllnote (){
      final noteStream =  notes.orderBy("timeStmp" , descending: true).snapshots();
      return noteStream;
  }

  //Update 
  updateNote (String docID, String updatedtext){
    notes.doc(docID).update({
      "note" : updatedtext,
      'timeStmp' : Timestamp.now()
    });
  }

  //delete
  deleteNote ({required String docID}){
   // CollectionReference collectionReference = FirebaseFirestore.instance.collection("notes");
   notes.doc(docID).delete();
  }
}