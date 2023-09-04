import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';

import 'modal/ContactInfo.dart';

class AZContactList extends StatefulWidget {
  const AZContactList({Key? key}) : super(key: key);

  @override
  State<AZContactList> createState() => _AZContactListState();
}

class _AZContactListState extends State<AZContactList> {
  final List<ContactInfo> _contacts = [];
  double susItemHeight = 40;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    rootBundle.loadString('assets/data/contacts.json').then((value) {
      List list = json.decode(value);
      for (var v in list) {
        _contacts.add(ContactInfo.fromJson(v));
      }
      _handleList(_contacts);

      print(_contacts);
    });
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;

    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(_contacts);
    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_contacts);
    setState(() {});
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: susItemHeight,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            susTag,
            textScaleFactor: 1.2,
          ),
          const Expanded(
              child: Divider(
            height: .0,
            indent: 10.0,
          ))
        ],
      ),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[700],
            child: Text(
              model.name![0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text("${model.name}"),
          onTap: () {
            print("OnItemClick: $model");
            Navigator.pop(context, model);
          },
        )
      ],
    );
  }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[300]!, width: .5));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AzListView Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'AzListView',
          ),
        ),
        body: AzListView(
          data: _contacts,
          itemCount: _contacts.length,
          itemBuilder: (BuildContext context, int index) {
            ContactInfo model = _contacts[index];
            return _buildListItem(model);
          },
          physics: const BouncingScrollPhysics(),
          indexBarData: SuspensionUtil.getTagIndexList(_contacts),
          indexHintBuilder: (context, hint) {
            return Container(
              alignment: Alignment.center,
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.blue[700]!.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: Text(hint, style: const TextStyle(color: Colors.white, fontSize: 30.0)),
            );
          },
          indexBarMargin: const EdgeInsets.all(10),
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            decoration: getIndexBarDecoration(Colors.grey[50]!),
            downDecoration: getIndexBarDecoration(Colors.grey[200]!),
          ),
        ),
      ),
    );
  }
}
