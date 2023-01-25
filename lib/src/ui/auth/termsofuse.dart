import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
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
          "CONET Terms of use",
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.apply(color: AppColor.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10),
            // Center(
            //   child: Text(
            //     "CONET Terms of use",
            //     style: Theme.of(context)
            //         .textTheme
            //         .headline1
            //         ?.apply(color: AppColor.whiteColor),
            //   ),
            // ),
            const SizedBox(height: 10),
            Text(
              "UVM Enterprises Private Limited (“CONET” or “we”) offers users (“Users” or “You”) global phone community services transacted through various software applications and services, including but not limited to the “CONET” application. These Terms of Service and the CONET Privacy Policy (the “Terms”) will govern Your use of CONET’s software applications, websites, web service API, tools or other services and features provided by CONET from time to time (collectively “Services”). By accessing or using any of the Services, You agree to be bound by these Terms. By using the CONET application You confirm that You are a resident of the country outside Europe to which the international dialing code of the phone number that you have registered for access to our Services belongs. Where other third party services are made available as part of our Services, then the respective third party terms of service and privacy policy shall apply to any such use by You. If You are registering with CONET as a business entity, You represent that You have the authority to legally bind that entity. For CONET SDK and CONET Priority Users specific terms apply in accordance with the respective agreements for such services. For API Users, additional provisions apply in accordance with the API License Addendum (which is incorporated by reference into these Terms). \n\nCertain features of the Services may be subject to additional guidelines, terms or rules, which will be posted in or on the Services in connection with such features. All such additional terms, guidelines and rules are incorporated by reference into these Terms.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "1. PERSONAL INFORMATION",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "We are firmly committed to the security and protection of personal information of our Users and the Services. The CONET Privacy Policy describes how we collect, use, share and process personal information and You acknowledge and agree that CONET may collect, use, share and process personal information as described therein.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "2. GRANT OF RIGHTS",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "Except as otherwise agreed separately in writing between us or as set forth in the API License Addendum and subject to Your compliance with these Terms at all times, CONET grants You a personal, non-exclusive, non-transferable and limited right to use the Services for Your own personal, non-commercial use. You are not allowed to use the CONET Services on any device that You do not own or control. You may not copy, decompile, reverse engineer, disassemble, attempt to derive the source code of, modify, or create derivative works of the CONET software applications, any updates, or any part thereof (except as and only to the extent any foregoing restriction is prohibited by applicable law or to the extent expressly permitted by these Terms or may be permitted by the licensing terms governing use of any open source components included in the CONET software applications).\n\nYou are not granted any right to use CONET’s name, trademarks or other commercial symbols. All rights not expressly granted to You under these Terms shall be retained by CONET.\n\nIn case You wish to use any part of the Services as a part of Your own application or modify any part of the Services, such use is subject to CONET’s prior written approval and that You enter into a separate license agreement with CONET. Any API, commercial or enterprise use of the Services shall be governed by the API License Addendum or such other separate agreement as may be required by CONET.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "3. SUPPORT",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "CONET strives to provide adequate and efficient technical support, upgrades and updates for the Services. CONET shall, however, not be under any obligation to provide support or maintenance for the Services under these Terms and reserves the right to limit or discontinue the support, upgrades and updates provided from time to time.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "4. USER OBLIGATIONS AND RESTRICTIONS",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "You guarantee that any information and other content, such as Your profile information and information regarding the contacts contained in Your device’s phone book, that You may share with CONET as a User of the Services (together “Content”), to the best of Your knowledge, is correct, not in violation of applicable law, will not corrupt or disrupt the Services, and that you have the right to share the Content with CONET in order for CONET to provide the Services and share the Content with other Users. Except as otherwise agreed separately in writing between us, or as set forth in the API License Addendum, You shall not make any commercial use of the Services or the Content or otherwise transfer for value the Services or the Content. You agree not to challenge CONET's rights in, or otherwise attempt to assert any rights in, the Services or any Content provided by other Users, except those rights explicitly granted under these Terms. You agree to use the Services and Content only as expressly permitted under these Terms.\n\nYou agree not to use the Services, Content or information to attempt to circumvent the regular operation of the Services, or reduce the fees or consideration that we may derive from the Services by any means including by creating multiple accounts, redirecting traffic, following other fraudulent or deceptive practices, creating a parallel repository thereof, or seeking to by-pass the Services or compete with us.\n\nScraping of any information contained in the Services, by use of automated systems or software to extract data, including any Content and any third party information accessible via the Services, is strictly prohibited.\n\nYou may not use the Services or the Content in any way, which is illegal, harmful, or may be considered offensive by CONET, other Users or third parties. You agree not to exploit the Services or the Content in any unauthorized way whatsoever, including but not limited to, trespassing or burdening network capacity. You further agree not to use our Services or Content in any manner to harass, abuse, stalk, threaten, defame or otherwise infringe or violate the rights of any other party, and You acknowledge and agree that CONET is not in any way responsible for any such use by You, nor for any harassing, threatening, defamatory, offensive or illegal messages or transmissions that\n\nYou may receive as a result of using the Services. Notwithstanding any other remedies available to CONET, You agree that CONET may suspend or terminate Your use of the Services without notice if You use the Services or the Content in any prohibited manner, and that such use will be deemed a material breach of these Terms.\n\nYou may not use or otherwise export or re-export the Services except as authorized by United States law and the laws of the jurisdiction in which the Services were obtained. In particular, but without limitation, the Services may not be exported, re-exported or otherwise made available (a) into any country or region embargoed by the U.S. Government, or (b) to anyone on the U.S. Treasury Department's Specially Designated Nationals List or the U.S. Department of Commerce Denied Persons List or Entity List. By using the Services, you represent and warrant that you are not located in any such country or on any such list. If You obtain access to any subscription based Services in breach of these Terms, we reserve the right to cancel such subscription without any refund of fees in accordance with applicable law. You may contact CONET at theconetapp@gmail.com to report any violation or infringement of Your rights by Users of the Services.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "5. PROPRIETARY RIGHTS",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "The Services are protected by copyright laws and international copyright treaties, as well as other intellectual property laws and treaties. CONET and its licensors shall retain ownership in and to the Services and to all related intellectual property rights, including without limitation copyrights, trademarks, trade names, database rights and patents. You are granted only a limited right to use the Services subject to these Terms and no intellectual property rights are or will deemed to be transferred or licensed to You except as contemplated herein.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "6. CONTENT",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "You are solely liable for any content that You post or communicate directly in or on the Services and You agree to only post or communicate content that:\n\na. is true and not false or misleading;\n\nb. Is not likely to be deemed threatening, disparaging, defamatory, pornographic, racially or ethnically offensive, discriminatory, insulting, slanderous or otherwise illegal or inappropriate;\n\nc. belongs to You, or which You have a right to distribute;\n\nd. does not constitute an infringement of the intellectual property or privacy rights of any third party;\n\ne. does not constitute information that you are not legally entitled to distribute (such as insider information or confidential information);\n\nf. does not contain any unsolicited or unauthorised advertising, promotional material, “junk mail”, “spam”, “chain letters”, “pyramid schemes” or any other form of solicitation; and\n\ng. does not contain software virus or any other technology that may harm the Services, or the interests or property of our Services or the other Users of the Services.\n\nh. is accurate, fair, and is not disparaging of us, the Services or other Users. Further, You agree to be fair, accurate and non-disparaging while reporting numbers, leaving comments, suggestions, feedback, testimonials and reviews on or about the Services.\n\nCONET appreciates the opportunity to be notified of any objectionable user generated content posted or communicated by a User directly in or on the Services. Please contact us at theconetapp@gmail.com to report any objectionable user generated content. CONET hereby reserves the right in its absolute discretion to remove any user generated content from the Services.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "7. THIRD PARTY CONTENT",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "The Services may contain links to external content provided by third party websites and services. Such third party content, websites and services may be subject to the respective third party terms and conditions and CONET will not be liable for any such third party content, websites or services.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "8. DISCLAIMER OF WARRANTIES",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, CONET MAKES NO WARRANTY OR REPRESENTATION, EITHER EXPRESS OR IMPLIED WITH RESPECT TO THE SERVICES, THEIR QUALITY, PERFORMANCE, MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT OF THIRD PARTY RIGHTS. THE SERVICES ARE PROVIDED “AS IS” AND YOU AGREE THAT THE SERVICES ARE USED AT YOUR OWN RISK.\n\nYou understand and acknowledge that the Services may be unavailable from time to time and that CONET will not be liable for Your inability to use the Services for whatever reason.\n\nCONET makes no warranty or representation that the Services are available for use in any particular location. To the extent You choose to access and use the Services, You do so at Your own initiative and are responsible for compliance with any applicable laws in connection with such access and use of the Services.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "9. LIMITATION OF LIABILITY",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, YOU EXPRESSLY AGREE THAT CONET SHALL IN NO EVENT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL, INCIDENTAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES, INCLUDING BUT NOT LIMITED TO DAMAGES FOR LOSS OF PROFITS, DATA AND GOODWILL, ARISING OUT OF THE USE OR INABILITY TO USE THE SERVICES OR THE CONTENT, even if advised of the possibility of such damages. In particular, and without limitation, CONET shall have no liability for any information stored or processed within the Services, including the costs of recovering such information. Your only right or remedy with respect to any problems or dissatisfaction with the Services, is to uninstall the CONET applications and cease to use the Services.\n\nCONET SHALL NOT BE LIABLE FOR THE VALIDITY, RELIABILITY OR CORRECTNESS OF THE CONTENT AND INFORMATION PROVIDED THROUGH AND IN CONNECTION WITH USE OF THE SERVICES. ANY USE OF THE CONTENT AND INFORMATION OBTAINED THROUGH THE USE OF THE SERVICES SHALL BE AT YOUR OWN DISCRETION AND RISK.\n\nNothing in these Terms shall limit or exclude our liability for any liability that mandatorily cannot be limited or excluded by law, including any rights You may have as a consumer under mandatory consumer law.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "10. FEES",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "CONET offers certain features or services for which a fee will be payable (“Paid Services”). Your purchase of the Paid Services may be subject to foreign exchange fees or differences in prices based on location. If You purchase or subscribe to such Paid Services, You agree to pay us the applicable fees (“CONET Fees”) and taxes in accordance with the applicable third party payment and billing terms, based on the platform You are using, which are incorporated herein by reference. You will be charged the applicable fees and taxes during the subscription period unless You cancel the Paid Service, in which case You agree to still pay these fees through the end of the applicable subscription period. We may change the CONET Fees from time to time by posting the changes in or on the Services or by notifying You in advance. All fees are, except as otherwise expressly provided herein or as required by applicable law, non-refundable. Failure to pay these fees may result in suspension or termination of your Service or subscription.\n\nDepending on what platform You are using, prepaid fees for the Services may be connected to Your device as well as its phone number. Therefore, in some cases, if You change the device or its SIM-card, You cannot transfer the balance to a new device or SIM-card and no refund will be available in such cases. Any remaining balance of prepaid fees not used within twelve (12) months from the purchase will expire without any right of refund.\n\nYou acknowledge that You are fully responsible for the Internet connection and/or mobile charges that You may incur for using our Services. Please consult Your carrier, mobile operator, etc. for further information.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "11. TERMINATION",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "Your right to use the Services continues until these Terms are terminated. CONET may terminate the Terms and Your use of the Services at any time with thirty (30) days’ advance notice. You may terminate the Terms at any time by uninstalling the CONET applications and ceasing the use of the Services. These Terms will automatically terminate if You fail to comply with them. Upon any termination, You agree to cease using the Services. Upon termination by You, or by CONET due to Your breach of these Terms, You will not be refunded any license fees or other prepaid fees, if any. Upon termination by CONET without cause, You will be refunded any unused prepaid fees upon Your written request, provided a receipt of such fees and a clear payment instruction are included in Your request.\n\nProvisions of sections Disclaimer of Warranties, Limitation of Liability, Termination and Governing Law shall survive any termination of these Terms.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "12. ASSIGNMENT",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "CONET reserves the right, at its own discretion, to freely assign and transfer the rights and obligations under these Terms to any third party.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "13. ADDITIONAL TERMS AND CHANGES",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "As CONET provides global Services, additional Terms of Services may apply to Users in certain jurisdictions and will in such cases be made available in appendices and incorporated hereto.\n\nCONET may change the Services at any time, such as by adding or removing features or discontinuing the Services. CONET also reserves the right to modify these Terms at any time by providing revised Terms to the User or by publishing the revised Terms within the Services. In case of material changes, the User shall always be notified thereof and provided the option to immediately terminate the Services. If You choose to terminate the Services, You will be refunded any unused prepaid fees upon Your written request, provided a receipt of such fees and a clear payment instruction are included in Your request. The revised Terms shall become effective upon such publishing or notification to the User. You will always find the latest version of these Terms at www.CONETAPP.IN. Any continued use by You of the Services following publication or notification of revised Terms shall constitute Your acceptance to the revised Terms.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "14. DISPUTE RESOLUTION",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "All disputes, differences and/or claims, which may at any time arise between the parties hereto or any person claiming under them in respect of this agreement whether during its subsistence and thereafter shall be settled by Arbitration in accordance with the provisions of the Arbitration and Conciliation Act, 1996 or any statutory amendments thereof and shall be referred to a three member Arbitrator panel, each party nominates one arbitrator and the two nominated arbitrators jointly appoint the third arbitrator (umpire). The award of the sole arbitrator shall be final and binding on all the parties to this agreement and enforceable according to the laws in India.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              "15. GOVERNING LAW",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(color: AppColor.whiteColor),
            ),
            const SizedBox(height: 10),
            Text(
              "These Terms shall be governed and construed in accordance with the laws of India.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: AppColor.whiteColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
