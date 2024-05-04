import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseall_in_one/controller/auth_controller.dart';
import 'package:firebaseall_in_one/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authController = Get.put(AuthController());

  TextEditingController noteTextController = TextEditingController();

  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  authController.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder(
          stream: dataController.getAllnote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> listofDoc = snapshot.data!.docs;
              print(listofDoc);
              return ListView.builder(
                itemCount: listofDoc.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // get each individul doc
                  DocumentSnapshot documentSnapshot = listofDoc[index];
                  String DocID = documentSnapshot.id;

                  // get note from each doc
                  Map<String, dynamic> featchNotes =
                      documentSnapshot.data() as Map<String, dynamic>;

                  //  final DateFormate = DateFormat.yMMMEd().format(featchNotes["timeStmp"]);

                  // display as list tile
                  return ListTile(
                    title: Text('${featchNotes["note"]}'),
                    // subtitle: Text("${featchNotes["timeStmp"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Note Time!",
                                content: TextField(
                                  controller: noteTextController,
                                ),
                                textConfirm: "Add notes",
                                onConfirm: () {
                                  noteTextController.text.isEmpty
                                      ? Get.snackbar(
                                          "Error", "note box is empty")
                                      : dataController
                                          .updateNote(DocID , noteTextController.text);
                                  noteTextController.clear();
                                  Get.back();
                                },
                              );
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(onPressed: () {
                        dataController.deleteNote(docID: DocID);
                        }, icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text("no data found");
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
