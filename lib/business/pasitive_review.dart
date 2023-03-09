import 'package:flutter/material.dart';
import 'package:psych_diagnosis/business/psych-home.dart';
import '../constants/colors.dart';

class PositiveReview extends StatefulWidget {

  @override
  State<PositiveReview> createState() => _PositiveReviewState();
}

class _PositiveReviewState extends State<PositiveReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(widget.numYesAnswers),
          Image.asset('assets/logo/positive.png'),
          Container(
            margin: EdgeInsets.all(20),

            child: Text(
              textAlign: TextAlign.center,
              'You are showing signs related to Major Depressive Disorder. Please see a psychiatric provider or doctor to get the additional help or support you may need.',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.30,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: MaterialButton(
                onPressed: () {
                  openScreen(context, PsychHome());
                },
                color: buttonColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: isloading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Back to Home',
                        style: buttonText,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isloading = false;
}
