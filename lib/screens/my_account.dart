import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/screens/settings.dart';
import '../config.dart';
import '../constants.dart';
import '../providers/auth.dart';
import '../widgets/custom_teal_text.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'home.dart';
import 'login.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  TextEditingController _emailController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _dobController;
  TextEditingController _phoneController;
  int _groupValue = -1;
  bool _genderSelected = false;
  bool showHint = true;
  bool showLabel = false;
  DateTime _selectedDate;

  _selectDate(BuildContext context) async {
    final intl.DateFormat formatter = intl.DateFormat('MM/dd/yyyy');
    setState(() {
      showHint = false;
      showLabel = true;
    });
    DateTime newSelectedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      firstDate: DateTime(1800),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dobController
        ..text = formatter.format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dobController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  successDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        content: Container(
          height: 100,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: 30, top: 15),
                child: Text(
                  'Your account updated successfully.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        'HOMEPAGE',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        App.pushTo(
                          context: context,
                          screen: HomeScreen(),
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        'SETTINGS',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        App.pushTo(
                          context: context,
                          screen: Settings(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: App.prefs.getString('email') ?? '');
    _firstNameController =
        TextEditingController(text: App.prefs.getString('firstName') ?? '');
    _lastNameController =
        TextEditingController(text: App.prefs.getString('lastName') ?? '');
    _dobController =
        TextEditingController(text: App.prefs.getString('dob') ?? '');
    _phoneController =
        TextEditingController(text: App.prefs.getString('phone') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: MenuNew(
          title: 'MY PROFILE',
          children: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: App.width(context),
                    padding: EdgeInsets.only(bottom: 2),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 35,
                          child: Radio(
                            value: 0,
                            groupValue: _groupValue,
                            onChanged: (newValue) => setState(() {
                              _groupValue = newValue;
                              _genderSelected = true;
                            }),
                            activeColor: appLightColor,
                          ),
                        ),
                        Text(
                          'Mr.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          width: 35,
                          child: Radio(
                            value: 1,
                            groupValue: _groupValue,
                            onChanged: (newValue) => setState(() {
                              _groupValue = newValue;
                              _genderSelected = true;
                            }),
                            activeColor: appLightColor,
                          ),
                        ),
                        Text(
                          'Ms.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        customTextField(
                            controller: _emailController,
                            hint: 'Email',
                            keyboard: TextInputType.emailAddress,
                            showHint: showHint,
                            showLabel: showLabel,
                            autoValidate: true,
                            onTap: () {
                              setState(() {
                                showHint = false;
                                showLabel = true;
                              });
                            },
                            validator: (value) => (value.isEmpty)
                                ? "Enter valid email address"
                                : null),
                        customTextField(
                            controller: _firstNameController,
                            hint: 'First Name',
                            showHint: showHint,
                            showLabel: showLabel,
                            autoValidate: true,
                            onTap: () {
                              setState(() {
                                showHint = false;
                                showLabel = true;
                              });
                            },
                            validator: (value) => (value.isEmpty)
                                ? "Enter your first name"
                                : null),
                        customTextField(
                            controller: _lastNameController,
                            hint: 'Last Name',
                            showHint: showHint,
                            showLabel: showLabel,
                            autoValidate: true,
                            onTap: () {
                              setState(() {
                                showHint = false;
                                showLabel = true;
                              });
                            },
                            validator: (value) => (value.isEmpty)
                                ? "Enter your last name"
                                : null),
                        customTextField(
                          controller: _dobController,
                          hint: 'Date of Birth',
                          showHint: showHint,
                          showLabel: showLabel,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                        customTextField(
                            controller: _phoneController,
                            hint: 'Cell Number',
                            keyboard: TextInputType.number,
                            showHint: showHint,
                            showLabel: showLabel,
                            onTap: () {
                              setState(() {
                                showHint = false;
                                showLabel = true;
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customTextButton(
                title: 'SAVE',
                shadow: Colors.white,
                onTap: () async {
                  bool check = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          content: Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Processing Data.....',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  print(check);
                  if (check) return successDialog();
                },
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
