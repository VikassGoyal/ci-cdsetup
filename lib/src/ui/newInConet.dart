import 'package:conet/models/allContacts.dart';
import 'package:conet/repositories/contactPageRepository.dart';
import 'package:conet/src/ui/contact/contactProfile.dart';
import 'package:conet/src/ui/contact/nonConetContactProfile.dart';
import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewConetUsers extends StatefulWidget {
  @override
  _NewConetUsersState createState() => _NewConetUsersState();
}

class _NewConetUsersState extends State<NewConetUsers> {
  ContactPageRepository? contactPageRepository;
  List<AllContacts> _contacts = [];
  bool _loader = true;

  @override
  void initState() {
    super.initState();
    _contacts = [];
    contactPageRepository = ContactPageRepository();
    getNewInConet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_sharp,
                color: AppColor.whiteColor,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                "Back",
                style: Theme.of(context).textTheme.bodyText2?.apply(color: AppColor.whiteColor),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "KoNet Joiners",
          style: Theme.of(context).textTheme.headline4?.apply(color: AppColor.whiteColor),
        ),
      ),
      body: _loader
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColor.primaryColor),
                  ),
                ],
              ),
            )
          : _contacts.isNotEmpty
              ? Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _contacts.length,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      );
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Theme.of(context).primaryColorLight,
                        onTap: () {
                          if (_contacts[index].userId != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NonConetContactProfile(
                                  _contacts[index].name,
                                  _contacts[index].phone,
                                  _contacts[index].email,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactProfile(
                                  _contacts[index].phone,
                                  _contacts[index].contactMetaId,
                                  _contacts[index].contactMetaType,
                                  _contacts[index].fromContactMetaType,
                                ),
                              ),
                            );
                          }
                        },
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getDateFormat(_contacts[index].contactMetaType),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: AppColor.gray30Color,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                _contacts[index].name ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          subtitle: Text(
                            "${_contacts[index].name ?? ""} joined KoNet!",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: AppColor.secondaryColor, fontWeight: FontWeight.w400),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 46,
                              height: 46,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/profile_placeholder.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/no_data.svg",
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "No Data",
                        style: Theme.of(context).textTheme.headline4?.apply(color: AppColor.blackColor),
                      )
                    ],
                  ),
                ),
    );
  }

  getNewInConet() async {
    try {
      var response = await contactPageRepository?.getNewInConet();

      setState(() {
        _loader = false;
      });
      if (response['status']) {
        _contacts = List<AllContacts>.from(response['data'].map((item) => AllContacts.fromJson(item)));
      }
    } catch (e) {
      setState(() {
        _loader = false;
      });
      print(e);
    }
  }
}
