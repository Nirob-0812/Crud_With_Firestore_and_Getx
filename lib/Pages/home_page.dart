import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx/Theme/custom_theme.dart';
import 'package:getx/Widget/Custom_Snackbar.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController address_controller = TextEditingController();
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> user_production([DocumentSnapshot? users]) async {
    String operation = "create";
    if (users != null) {
      operation = "update";
      name_controller.text = users["name"];
      address_controller.text = users["address"];
    }
    Get.bottomSheet(
      Container(
        color: Colors.yellow,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  label: Text("Name"),
                ),
                controller: name_controller,
              ),
              SizedBox(height: 15,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  label: Text("Address"),
                ),
                controller: address_controller,
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: () async {
                    final name = name_controller.text;
                    final address = address_controller.text;
                    if (operation == "create") {
                      await _collectionReference
                          .add({"name": name, "address": address});
                     Custom_Snackbar(context, "You have successfully Saved");
                    }
                    if (operation == "update") {
                      await _collectionReference
                          .doc(users!.id)
                          .update({"name": name, "address": address});
                       Custom_Snackbar(context, "You have successfully Updated");
                    }
                    Get.back();
                    name_controller.text = "";
                    address_controller.text = "";
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    primary: Colors.indigo,
                  ),
                  child: Text(operation == "create" ? "Create" : "Update"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> delete_user_production(String id) async {
    await _collectionReference.doc(id).delete();
    Custom_Snackbar(context, "You have Successfully Deleted");
  }

  @override
  Widget build(BuildContext context) {
    // bool check=Get.isDarkMode;
    // final _controller=Get.find<Notification_Controller>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Crud using GetX"),
        leading: GestureDetector(
            onTap: () {
              Custom_Theme().switch_theme();
              Custom_Snackbar(context, "Theme Changed");
              print("tapped" + Get.isDarkMode.toString());
            },
            child: Icon(Get.isDarkMode ? Icons.sunny : Icons.nightlight_round)),
        actions: [
          IconButton(
              onPressed: () {
                user_production();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: _collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot users = snapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(users['name']),
                      subtitle: Text(users['address']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  user_production(users);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  delete_user_production(users.id);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
