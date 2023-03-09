import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../business/screen_psych_sections.dart';
import '../constants/colors.dart';

class LayoutPsychHome extends StatefulWidget {
  final String disease;
  final minimumYes;
  final String diseaseId;
  final String adminId;
  final int sectionCount;
  const LayoutPsychHome({
    Key? key,
    required this.disease,
    required this.minimumYes,
    required this.diseaseId,
    required this.adminId,
    required this.sectionCount,
  }) : super(key: key);

  @override
  State<LayoutPsychHome> createState() => _LayoutPsychHomeState();
}

class _LayoutPsychHomeState extends State<LayoutPsychHome> {
  int totalYes = 0;
  int totalNo = 0;

  Widget _calculateIcon(int totalQuestion, int totalYes, int totalNo) {
    if (totalQuestion == 0 || (totalYes == 0 && totalNo == 0)) {
      return Container();
    } else if (totalNo > totalYes) {
      return Image.asset(
        'assets/logo/img_9.png',
        height: 15,
        width: 15,
      );
    } else {
      return Container(
        height: 15,
        width: 15,
        child: Image.asset(
          'assets/logo/img_10.png',
          height: 15,
          width: 15,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.02,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 1,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_answers')
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('diseaseId', isEqualTo: widget.diseaseId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  backgroundColor: buttonColor,
                ),
              );
            }
            totalYes = 0;
            totalNo = 0;
            int totalQuestion = snapshot.data!.docs.length;
            for (var document in snapshot.data!.docs) {
              String answer = document.get('answer') as String;
              if (answer == 'Yes') {
                totalYes++;
              } else if (answer == 'No') {
                totalNo++;
              }
            }
            return ListTile(
              title: RichText(
                text: TextSpan(
                  text: 'Section ${widget.sectionCount}',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' ($totalQuestion questions)',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA5A5A5),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                openScreen(
                  context,
                  ScreenPsychSection1(
                    disease: widget.disease,
                    sectionCount: widget.sectionCount,
                    diseaseId: widget.diseaseId,
                    adminId: widget.adminId,
                    minimumYes: widget.minimumYes,
                    totalYes: totalYes,
                    totalNo: totalNo,
                  ),
                );
              },
              trailing: Container(
                width: 50,
                height: 50,
                child: _calculateIcon(totalQuestion, totalYes, totalNo),
              ),
            );
          },
        ),
      ),
    );
  }

  int totalQuestion = 0;
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = FirebaseFirestore.instance
        .collection('question')
        .where('diseaseId', isEqualTo: widget.diseaseId)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        totalQuestion = snapshot.docs.length;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
