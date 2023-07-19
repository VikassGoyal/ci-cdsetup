library flutter_dialpad;

import 'package:conet/models/allContacts.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dtmf/dtmf.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialPadCustom extends StatefulWidget {
  final ValueSetter<String>? makeCall;
  List<AllContacts>? contactList = [];
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? dialButtonColor;
  final Color? dialButtonIconColor;
  final Color? backspaceButtonIconColor;
  final String? outputMask;
  final bool? enableDtmf;

  DialPadCustom({
    super.key,
    this.makeCall,
    this.outputMask,
    this.buttonColor,
    this.buttonTextColor,
    this.dialButtonColor,
    this.dialButtonIconColor,
    this.backspaceButtonIconColor,
    this.enableDtmf,
    this.contactList,
  });

  @override
  State<DialPadCustom> createState() => _DialPadCustomState();
}

class _DialPadCustomState extends State<DialPadCustom> {
  final RegExp _regex = RegExp(r'^[0-9*#]+$');

  TextEditingController? textEditingController;
  List<AllContacts>? _loadedcontacts = [];
  bool _contactNameVisible = false;
  var _contactName = "";

  var _value = "";
  var mainTitle = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "＃"];
  var subTitle = ["", "ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ", null, "+", null];

  @override
  void initState() {
    textEditingController = TextEditingController();
    _loadedcontacts = widget.contactList;
    super.initState();

    // print(_loadedcontacts[0].phone);
  }

  _setText(String? value, bool longPress) async {
    if (widget.enableDtmf!) {
      Dtmf.playTone(digits: value!);
    }
    print(textEditingController!.text.length);
    if (textEditingController!.text.length == 27) {
      return;
    }

    if (value == "0" && longPress) {
      setState(() {
        _value += "+";
        textEditingController!.text = _value;
      });
    } else {
      setState(() {
        _value += value!;

        textEditingController!.text = _value;

        print(textEditingController!.text);
      });
    }

    getContactName();
  }

  List<Widget> _getDialerButtons() {
    var rows = <Widget>[];
    var items = <Widget>[];

    for (var i = 0; i < mainTitle.length; i++) {
      if (i % 3 == 0 && i > 0) {
        rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
        rows.add(SizedBox(height: 12.h));
        items = <Widget>[];
      }

      items.add(
        DialButton(
          title: mainTitle[i],
          subtitle: subTitle[i],
          color: widget.buttonColor,
          textColor: widget.buttonTextColor!,
          onTap: (value) {
            _setText(value, false);
          },
          onLongPress: (value) {
            _setText(value, true);
          },
        ),
      );
    }
    //To Do: Fix this workaround for last row
    rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
    rows.add(
      SizedBox(height: 12.h),
    );

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              enableInteractiveSelection: false,
              scrollPhysics: const BouncingScrollPhysics(),
              readOnly: true,
              style: TextStyle(
                fontFamily: kSfproRoundedFontFamily,
                // color: AppColor.accentColor,
                // color: AppColor.primaryColor,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 34.sp,
              ),
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: InputBorder.none),
              controller: textEditingController,
            ),
          ),
          _contactNameVisible
              ? SizedBox(
                  height: 20.h,
                  child: Text(
                    _contactName,
                    style: TextStyle(
                      fontFamily: kSfproRoundedFontFamily,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                )
              : SizedBox(height: 20.h),
          SizedBox(height: 44.h),
          ..._getDialerButtons(),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: _value.isEmpty
                    ? null
                    : () {
                        if (_value.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddContact(
                                phoneNumber: _value,
                              ),
                            ),
                          );
                        }
                      },
                child: Icon(
                  Icons.person_add,
                  size: 26.w,
                  color: _value.isNotEmpty ? (widget.backspaceButtonIconColor ?? Colors.white24) : Colors.white24,
                ),
              ),
              DialButton(
                icon: Icons.phone,
                title: textEditingController?.text ?? '',
                color: AppColor.accentColor,
                onTap: (value) {
                  widget.makeCall!(_value);
                },
              ),
              GestureDetector(
                onTap: _value.isEmpty
                    ? null
                    : () {
                        if (_value.isNotEmpty) {
                          setState(
                            () {
                              _value = _value.substring(0, _value.length - 1);
                              textEditingController!.text = _value;
                              _contactNameVisible = false;
                            },
                          );
                          getContactName();
                        }
                      },
                onLongPress: () {
                  print("onLongPress");
                  print(_value);

                  setState(
                    () {
                      _value = "";
                      textEditingController!.text = _value;
                      _contactNameVisible = false;
                    },
                  );
                },
                onLongPressStart: (_) async {
                  print("onLongPressStart");
                },
                // onLongPressDown: (_) async {
                //   print("onLongPressDown");
                // },
                onForcePressStart: (_) async {
                  print("onForcePressStart");
                },
                onSecondaryLongPress: () async {
                  print("onSecondaryLongPress");
                },
                child: Icon(
                  Icons.backspace,
                  size: 26.w,
                  color: _value.isNotEmpty ? (widget.backspaceButtonIconColor ?? Colors.white24) : Colors.white24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  getContactName() {
    // var number = "+91 6369 488 654";
    // var numberspace = number.replaceAll(' ', '');

    // print(numberspace);
    // print(numberfinal);
    // var contactNumber =
    //     number.replaceAll(' ', '').substring(number.replaceAll(' ', '').length);

    // print("contactNumber");
    // List<AllContacts> data = _loadedcontacts
    //         !.where((element) => getTrimedNumber(element.phone) == "9841024707")
    //         .toList();

    setState(() {
      // if (_value.length == 10) {
      try {
        // _value = _value.replaceAll(',', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '');
        // List<AllContacts> data = _loadedcontacts!
        //     .where((element) =>
        //         element.phone!
        //             .replaceAll(',', '')
        //             .replaceAll('(', '')
        //             .replaceAll(')', '')
        //             .replaceAll(' ', '')
        //             .replaceAll('-', '') ==
        //         _value)
        //     .toList();
        List<AllContacts> data = _loadedcontacts!
            .where((element) =>
                element.phone!
                    .replaceAll(RegExp(r'[\s(),-]'), '') // Remove spaces, parentheses, commas, and hyphens
                    .toLowerCase() ==
                _value.toLowerCase()) // Compare case-insensitively
            .toList();
        print(data);
        // print(data[0].name);
        if (data.isNotEmpty) {
          _contactNameVisible = true;
          _contactName = data[0].name!;
        }
      } catch (e) {
        print("Err");
        print(e);
        _contactNameVisible = false;
        _contactName = "";
      }
      // } else {
      //   _contactNameVisible = false;
      //   _contactName = "";
      // }
    });
  }
}

class DialButton extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final ValueSetter<String?>? onTap;
  final ValueSetter<String?>? onLongPress;
  final bool? shouldAnimate;
  const DialButton(
      {super.key,
      this.title,
      this.subtitle,
      this.color,
      this.textColor,
      this.icon,
      this.iconColor,
      this.shouldAnimate,
      this.onLongPress,
      this.onTap});

  @override
  State<DialButton> createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton> {
  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.title != null) {
          widget.onTap!(widget.title!);
        }
      },
      onLongPress: () {
        if (widget.title != null && widget.onLongPress != null) {
          widget.onLongPress!(widget.title!);
        }
      },
      child: widget.icon == null
          ? Container(
              color: widget.color,
              height: 55.w,
              width: 65.w,
              child: Column(
                children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                          "${widget.title}",
                          style: TextStyle(
                              fontFamily: kSfproRoundedFontFamily,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: widget.textColor ?? Colors.white),
                        ),
                      ),
                    ] +
                    (widget.subtitle != null
                        ? [
                            Text(
                              "${widget.subtitle}",
                              style: TextStyle(
                                  fontFamily: kSfproRoundedFontFamily,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4.sp,
                                  color: widget.textColor ?? Colors.white),
                            )
                          ]
                        : []),
              ),
            )
          : ClipOval(
              child: Container(
                height: 65.w,
                width: 65.w,
                color: Colors.green,
                child: Icon(
                  widget.icon,
                  size: 34.w,
                  color: widget.iconColor ?? Colors.white,
                ),
              ),
            ),
    );
  }
}
