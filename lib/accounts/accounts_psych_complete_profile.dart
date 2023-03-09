import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:psych_diagnosis/constants/colors.dart';
import '../business/psych-home.dart';
import '../main.dart';

class ScreenPsychCompleteProfile extends StatefulWidget {
  String uid;
  ScreenPsychCompleteProfile({required this.uid});

  @override
  State<ScreenPsychCompleteProfile> createState() =>
      _ScreenPsychCompleteProfileState();
}

class _ScreenPsychCompleteProfileState
    extends State<ScreenPsychCompleteProfile> {
  bool _isLoading = false;

  final _signUpFormKey = GlobalKey<FormState>();
  File? selectedImage;
  var base64Image = "";

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  var dateinput = TextEditingController();
  String? material;
  var items = [
    'Married',
    'Living with Someone',
    'Widowed',
    'Separated',
    'Divorced',
    'Never Married',
  ];
  String? sex;
  var sexItem = [
    'Male',
    'Female',
    'Other',
  ];
  String? race;
  var raceItem = [
    'White',
    'Black',
    'Hispanic',
    'Asian',
    'Portuguese',
    'Other',
  ];
  String? education;
  var eduItems = [
    'Matriculation',
    'Intermediate',
    'Graduation',
    'M Phil',
    'Phd',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Form(
        key: _signUpFormKey,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Let’s Complete Profile',
                      style: appbarStyle,
                    ),
                  ),
                ),
                SizedBox(height: 6,),
                Container(
                  height: 115,
                  width: 100,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: buttonColor, width: 1.5,),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: buttonColor.withOpacity(0.50),
                          backgroundImage: selectedImage == null
                              ? NetworkImage('assets/logo/doctor.png')
                                  as ImageProvider
                              : FileImage(selectedImage!),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            _choiseShowDialog(context);
                          },
                          icon: Image.asset(
                            'assets/logo/img_8.png',
                            height: 36,
                            width: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: material,
                      hint: Text(
                        'Marital Status',
                        style: textFieldStyle,
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          material = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          material = value;
                        });
                      },
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: sex,
                      hint: Text(
                        'Sex',
                        style: textFieldStyle,
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          sex = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          sex = value;
                        });
                      },
                      items: sexItem.map((String sexItem) {
                        return DropdownMenuItem(
                          value: sexItem,
                          child: Text(
                            sexItem,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: race,
                      hint: Text(
                        'Race',
                        style: textFieldStyle,
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          race = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          race = value;
                        });
                      },
                      // validator: (String value) {
                      //   if (value.isEmpty) {
                      //     return "can't empty";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      items: raceItem.map((String raceItem) {
                        return DropdownMenuItem(
                          value: raceItem,
                          child: Text(
                            raceItem,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: education,
                      hint: Text(
                        'Education',
                        style: textFieldStyle,
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          education = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          education = value;
                        });
                      },
                      // validator: (String value) {
                      //   if (value.isEmpty) {
                      //     return "can't empty";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      items: eduItems.map((String eduItems) {
                        return DropdownMenuItem(
                          value: eduItems,
                          child: Text(
                            eduItems,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: TextField(
                      controller: dateinput,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Date of birth", hintStyle: textFieldStyle,
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(5000),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: buttonColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: buttonColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      cursorColor: buttonColor,
                      controller: about,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 10,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'About',
                        hintStyle: textFieldStyle,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Write Something for About Your";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 43,
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: MaterialButton(
                    onPressed: () => uplodedata(),
                    color: buttonColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Finish',
                            style: buttonText,
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _choiseShowDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Image From"),
            actions: [
              GestureDetector(
                child: Text(
                  "Gallery",
                  style: TextStyle(color: buttonColor),
                ),
                onTap: () {
                  chooseImage("Gallery");
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                  child: Text(
                    "camera",
                    style: TextStyle(color: buttonColor),
                  ),
                  onTap: () {
                    chooseImage("camera");
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  var about = TextEditingController();
  void uplodedata() async {
    try {

      if (base64Image.isEmpty) {
        displayMessage('Please Select Image');
      } else if (material == null) {
        displayMessage('Please Select Material Status');
      } else if (sex == null) {
        displayMessage('Please Select Gender');
      } else if (raceItem == '' || raceItem.toString().trim().isEmpty) {
        displayMessage('Please Choose the Race');
      } else if (eduItems == '' || eduItems.toString().trim().isEmpty) {
        displayMessage('Please Choose the Education');
      } else if (dateinput.text.isEmpty) {
        displayMessage('Please Choose the Date of Birth');
      } else if (about.text.isEmpty) {
        displayMessage('Please Enter something for yourself');
      } else {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(widget.uid + '.jpg');
        await ref.putFile(selectedImage!);
        base64Image = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
          'birth': dateinput.text.trim(),
          'race': raceItem.toString().trim(),
          'sex': sex.toString().trim(),
          'status': material.toString().trim(),
          'about': about.text.trim(),
          'education': education.toString().trim(),
          'profile': base64Image,
        });
        displayMessage('Profile Created Successfully');
        openScreen(
          context,
          PsychHome(),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      displayMessage(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


// void uplodedata() async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     if (base64Image.isEmpty) {
  //       displayMessage('Please Select Image');
  //     } else if (material == null) {
  //       displayMessage('Please Select Material Status');
  //     } else if (sex == null) {
  //       displayMessage('Please Select Gender');
  //     } else if (dateinput == null) {
  //       displayMessage('Chose The Date of Birth');
  //     } else if (raceItem == null) {
  //       displayMessage('chose the Race');
  //     } else if (eduItems == null) {
  //       displayMessage('chose the Education');
  //     }
  //     else if (about.text.isEmpty) {
  //       displayMessage('Please Enter something for yourSelf');
  //     } else {
  //       final ref = FirebaseStorage.instance
  //           .ref()
  //           .child('userImages')
  //           .child(widget.uid + '.jpg');
  //       await ref.putFile(selectedImage!);
  //       base64Image = await ref.getDownloadURL();
  //       FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
  //         'birth': dateinput.text.trim(),
  //         'race': race.toString().trim(),
  //         'sex': sex.toString().trim(),
  //         'status': material.toString().trim(),
  //         'about': about.text.trim(),
  //         'education': education.toString().trim(),
  //         'profile': base64Image,
  //       });
  //       displayMessage('Profile Created Successfully');
  //       openScreen(
  //         context,
  //         PsychHome(),
  //       );
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } catch (error) {
  //     displayMessage(error.toString());
  //   }
  // }
}
