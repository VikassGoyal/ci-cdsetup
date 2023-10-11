import 'package:azlistview/azlistview.dart';
import 'package:conet/models/allContacts.dart';
import 'package:lpinyin/lpinyin.dart';

class ContactsHelper {
  static void handleAndSortContactsList(List<AllContacts> list) {
    Set<String> uniqueContacts = {};
    List<AllContacts> uniqueList = [];

    for (int i = 0; i < list.length; i++) {
      String? name = list[i].name ?? list[i].phone;
      String pinyin = PinyinHelper.getPinyinE(name!);
      String tag = pinyin.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
      // Create a unique key based on name and phone
      String contactKey = '${list[i].name}${list[i].phone}';
      if (!uniqueContacts.contains(contactKey)) {
        uniqueContacts.add(contactKey); // Add the unique key to the set
        uniqueList.add(list[i]); // Add the unique contact to the unique list
      }
    }

    //here sorting contacts list by tags and also by names
    _sortListBySuspensionTag(uniqueList);
    //here selecting the first contact for each tag to show in list
    SuspensionUtil.setShowSuspensionStatus(uniqueList);
    list.clear();
    list.addAll(uniqueList);
  }

  // Overridden this due to Error in AZListView
  static void _sortListBySuspensionTag(List<AllContacts> list) {
    if (list.isEmpty) return;
    list.sort((a, b) {
      if (RegExp("[A-Z]").hasMatch(a.getSuspensionTag()) && !RegExp("[A-Z]").hasMatch(b.getSuspensionTag())) {
        return -1;
      } else if (!RegExp("[A-Z]").hasMatch(a.getSuspensionTag()) && RegExp("[A-Z]").hasMatch(b.getSuspensionTag())) {
        return 1;
      } else if (RegExp("[A-Z]").hasMatch(a.getSuspensionTag()) && RegExp("[A-Z]").hasMatch(b.getSuspensionTag())) {
        final nameA = a.name?.toLowerCase() ?? '';
        final nameB = b.name?.toLowerCase() ?? '';
        return nameA.compareTo(nameB);
      } else if (a.getSuspensionTag() == "@" && b.getSuspensionTag() != "@") {
        return -1;
      } else if (a.getSuspensionTag() != "@" && b.getSuspensionTag() == "@") {
        return 1;
      } else if (a.getSuspensionTag() == "#" && b.getSuspensionTag() != "#") {
        return -1;
      } else if (a.getSuspensionTag() != "#" && b.getSuspensionTag() == "#") {
        return 1;
      } else {
        return a.getSuspensionTag().compareTo(b.getSuspensionTag());
      }
    });
  }
}
