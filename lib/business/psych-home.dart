import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../accounts/screen_psych_sign_in.dart';
import '../constants/colors.dart';
import '../layouts/layout_psych_home.dart';
import '../porfile/profile_psych_about.dart';
import '../porfile/profile_psych_profile.dart';
import 'connect_to_doctor.dart';

class PsychHome extends StatefulWidget {
  @override
  _PsychHomeState createState() => _PsychHomeState();
}

class _PsychHomeState extends State<PsychHome> {
  Future<void> getUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'currantDate': DateTime.now(),
    });
  }

  @override
  void initState() {
    setState(() {
      getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: buttonColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                openScreen(
                  context,
                  ProfilePsychProfile(),
                );
              },
              child: Icon(
                Icons.settings,
                color: buttonColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return snapshot.data?.size == 0
                  ? Center(
                      child: Text(
                        'No User Found',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                '${snapshot.data!.docs[index]['firstName'] +" "+ snapshot.data!.docs[index]['lastName']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
            },
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('disease')
                .orderBy('date', descending: false )
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Data doesn't Exist"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                  ),
                );
              }
              return Expanded(
                child: snapshot.data?.size == 0
                    ? Center(
                        child: Text(
                          'No data Found',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.docs.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final sectionCount = index + 1;
                          return LayoutPsychHome(
                            disease: snapshot.data?.docs[index]['disease'],
                            minimumYes: snapshot.data?.docs[index]['mini'],
                            diseaseId: snapshot.data?.docs[index]['uid'],
                            adminId: snapshot.data?.docs[index]['admin'],
                            sectionCount: sectionCount,
                          );
                        },
                      ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                return snapshot.data?.size == 0
                    ? Text(
                        'No User Found',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return DrawerHeader(
                            child: Align(
                              alignment: Alignment.center,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Colors.grey.withOpacity(0.30),
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs[index]['profile']),
                                ),
                                title: Text(
                                  '${snapshot.data!.docs[index]['firstName'] +" "+ snapshot.data!.docs[index]['lastName']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  '${snapshot.data!.docs[index]['email']}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: buttonColor,
                            ),
                          );
                        },
                      );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: buttonColor,
                size: 24,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: buttonColor,
                ),
              ),
              onTap: () {
                // Navigate to item 1
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/logo/icon.png',
                color: Colors.black,
                width: 24,
                height: 24,
              ),
              title: Text(
                'Connect with Doctor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                openScreen(
                  context,
                  ConnectToDoctor(),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/logo/doctor.png',
                color: Colors.black,
                height: 24,
                width: 24,
              ),
              title: Text(
                'I am a Mental Health Professional',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // openScreen(context, NegativeReview());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                openScreen(context, ProfilePsychAbout());
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                size: 24,
                color: buttonColor,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut().whenComplete(
                  () {
                    openScreen(context, ScreenPsychLogIn());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
