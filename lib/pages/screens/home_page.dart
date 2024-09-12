import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseall_in_one/controller/auth_controller.dart';
import 'package:firebaseall_in_one/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authController = Get.put(AuthController());

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
              List<DocumentSnapshot> listofDocs = snapshot.data!.docs;
              print(listofDocs);
              return ListView.builder(
                itemCount: listofDocs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // get each individul doc
                  DocumentSnapshot documentSnapshot = listofDocs[index];
                  String DocID = documentSnapshot.id;
                  print(DocID);

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
                            // Set the initial value for the TextEditingController//
                            //Use the controller for Initial Value://\
                            // Can't we both inital and controller //
                            // Rather then use inital we can set value into 
                                      //  controller.text //
                            dataController.noteTextController.text =
                                featchNotes["note"] ?? 'No Edit';
                                
                            Get.defaultDialog(
                              title: "Note Time!",
                              content: TextFormField(
                                controller: dataController.noteTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your note here',
                                ),
                              ),
                              textConfirm: "Add notes",
                              onConfirm: () {
                                String noteText = dataController
                                    .noteTextController.text
                                    .trim();
                                if (noteText.isEmpty) {
                                  Get.snackbar("Error", "Note box is empty");
                                } else {
                                  dataController.updateNote(
                                    DocID,
                                    noteText,
                                  );
                                  dataController.noteTextController.clear();
                                  Get.back();
                                }
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () {
                              dataController.deleteNote(docID: DocID);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Text('No Notes Founds');
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Note Time!",
              content: TextFormField(
                controller: dataController.noteTextController,
              ),
              textConfirm: "Add notes",
              onConfirm: () {
                dataController.addNote(dataController.noteTextController.text);
                Get.back();
                // print(authController.credential!.user!.email);
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
