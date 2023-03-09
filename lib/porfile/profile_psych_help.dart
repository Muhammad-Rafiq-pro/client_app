import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../business/chateHelp.dart';
import '../constants/colors.dart';
import '../main.dart';

class ExamplePage extends StatefulWidget {
  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  var emailController = TextEditingController();

  var feedController = TextEditingController();
  String? selectedUser;
  String? selectedUserId;
  String? selectedUserImage;

  Future<void> help() async {
    if (selectedUser == null) {
      displayMessage('Please select a user');
      return;
    }
    if (emailController.text.isEmpty) {
      displayMessage('Please Enter Your Disease');
    } else if (feedController.text.isEmpty) {
      displayMessage('Please Enter Your Feedback');
    } else {
      CollectionReference products =
          FirebaseFirestore.instance.collection('help');
      products.doc().set({
        'issueTitle': emailController.text,
        'disc': feedController.text,
        'doctorImage': selectedUserImage,
        'doctorName': selectedUser,
        'doctorId': selectedUserId,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
      displayMessage('Feedback Successfully Sent');
      openScreen(context, ScreenHelp());
      return print('hello');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Help',
          style: appbarStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('admin')
              .where('connected', isEqualTo: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: buttonColor,
              );
            }

            // Extract a list of users from the QuerySnapshot
            List<DropdownMenuItem<String>> items =
                snapshot.data!.docs.map((doc) {
              String fullName = doc['firstName'] + ' ' + doc['lastName'];
              String userId = doc['adminId'];
              String userImage = doc['profile'];
              return DropdownMenuItem<String>(
                value: fullName,
                child: Text(fullName),
              );
            }).toList();

            // Create a DropdownButtonFormField with the list of strings
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      hintText: 'Select Doctor',
                      hintStyle: textFieldStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    value: selectedUser,
                    items: items,
                    onChanged: (String? value) {
                      // Do something when the dropdown value changes
                      if (value != null) {
                        setState(() {
                          selectedUser = value;
                          selectedUserId = snapshot.data!.docs[items.indexWhere(
                              (item) => item.value == value)]['adminId'];
                          selectedUserImage = snapshot.data!.docs[items
                                  .indexWhere((item) => item.value == value)]
                              ['profile'];
                        });
                      }
                    },
                  ),
                ),
                Container(
                  // height: 43,
                  // height: MediaQuery.of(context).size.height/9,
                  width: MediaQuery.of(context).size.width * 0.90,
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: buttonColor,
                    controller: emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Enter Issue Tile",
                      hintStyle: textFieldStyle,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: buttonColor,
                    controller: feedController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Question Text here",
                      hintStyle: textFieldStyle,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(174, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: buttonColor,
                  ),
                  onPressed: () => help(),
                  child: Text(
                    'Send',
                    style: buttonText,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
