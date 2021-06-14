import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/model/contact_number.dart';
import 'package:wayawaya/app/settings/model/update_user_model.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';
import '../../constants.dart';
import 'bloc/my_account_bloc.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  TextEditingController _emailController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _dobController;
  TextEditingController _phoneController;
  var _formKey;

  int _groupValue = -1;
  DateTime _selectedDate;

  _selectDate(BuildContext context) async {
    final intl.DateFormat formatter = intl.DateFormat('dd/MM/yyyy');
    DateTime newSelectedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      dateFormat: "dd-MM-yyyy",
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
                    fontSize: 14,
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
                        // App.pushTo(
                        //   context: context,
                        //   screen: HomeScreen(),
                        // );
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
                        // App.pushTo(
                        //   context: context,
                        //   screen: Settings(),
                        // );
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

  MyAccountBloc _myAccountBloc;

  @override
  void initState() {
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _dobController = TextEditingController();
    _phoneController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
    _myAccountBloc = MyAccountBloc();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _myAccountBloc.fetchMenuButtons();
      fetchUserData();
    });
  }

  fetchUserData() {
    _myAccountBloc.setUpUserData().then((value) {
      _emailController.text = _myAccountBloc.fetchEmail;
      _firstNameController.text = _myAccountBloc.fetchFirstName;
      _lastNameController.text = _myAccountBloc.fetchLastName;
      _dobController.text = _myAccountBloc.fetchDateOfBirth;
      _phoneController.text = _myAccountBloc.fetchPhoneNumber;
    });
  }

  Widget _radioButtonWidget() => Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: 2),
        margin: const EdgeInsets.only(bottom: 5),
        child: StreamBuilder<int>(
            initialData: -1,
            stream: _myAccountBloc.genderStream,
            builder: (context, snapshot) {
              return Row(
                children: <Widget>[
                  Container(
                    width: 35,
                    child: Radio(
                      value: 0,
                      groupValue: snapshot.data,
                      onChanged: (newValue) {
                        debugPrint('radio_button_click:-   $newValue');
                        _groupValue = newValue;
                        _myAccountBloc.genderSink.add(_groupValue);
                      },
                      activeColor: AppColor.colored_text,
                    ),
                  ),
                  const Text(
                    AppString.mr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    width: 35,
                    child: Radio(
                      value: 1,
                      groupValue: snapshot.data,
                      onChanged: (newValue) {
                        debugPrint('radio_button_click:-   $newValue');
                        _groupValue = newValue;
                        _myAccountBloc.genderSink.add(_groupValue);
                      },
                      activeColor: AppColor.colored_text,
                    ),
                  ),
                  const Text(
                    AppString.ms,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            }),
      );

  Widget _emailWidget() => TextFormField(
        autofocus: false,
        controller: _emailController,
        validator: (value) {
          if (value.isEmpty) {
            return AppString.enter_valid_email_address;
          } else if (!Utils.emailValidation(value)) {
            return AppString.email_validation_error_message;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: AppString.email,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.colored_text,
              width: 2,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.borderColor,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );

  Widget _firstNameWidget() => TextFormField(
        autofocus: false,
        controller: _firstNameController,
        validator: (value) {
          if (value.isEmpty) {
            return AppString.enter_your_first_name;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: AppString.first_name,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.colored_text,
              width: 2,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.borderColor,
            ),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget _lastNameWidget() => TextFormField(
        autofocus: false,
        controller: _lastNameController,
        validator: (value) {
          if (value.isEmpty) {
            return AppString.enter_your_last_name;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: AppString.last_name,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.colored_text,
              width: 2,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.borderColor,
            ),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  Widget _dobWidget() => GestureDetector(
        onTap: () {
          print("dob widget click");
          _selectDate(context);
        },
        child: TextFormField(
          autofocus: false,
          controller: _dobController,
          validator: (value) {
            // if (value.isEmpty) {
            //   return AppString.enter_your_dob;
            // }
            return null;
          },
          decoration: const InputDecoration(
            labelText: AppString.dob,
            alignLabelWithHint: true,
            enabled: false,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: AppString.dob,
            labelStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.colored_text,
                width: 2,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.borderColor,
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  Widget _phoneNumberWidget() => TextFormField(
        autofocus: false,
        controller: _phoneController,
        validator: (value) {
          // if (value.isEmpty) {
          //   return AppString.enter_your_cell_number;
          // } else {
          return null;
          // }
        },
        decoration: const InputDecoration(
          labelText: AppString.cell_number,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.colored_text,
              width: 2,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.borderColor,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgColor,
            body: StreamBuilder<List<MainMenuPermission>>(
                initialData: [],
                stream: _myAccountBloc.mainMenuPermissionStream,
                builder: (context, snapshot) {
                  return AnimateAppBar(
                    title: AppString.my_profile.toUpperCase(),
                    isSliver: true,
                    mainMenuPermissions: snapshot.data,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            _radioButtonWidget(),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: Dimens.ten),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    _emailWidget(),
                                    _firstNameWidget(),
                                    _lastNameWidget(),
                                    _dobWidget(),
                                    _phoneNumberWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            bottomNavigationBar: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        _updateUserInfo();
                        // return successDialog();
                      },
                      child: Card(
                        shadowColor: AppColor.white,
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              AppString.save.toUpperCase(),
                              style: const TextStyle(
                                color: AppColor.dark_text,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<ApiResponse<ErrorResponse>>(
            stream: _myAccountBloc.profileStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    Future.delayed(Duration(milliseconds: 200), () {
                      Utils.commonProgressDialog(context);
                    });
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                    );
                    break;
                  case Status.COMPLETED:
                    {
                      debugPrint("completed");
                      Navigator.pop(context);
                      Future.delayed(Duration(milliseconds: 100), () {
                        _loginComplete();
                      });
                    }
                    break;
                  case Status.ERROR:
                    {
                      Navigator.pop(context);
                      Future.delayed(Duration(milliseconds: 100), () {
                        debugPrint("Error error ${snapshot.data.data.message}");
                        _showErrorDialog(
                          icon: Icon(
                            FontAwesomeIcons.exclamationCircle,
                            color: AppColor.red_500,
                          ),
                          title: AppString.sorry,
                          content: AppString.check_your_internet_connectivity,
                          buttonText: AppString.ok.toUpperCase(),
                          onPressed: () => Navigator.pop(context),
                        );
                      });
                    }
                    break;
                }
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  _updateUserInfo() {
    Utils.checkConnectivity().then((value) {
      if (value) {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _myAccountBloc.updateUserInfoApi(
              context: context,
              userId: _emailController.text,
              data: _userDataModel());
        }
      } else {
        _showErrorDialog(
          icon: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: AppColor.orange_500,
          ),
          title: AppString.sorry.toUpperCase(),
          content: AppString.check_your_internet_connectivity,
          buttonText: AppString.ok.toUpperCase(),
          onPressed: () => Navigator.pop(context),
        );
      }
    });
  }

  UpdateUserModel _userDataModel() {
    UpdateUserModel updateUserModel = UpdateUserModel();
    updateUserModel.title = _getGender();
    updateUserModel.firstName = _firstNameController.text;
    updateUserModel.lastName = _lastNameController.text;
    updateUserModel.dateOfBirthAccuracy = "actual";
    updateUserModel.dateOfBirth = _selectedDate == null
        ? Utils.uploadDateFormat(_dobController.text)
        : Utils.dateConvert(_selectedDate.toString(), AppString.DATE_FORMAT);
    updateUserModel.cellNumberList = _getCellNumberList();
    return updateUserModel;
  }

  String _getGender() {
    String gender = "";
    if (_groupValue == 0) {
      gender = AppString.USER_GENDER_MALE;
    } else if (_groupValue == 1) {
      gender = AppString.USER_GENDER_FEMALE;
    } else {
      gender = "unknown";
    }
    return gender;
  }

  List<CellNumberList> _getCellNumberList() {
    List<CellNumberList> _cellNumberList = [];
    CellNumberList _cellNumber =
        CellNumberList(data: _phoneController.text ?? "", type: 'mobile');
    _cellNumberList.add(_cellNumber);
    return _cellNumberList;
  }

  void _loginComplete() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: a1.value,
              child: AlertDialog(
                contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                content: Container(
                  height: 100,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30, top: 15),
                        child: const Text(
                          AppString.your_account_updated_successfully,
                          style: const TextStyle(
                            color: AppColor.dark_text,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              child: const Text(
                                AppString.home_page,
                                style: const TextStyle(
                                  color: AppColor.dark_text,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppString.HOME_SCREEN_ROUTE,
                                    (route) => false);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                AppString.settings,
                                style: const TextStyle(
                                  color: AppColor.dark_text,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                // App.pushTo(
                                //   context: context,
                                //   screen: Settings(),
                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
