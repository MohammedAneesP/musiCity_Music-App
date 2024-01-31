import 'package:flutter/material.dart';

import 'package:musi_city/functions/functions.dart';
import 'package:musi_city/screens/more_options/terms&conditions.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: musiCityBgColor,
      body: SafeArea(
        child: Column(
          children: [
            moreOptionHead(context, privacyPolicy),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    heightGapSizedBox(context),
                    moreoptionParaText(context, privacyPolicyPara1),
                    heightGapSizedBox(context),
                    moreOptinParaHead(context, privcypolcCollecUse),
                    heightGapSizedBox(context),
                    moreoptionParaText(context,privacyPolicyPara2 ),
                    heightGapSizedBox(context),
                    moreOptinParaHead(context, privcyPolcyCookies),
                    heightGapSizedBox(context),
                    moreoptionParaText(context, privacyPolicyPara3),
                    heightGapSizedBox(context),
                    moreOptinParaHead(context, paraContactText),
                    heightGapSizedBox(context),
                    moreoptionParaText(context, paraText3),
                    heightGapSizedBox(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String privcyPolcyCookies = "Cookies";
String privacyPolicy = "Privacy and Policy";
String privcypolcCollecUse = "Information collection and Use";

String privacyPolicyPara1 =
    "Mohammed Anees built the musiCity app as a Free app. This SERVICE is provided by Mohammed Anees at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Shelvin Varghese unless otherwise defined in this Privacy Policy.";
String privacyPolicyPara2 =
    " For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to tall man,. The information that I request will be retained on your device and is not collected by me in any way.\nThe app does use third-party services that may collect information used to identify you.";
String privacyPolicyPara3 =
    "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.";
