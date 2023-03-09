// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserModal {
//   GetUserData() async {
//     final DocumentSnapshot userDic = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     name = userDic.get('firstName') + userDic.get('lastName');
//     fname = userDic.get('firstName');
//     lname = userDic.get('lastName');
//     userid = userDic.get('userid');
//     email = userDic.get('email');
//     profile = userDic.get('profile');
//     birth = userDic.get('birth');
//     sex = userDic.get('sex');
//     status = userDic.get('status');
//     race = userDic.get('race');
//     print(name);
//     print(email);
//   }
// }
// String name = '';
// String email = '';
// String birth = '';
// String sex = '';
// String status = '';
// String fname = '';
// String lname = '';
// String userid = '';
// String profile = '';
// String race = '';

// Future<void> UserModel() async {
//   StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return CircularProgressIndicator();
//       }
//       final userDic = snapshot.data;
//       name = userDic!.get('firstName') + userDic.get('LastName');
//       fname = userDic.get('firstName');
//       lname = userDic.get('LastName');
//       userid = userDic.get('userid');
//       email = userDic.get('email');
//       profile = userDic.get('profile');
//       birth = userDic.get('birth');
//       sex = userDic.get('sex');
//       status = userDic.get('status');
//       race = userDic.get('race');
//       print(name);
//       print(email);
//       return Text("Data Loaded");
//     },
//   );
// }
// class Question{
//   final fireStore = FirebaseFirestore.instance;
//   Stream<DocumentSnapshot<Map<String, dynamic>>> get questionData{
//     return fireStore.collection('question').doc().snapshots();
//
//   }
//   void getData(DocumentSnapshot snapshot){
//     if(snapshot.exists){
//       var data = snapshot.data();
//       if(data != ''){
//         Map<String, dynamic> userMap = data as Map<String, dynamic>;
//
//         questionId = userMap['questionId'];
//       }
//     }
//   }
// }
// String questionId = '';
//
// class UserModal {
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//
//   Stream<DocumentSnapshot> get userData {
//     return _firestore
//         .collection("users")
//         .doc(_auth.currentUser!.uid)
//         .snapshots();
//
//   }
//
//   Future<void> updateData(Map<String, dynamic> data) async {
//     await _firestore
//         .collection("users")
//         .doc(_auth.currentUser!.uid)
//         .update(data);
//   }
//
//
//   void updateUserData(DocumentSnapshot snapshot) {
//     if (snapshot.exists) {
//       var user = snapshot.data();
//       if (user != null) {
//         Map<String, dynamic> userMap = user as Map<String, dynamic>;
//         name = userMap['firstName'] + userMap['lastName'];
//         fname = userMap['firstName'];
//         lname = userMap['lastName'];
//         userid = userMap['userid'];
//         email = userMap['email'];
//         profile = userMap['profile'];
//         birth = userMap['birth'];
//         sex = userMap['sex'];
//         status = userMap['status'];
//         race = userMap['race'];
//       }
//     }
//   }
// }
// String name = '';
// String email = '';
// String birth = '';
// String sex = '';
// String status = '';
// String fname = '';
// String lname = '';
// String userid = '';
// String profile = '';
// String race = '';