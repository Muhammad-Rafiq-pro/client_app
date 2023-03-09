import 'package:flutter/material.dart';
import 'package:psych_diagnosis/business/psych-home.dart';

import '../constants/colors.dart';

class NegativeReview extends StatefulWidget {
  const NegativeReview({Key? key}) : super(key: key);

  @override
  State<NegativeReview> createState() => _NegativeReviewState();
}

class _NegativeReviewState extends State<NegativeReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo/negative.png'),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: 'Congratulations, ',

                style: TextStyle(

                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,),
                children: [
                  TextSpan(
                    text: 'You are not showing signs related to Major Depressive disorder. Take care and thank you for using Psych Diagnosis app.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,),
                  )
                ]
              ),

            ),
          ),
          SizedBox(height: 50,),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.30,
            child: Container(
              margin: EdgeInsets.only(top: 30),
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
