import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psych_diagnosis/constants/colors.dart';

import '../layouts/connect_to_doctor.dart';

class ConnectToDoctor extends StatefulWidget {
  const ConnectToDoctor({Key? key}) : super(key: key);

  @override
  State<ConnectToDoctor> createState() => _ConnectToDoctorState();
}

class _ConnectToDoctorState extends State<ConnectToDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Connect with Doctor",
          style: appbarStyle,
        ),
        actions: [
          Icon(
            Icons.search_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('admin').snapshots(),
          builder: (context, snapshot) {
            return snapshot.data?.size == 0
                ? Center(
                    child: Text(
                      'No Doctor Found',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data!.docs[index];
                      return LayoutConnectToDoctor(
                        name: data['firstName'] + data['lastName'],
                        providerId: data['adminId'],
                        profile: data['profile'],
                      );
                    },
                  );
          }),
    );
  }
}
