import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {

  //get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection("notes");

  //Create : add new note
  addNote (String note) {
    notes.add({
    'note' : note,
    'timeStmp' : Timestamp.now()
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
   CollectionReference collectionReference = FirebaseFirestore.instance.collection("notes");
   collectionReference.doc(docID).delete();
  }
}