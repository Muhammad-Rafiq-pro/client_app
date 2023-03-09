import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis/business/screen_psych_sections.dart';
import '../constants/colors.dart';

int numNoAns = 0;
int numYesAns = 0;

class LayoutPsychSection extends StatefulWidget {
  final String diseaseId;
  final String question;
  final String questionId;
  final sectionCount;
  final String adminId;
  final totalNo;
  final totalYes;
  final totalQuestion;
  const LayoutPsychSection({
    Key? key,
    required this.question,
    required this.diseaseId,
    required this.questionId,
    required this.adminId,
    this.totalQuestion,
    required this.sectionCount,
    required this.totalNo,
    required this.totalYes,
    // this.sum1,
    // this.sum2
  }) : super(key: key);

  @override
  State<LayoutPsychSection> createState() => _LayoutPsychSectionState();
}

class _LayoutPsychSectionState extends State<LayoutPsychSection> {
  int numQuestions = 0;
  var currentIndex = 0;
  var index = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.02,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                '${widget.question}',
                style: questionStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: buttonColor,
                    ),
                    backgroundColor:
                        currentIndex == 1 ? buttonColor : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        saveAnswerToFirestore(
                            widget.diseaseId, widget.questionId, "No");
                        getPreviousAnswer(widget.diseaseId, widget.questionId);
                        // navigator();
                        currentIndex = 1;
                        index = 1;
                      },
                    );
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: currentIndex == 1 ? Colors.white : buttonColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: buttonColor),
                    backgroundColor:
                        currentIndex == 2 ? buttonColor : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        saveAnswerToFirestore(
                            widget.diseaseId, widget.questionId, "Yes");
                        getPreviousAnswer(widget.diseaseId, widget.questionId);
                        currentIndex = 2;
                        index = 2;
                      },
                    );
                  },
                  child: Text(
                    'yes',
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: currentIndex == 2 ? Colors.white : buttonColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveAnswerToFirestore(
      String uid, String questionId, String answer) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("user_answers")
        .doc(FirebaseAuth.instance.currentUser!.uid +
            "_" +
            uid +
            "_" +
            questionId)
        .get();

    if (snapshot.exists) {
      String previousAnswer = snapshot.get("answer");
      if (previousAnswer == "Yes") {
        numYesAns--;
      } else if (previousAnswer == "No") {
        numNoAns--;
      }
    }

    if (answer == "Yes") {
      numYesAns++;
    } else if (answer == "No") {
      numNoAns++;
    }

    await FirebaseFirestore.instance
        .collection("user_answers")
        .doc(FirebaseAuth.instance.currentUser!.uid +
            "_" +
            uid +
            "_" +
            questionId)
        .set(
      {
        "answer": answer,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'questionId': widget.questionId,
        'question': widget.question,
        'diseaseId': widget.diseaseId,
        'total': totalQuestion,
        'sectionCount': widget.sectionCount,
        'adminId': widget.adminId,
        'totalYes': widget.totalYes,
        'totalNo': widget.totalNo,
      },
    );
  }

  Future<String?> getPreviousAnswer(String uid, String questionId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("user_answers")
        .doc(FirebaseAuth.instance.currentUser!.uid +
            "_" +
            uid +
            "_" +
            questionId)
        .get();
    if (snapshot.exists) {
      String? answer = snapshot.get("answer");
      if (answer == 'Yes') {
        numYesAns++;
      } else if (answer == 'No') {
        numNoAns++;
      }
      return answer;
    } else {
      setState(() {
        numQuestions++;
      });
      return null;
    }
  }

  @override
  void initState() {
    numNoAns = 0;
    numYesAns = 0;
    super.initState();
    currentIndex = index;
    getPreviousAnswer(widget.diseaseId, widget.questionId).then(
      (answer) {
        if (answer != null) {
          setState(
            () {
              print(',,,,,,,,, $numYesAns');
              print('object     $numNoAns');
              currentIndex = answer == 'Yes' ? 2 : 1;
              index = currentIndex;
            },
          );
        }
      },
    );
  }
}
