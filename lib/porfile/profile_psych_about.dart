import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfilePsychAbout extends StatefulWidget {
  const ProfilePsychAbout({Key? key}) : super(key: key);

  @override
  State<ProfilePsychAbout> createState() => _ProfilePsychAboutState();
}

class _ProfilePsychAboutState extends State<ProfilePsychAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,),),
        title: Text('About', style: appbarStyle,),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 121,
              width: 135,
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: AutoSizeText(maxLines: 3,'An application created by Michael O. Ortiz, PMHNP-BC to support individuals in monitoring their symptoms in relation to their mental health.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),),

            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Contact us', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black,),)),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.width_wide_outlined,
                      color: buttonColor,
                    ),
                  ),
                  Text(
                    "www.userapp.com",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.mail_outline,
                      color: buttonColor,
                    ),
                  ),
                  Text(
                    "Contact@sharebottle.com",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.apps,
                      color: buttonColor,
                    ),
                  ),
                  Text(
                    "123456",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
