import 'package:conet/src/common_widgets/remove_scroll_glow.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: AppColor.whiteColor,
          ),
        ),
        title: Text(
          "KONET Privacy Policy",
          style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
        ),
      ),
      body: ScrollConfiguration(
        behavior: RemoveScrollGlow(),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 10),
              // Center(
              //   child: Text(
              //     "KONET Terms of use",
              //     style: Theme.of(context)
              //         .textTheme
              //         .headline1
              //         ?.apply(color: AppColor.whiteColor),
              //   ),
              // ),
              const SizedBox(height: 10),
              Text(
                "KONET is firmly committed to the security and protection of personal information of our Users and their contacts. This Privacy Policy describes how KONET will collect, use, share and process personal information. Capitalized terms not defined in this Privacy Policy are defined in the KONET Terms of Service.\n\nBy accepting the KONET Privacy Policy and/or using the Services You consent to the collection, use, sharing and processing of personal information as described herein. If You provide us with personal information about someone else, You confirm that they are aware that You have provided their information and that they consent to our use of their information according to our Privacy Policy. You may opt-out at any time to prevent further use of the information shared via the Services.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "1. PERSONAL INFORMATION COLLECTED",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "1.1 USER PROFILE",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "When You create a user profile in the Services and confirm being the holder of a certain number, KONET will collect the information provided by You. In order to create a user profile, You must register Your first name, last name and phone number. Additional information that may be provided at Your option include, but is not limited to, photo, gender, street address and zip code, country of residence, email address, work information, professional website, Facebook page, Twitter address, work tagwords and a short status message. KONET may supplement the information provided by You with information from third parties and add it to the information provided by You e.g. demographic information and additional contact information that is publicly available.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "1.2 INSTALLATION AND USE",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "When You install and use the Services, KONET will collect personal information from You and any devices You may use in Your interaction with our Services. This information may include e.g.: geo-location; Your IP address; device ID or unique identifier; device manufacturer and type; device and hardware settings; SIM card usage; applications installed on your device; ID for advertising; ad data, operating system; web browser; operator; IMSI; connection information; screen resolution; usage statistics; default communication applications; access to device address book; device log and event information; logs, keywords and meta data of incoming and outgoing calls and messages; version of the Services You use and other information based on Your interaction with our Services such as how the Services are being accessed (via another service, web site or a search engine); the pages You visit and features you use on the Services; the services and websites You engage with from the Services; content viewed by You, content You have commented on or sent to us and information about the ads You see and/or engage with; the search terms You use; order information and other usage activity and data logged by KONET’s servers from time to time. KONET may collect some of this information automatically through use of cookies and You can learn more about our use of cookies in our Cookie Policy.\n\nSome information, including, but not limited to, usage information and other information that may arise from Your interaction with the Services, cannot be used to identify You, whether in combination with other information or otherwise and will not constitute personal information for the purposes of this Policy.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "1.3 THIRD PARTY SERVICES",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "You may provide us with Your user identifier information regarding, or to enable Your usage of, certain third party services (together with a mapped photo where applicable) e.g. social networking services and payment services, in order for the Services to interoperate with such third party services. You may use such third party services to create Your user profile or log in to our Services, share information with such third party services, or to connect Your user profile with the respective third party services. Such third party services may automatically provide us with access to certain personal information retained by them about You (e.g., your payment handle, unique identification information, content viewed by You, content liked by You and information about the advertisements You have been shown or may have clicked on) and You agree that we may collect, use and retain the information provided by these third party services in accordance with this Privacy Policy. You may be able to control the personal information You allow us to have access to through the privacy settings on the respective third party service. We will never store any passwords created for any third party services.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "1.4 CONTACT INFORMATION",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "Where the KONET mobile applications (“KONET Apps”) are obtained from other sources than Apple App Store or Google Play, You may share the names, numbers, Google ID’s and email addresses contained in Your address book (“Contact Information”) with KONET by enabling the KONET Enhanced Search Functionality. Where the KONET Apps are obtained from Apple App Store or Google Play, we do not share any user Contact Information. In addition to Contact Information, if You choose to activate use of a third party service, such as social networks services, within the Services, KONET may collect, store and use the list of identifiers associated with said services linked to the Contact Information in order to enhance the results shared with other Users.\n\n\nPlease note that no other contact information other than the phone numbers and thereto attached names, Google ID’s and email addresses will be collected and used from Your address book. Other numbers or information that may be contained in Your address book will be filtered away by our safety algorithms and will therefore not be collected by KONET. Please also note that You can always choose not to share Contact Information with KONET and if You have shared such information and changed Your mind, You can delist Your number or opt-out to render Your entire Contact Information unavailable for search in the KONET database.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "1.5 OTHER INFORMATION YOU MAY PROVIDE",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "You may provide us with various information in connection with Your interaction with our Services. For example, You may through tagging functionality associate a phone number, that is not registered in the KONET database or belongs to a User,\n\nwith a business or name and You may report a phone number as spam or some other attribute to be included in spam blocking directories. KONET may also from time to time offer You the opportunity to provide information on Your experience from using the Services or to participate in contests, surveys or other promotions. KONET will collect the information You provide in connection therewith, as well as any other information You provide through the Services or when You communicate or interact with us.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "2. USE OF PERSONAL INFORMATION",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "2.1 PROVIDE, IMPROVE AND PERSONALIZE OUR SERVICES",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "KONET may use the personal information collected to provide, maintain, improve, analyze and personalize the Services to its Users, partners and third party providers. More specifically, KONET may use such information to:\n\na. provide smart caller ID, dialer and messaging functionality that, among other features, allow for population of unidentified numbers and other data in call or message logs, display the name associated with a certain number for incoming or outgoing calls and messages or following a manual number search against the KONET database;\n\nb. display the number associated with a certain name following a manual name search against the KONET database, subject to that name searches will only produce a number linked to the name if the number is available for search in a public database or relates to a User who has made his or her name available for search, provide Your information to the person You reach out to when requesting a contact via the KONET name search service, in which case Your request will be forwarded to that person via an SMS and he/she may choose whether or not to share the phone number with You at his/her own discretion;\n\nc. display information based on connections a User may have in common, directly or indirectly, with other Users via a “social graph” algorithm, display the “who viewed my profile” and “availability” functionalities of the Services;\n\nd. send in application push notifications and reminders and deliver messages via the Services, in which case Your messages will be kept for a limited period of time in order to deliver the messages but KONET will not, unless specifically stated, monitor the content of Your messages;\n\ne. maintain User spam lists and build a community based spam blocking directory;\n\nf. enable You to use and share Your information in connection with Your registration, login or other use of third party services e.g. payment service providers, online services, social networking sites and other third party API’s; and\n\ng. otherwise improve our Services, business and operations.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "2.2 STATISTICAL DATA FROM THE SERVICES",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "We use aggregated or anonymized personal information for statistical and analytical purposes. We may come to share such data with third parties.\n\nWe do not consider personal information to include information that has been made anonymous or aggregated so that it can no longer be used to identify a specific person, whether in combination with other information or otherwise.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "2.3 PERSONALIZE OUR ADVERTISING AND COMMUNICATIONS",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "We may use any of the information collected, as set out above, to provide You with location and interest based advertising, marketing messaging, information and services. We may also use the collected information to measure the performance of our advertising and marketing services.\n\nWe may contact You for verification purposes or with information pertaining to the Services or special offers, e.g. newsletter e-mails, SMS and similar notifications about KONET’s and our business partners’ products and services. We also use the collected information to respond to you when you contact us.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "2.4 COMPLIANCE WITH LAWS AND PREVENTION OF FRAUDULENT OR ILLEGAL ACTIVITIES",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "We may use the collected information to comply with applicable laws and to enforce our agreements and protect and defend the rights or safety of KONET, its Users or any other person and verify provided User profile information with third party providers and ensure technical service functionality and data accuracy, perform trouble-shooting and prevent or detect fraud, security breaches or illegal activities.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "3. SHARING AND DISCLOSURE OF PERSONAL INFORMATION",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "In addition to the sharing and disclosure of personal information that is included as part of the functionality of the Services as described in section 2 above, KONET may disclose personal information if we believe such action is necessary to:\n\na. comply with the law, or legal process served on us;\n\nb. protect and defend our rights and the enforcement of our agreements; or\n\nc. protect the security and safety of Users or members of the public or other aspects of public importance, provided, of course, that such disclosure is lawful.\n\nWe transfer information to trusted vendors, service providers, and other partners who support our business and Services, such as providing technical infrastructure services, bug testing, analyzing how our Services are used, measuring the effectiveness of ads and services and facilitating payments as well as potential partners who may wish to work with us to provide other services. KONET will always require these third parties to take appropriate organizational and technical measures to protect personal information and to observe applicable legislation. KONET may also share personal information with third party advertisers, agencies and networks. Such third parties may use this information for analytical and marketing purposes e.g. to provide measurement services and targeted ads and for improvement of products and services. The information may be collected by such third parties by use of cookies, or similar technologies, and You can learn more about the use of cookies in our Cookie Policy.\n\nWe may disclose and transfer Your Information to our associated or affiliated organisations or related entities and to any third party who acquires, our business, whether such acquisition is by way of merger, consolidation or purchase of all or a substantial portion of our assets.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "4. DELISTING OF CONTACT INFORMATION AND OPT-OUT OF AD TARGETING",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "If a User chooses to disable the Enhanced Search Functionality, the Contact Information made available by that User is disabled and will thereafter not be available for search in the KONET database. If any persons do not wish to have their names and phone numbers made available through the Enhanced Search or Name Search functionalities, they can exclude themselves from further queries by notifying KONET via its website at www.KONETAPP.in or as set forth in the contact details below. You acknowledge and agree that KONET may keep and process personal information related to such request in order to be able to honor the request.\n\nYou can limit or opt-out of the collection and use of Your information for ad targeting by third parties via Your device settings.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "5. INFORMATION SECURITY AND TRANSFER OF PERSONAL INFORMATION TO OTHER COUNTRIES",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "In order to provide the Services, KONET will transfer, process and store personal information in a number of countries, including but not limited to India, and may also use cloud based services for this purpose. KONET may also subcontract storage or processing of Your information to third parties located in countries other than Your home country. Information collected within one country may, for example, be transferred to and processed in another country, which may not provide the same level of protection for personal data as the country in which it was collected. You acknowledge and agree that KONET may transfer Your personal information as described above for purposes consistent with this Privacy Policy. We take all reasonable precautions to protect personal information from misuse, loss and unauthorized access. KONET has implemented physical, electronic, and procedural safeguards in order to protect the information, including that the information will be stored on secured servers and protected by secured networks to which access is limited to a few authorized employees and personnel. However, no method of transmission over the Internet or method of electronic storage is 100% secure.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "6. ACCESSING AND UPDATING PERSONAL INFORMATION",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "KONET may on its own initiative, or at Your request, replenish, rectify or erase any incomplete, inaccurate or outdated personal information retained by KONET in connection with the operation of the Services. When required by applicable law, You have the right to know what personal information is stored about You and to have any such information corrected or deleted on Your request. See contact details below.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "7. MINORS",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "Services are not intended for or designed to attract anyone under the relevant age of consent to enter into binding legal contracts under the laws of their respective jurisdictions. KONET does not intentionally or knowingly collect personal information through the Services from anyone under that age. We encourage parents and guardians to be involved in the online activities of their children to ensure that no personal information is collected from a child without their consent.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "8. CHANGES TO THIS PRIVACY POLICY",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "KONET may at any time with or without a separate notice change this Privacy Policy, and You are encouraged to review this Policy from time to time. In case of substantial changes, KONET will notify the Users by push notice or via notice in the Services. Your continued use of the Services after a notice of changes has been communicated to You or published on our Services shall constitute consent to the changed policy.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "9. COOKIES As described in our Cookie Policy, we use cookies, web beacons, flash cookies, HTML 5 cookies, pixel tags and other web application software methods, including mobile application identifiers, to help us recognize you across the Services, learn about your interests both on and off the Services, improve your experience, increase security, measure use and effectiveness of the Services, and serve advertising. You can control Cookies through your browser settings and other tools. By interacting with the Services, you consent to the use and placement of Cookies on your device in accordance with this Privacy Policy, which by reference incorporates our Cookie Policy.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "10. CONTACT",
                style: Theme.of(context).textTheme.headline2?.apply(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 10),
              Text(
                "If You have any additional questions about KONET’s Privacy Policy or want to make a request regarding certain personal information, You are encouraged to contact KONET. The contact information is:\n\nUVM ENTERPRISES PRIVATE LIMITED: NO 112, NUNGAMBAKKAM HIGH ROAD, ELDORADO BUILDING, 6TH FLOOR, 6A, CHENNAI, TAMIL NADU 600034\n\nYou can also send Your enquiries (including in relation to any grievances to our Grievances Officer) via email to theconetapp@gmail.com.",
                style: Theme.of(context).textTheme.bodyText1?.apply(color: AppColor.whiteColor),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
