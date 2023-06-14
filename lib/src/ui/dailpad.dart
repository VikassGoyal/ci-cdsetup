library flutter_dialpad;

import 'dart:async';

import 'package:conet/models/allContacts.dart';
import 'package:conet/src/ui/contact/addContact.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dtmf/dtmf.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

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
  _DialPadCustomState createState() => _DialPadCustomState();
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

  _setText(String? value) async {
    if (widget.enableDtmf!) {
      Dtmf.playTone(digits: value!);
    }
    print(textEditingController!.text.length);
    if (textEditingController!.text.length == 17) {
      return;
    }

    setState(() {
      _value += value!;

      textEditingController!.text = _value;

      print(textEditingController!.text);
    });

    getContactName();
  }

  List<Widget> _getDialerButtons() {
    var rows = <Widget>[];
    var items = <Widget>[];

    for (var i = 0; i < mainTitle.length; i++) {
      if (i % 3 == 0 && i > 0) {
        rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
        rows.add(const SizedBox(
          height: 12,
        ));
        items = <Widget>[];
      }

      items.add(
        DialButton(
          title: mainTitle[i],
          subtitle: subTitle[i],
          color: widget.buttonColor,
          textColor: widget.buttonTextColor!,
          onTap: _setText,
        ),
      );
    }
    //To Do: Fix this workaround for last row
    rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
    rows.add(
      const SizedBox(
        height: 12,
      ),
    );

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.08852217;

    return Center(
      child: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              readOnly: true,
              style: TextStyle(
                fontFamily: 'Sfpro-Rounded-Semibold',
                inherit: true,
                color: AppColor.redColor,
                fontSize: sizeFactor / 2,
              ),
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: InputBorder.none),
              controller: textEditingController,
            ),
          ),
          _contactNameVisible
              ? SizedBox(
                  height: 20,
                  child: Text(
                    _contactName,
                    style: const TextStyle(
                      fontFamily: 'Sfpro-Rounded-Medium',
                      inherit: true,
                      fontSize: 16,
                      color: AppColor.blackColor,
                    ),
                  ),
                )
              : Container(
                  height: 20,
                ),
          const SizedBox(
            height: 44,
          ),
          ..._getDialerButtons(),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: screenSize.height * 0.0385504),
                  child: GestureDetector(
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
                      size: sizeFactor / 2,
                      color: _value.isNotEmpty ? (widget.backspaceButtonIconColor ?? Colors.white24) : Colors.white24,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: DialButton(
                    icon: Icons.phone,
                    color: AppColor.secondaryColor,
                    onTap: (value) {
                      widget.makeCall!(_value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: screenSize.height * 0.0685504),
                  child: GestureDetector(
                    onTap: _value.isEmpty
                        ? null
                        : () {
                            if (_value.isNotEmpty) {
                              setState(
                                () {
                                  _value = _value.substring(0, _value.length - 1);
                                  textEditingController!.text = _value;
                                },
                              );
                              getContactName();
                            }
                          },
                    onLongPress: () {
                      print("onLongPress");
                      print(_value);
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
                      size: sizeFactor / 2,
                      color: _value.isNotEmpty ? (widget.backspaceButtonIconColor ?? Colors.white24) : Colors.white24,
                    ),
                  ),
                ),
              )
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
        List<AllContacts> data = _loadedcontacts!.where((element) => element.phone == _value).toList();
        print(data);
        // print(data[0].name);
        _contactNameVisible = true;
        _contactName = data[0].name!;
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
  @override
  final Key? key;
  final String? title;
  final String? subtitle;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final ValueSetter<String?>? onTap;
  final bool? shouldAnimate;
  const DialButton(
      {this.key,
      this.title,
      this.subtitle,
      this.color,
      this.textColor,
      this.icon,
      this.iconColor,
      this.shouldAnimate,
      this.onTap});

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _colorTween;
  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _colorTween = ColorTween(begin: widget.color ?? Colors.white24, end: Colors.white).animate(_animationController!);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.shouldAnimate ?? false) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.0852217;

    return GestureDetector(
      onTap: () {
        if (widget.title != null) {
          widget.onTap!(widget.title!);
        }

        print(widget.title);

        //widget.onTap!(widget.title);

        //   if (widget.shouldAnimate!) {
        //     if (_animationController!.status == AnimationStatus.completed) {
        //       _animationController?.reverse();
        //     } else {
        //       _animationController?.forward();
        //       _timer = Timer(const Duration(milliseconds: 200), () {
        //         setState(() {
        //           _animationController?.reverse();
        //         });
        //       });
        //     }
        //   }
      },
      child: ClipOval(
        child: AnimatedBuilder(
          animation: _colorTween!,
          builder: (context, child) => Container(
            color: _colorTween!.value,
            height: sizeFactor,
            width: sizeFactor,
            child: Center(
              child: widget.icon == null
                  ? widget.subtitle != null
                      ? Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                "${widget.title}",
                                style: TextStyle(
                                    fontFamily: 'Sfpro-Rounded-Medium',
                                    inherit: true,
                                    fontSize: sizeFactor / 3,
                                    color: widget.textColor ?? Colors.white),
                              ),
                            ),
                            Text(
                              "${widget.subtitle}",
                              style: TextStyle(
                                  fontFamily: 'Sfpro-Rounded-Medium',
                                  inherit: true,
                                  color: widget.textColor ?? Colors.white),
                            )
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: widget.title == "*" ? 9 : 0),
                          child: Text(
                            "${widget.title}",
                            style: TextStyle(
                              fontFamily: 'Sfpro-Rounded-Medium',
                              inherit: true,
                              fontSize: widget.title == "*" || widget.title == "#" && widget.subtitle == null
                                  ? screenSize.height * 0.0762069
                                  : sizeFactor / 2,
                              color: widget.textColor ?? Colors.white,
                            ),
                          ),
                        )
                  : Icon(
                      widget.icon,
                      size: sizeFactor / 2,
                      color: widget.iconColor ?? Colors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
