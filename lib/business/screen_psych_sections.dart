import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psych_diagnosis/business/nagative_review.dart';
import 'package:psych_diagnosis/business/pasitive_review.dart';
import 'package:psych_diagnosis/constants/colors.dart';
import 'package:psych_diagnosis/layouts/layout_psych_section.dart';
import 'package:psych_diagnosis/main.dart';

int totalQuestion = 0;

class ScreenPsychSection1 extends StatefulWidget {
  final String diseaseId;
  final String disease;
  final String adminId;
  final minimumYes;
  final sectionCount;
  final totalNo;
  final totalYes;
  // final sum1;
  // final sum2;

  const ScreenPsychSection1({
    required this.diseaseId,
    required this.disease,
    required this.adminId,
    // required this.sum1,
    // required this.sum2,
    required this.minimumYes,
    required this.sectionCount,
    required this.totalNo,
    required this.totalYes,
  });

  @override
  State<ScreenPsychSection1> createState() => _ScreenPsychSection1State();
}

class _ScreenPsychSection1State extends State<ScreenPsychSection1> {
  @override
  void initState() {
    totalQuestion = 0;
    super.initState();
  }

  bool isloading = false;

  var questionId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, questionId);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Section ${widget.sectionCount}',
          style: appbarStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('question')
                  .where('diseaseId', isEqualTo: widget.diseaseId)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Question Doesn't Exist"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  );
                }
                totalQuestion = snapshot.data!.docs.length;
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    questionId = snapshot.data?.docs[index]['questionId'];
                    return LayoutPsychSection(
                      totalYes: widget.totalYes,
                      totalNo: widget.totalNo,
                      sectionCount: widget.sectionCount,
                      totalQuestion: totalQuestion,
                      question: snapshot.data?.docs[index]['question'],
                      questionId: questionId,
                      diseaseId: widget.diseaseId,
                      adminId: widget.adminId,
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 43,
            width: (MediaQuery.of(context).size.width / 1.30).toDouble(),
            child: MaterialButton(
              onPressed: () {
                if (numYesAns == 0 && numNoAns == 0) {
                  displayMessage('Please give the Question Answers');
                } else
                  if (numYesAns > numNoAns) {
                  openScreen(context, PositiveReview());
                } else {
                  openScreen(context, NegativeReview());
                }
              },
              color: buttonColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: isloading
                  ? Container(
                      height: 27,
                      width: 27,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      "Submit",
                      style: buttonText,
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
