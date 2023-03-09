import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psych_diagnosis/business/chate_screen.dart';
import 'package:psych_diagnosis/constants/colors.dart';
import '../porfile/profile_psych_help.dart';

class ScreenHelp extends StatefulWidget {
  @override
  State<ScreenHelp> createState() => _ScreenHelpState();
}

class _ScreenHelpState extends State<ScreenHelp> {
  var user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Help',
          style: appbarStyle,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
        ],
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('help').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Data doesn't exist"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: buttonColor.withOpacity(0.40),
                        radius: 30,
                        backgroundImage: NetworkImage(
                          snapshot.data?.docs[index]['doctorImage'],
                        ),
                      ),
                      title: Text(
                        snapshot.data?.docs[index]['issueTitle'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data?.docs[index]['doctorName'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff777777),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        openScreen(
                          context,
                          UserChatScreen(
                            providerId: snapshot.data?.docs[index]['doctorId'],
                            profile: snapshot.data?.docs[index]['doctorImage'],
                            name: snapshot.data?.docs[index]['doctorName'],
                            text: snapshot.data?.docs[index]['issueTitle'],
                          ),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.black,
                      endIndent: 0,
                      indent: 0,
                    ),
                  ],
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          openScreen(context, ExamplePage());
        },
        child: Image.asset(
          'assets/logo/img_7.png',
          height: 36,
          width: 36,
        ),
      ),
    );
  }
}
