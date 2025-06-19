import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/l10n/l10n.dart';

// ignore: must_be_immutable
class PrivacyPolicyPage extends StatelessWidget {
  String privacyPolicyContent = """
<h1>PRIVACY POLICY</h1>
<p>Welcome to {0} privacy policy. Thank you for taking the time to read.</p>
<p>We value your trust in providing us your information, and we will always uphold that trust. This begins with making sure you understand the information we collect, why we collect it, how that information is used, and your choices regarding your information. This policy describes our privacy practices in simple language, using legal and technical terms at a minimum level.</p>
<p>This privacy policy applies from 26/03/2024.</p>

<h3>1. Scope</h3>
<p>This privacy policy applies to the websites, apps, events, and other services operated by {0}. For simplicity, we refer to all of these as "services" in this privacy policy. To make it clearer, we have added links to this privacy policy on all existing services.</p>
<p>Some services may require separate privacy policies. If a service has a separate privacy policy, that policy will apply instead of this privacy policy.</p>

<h3>2. Information we collect</h3>
<p>We all understand that we cannot help you develop meaningful relationships without some information about you, such as basic information on profiles and the type of people you want to meet. We also collect information about your use of our services such as browsing history, and information from third parties, such as when you access our services via social media accounts or when you upload information from your social media account to complete your profile. If you want more information, we go into more detail below.</p>
<h4>Information you provide to us</h4>
<p>You decide to provide us with certain information when using our services. This includes:</p>
<ul>
  <li>When you create an account, you provide us with at least your location, your email address, along with some basic information necessary for the service, such as name, gender, date of birth, and your photo.</li>
  <li>When you complete your profile, you may share with us other information, such as biography, interests, and other information about you and contents such as where you study, current work, current residence ... To add a certain type of content like photos, you may allow us to access your camera or photo album.</li>
  <li>If you contact our customer care team, we collect information that you provide to us during the interaction.</li>
  <li>If you share information about others with us (for example, if you use a friend's contact information for a feature), we process this information on the basis of your authorization to fulfill that request.</li>
  <li>Of course, we also process your conversations with other members as well as the content you post, as it is necessary to operate the services.</li>
</ul>
<h4>Information we receive from other sources</h4>
<p>In addition to the information you directly provide to us, we receive information about you from other sources, including:</p>
<ul>
  <li><strong>Members</strong> Members may provide information about you when they use our services, such as when they interact with you or if they submit a report related to you.</li>
  <li><strong>Social networks</strong> You may decide to share information with us through your social media accounts, such as when you decide to create and log into your {0} account through your social media account or another account of yours (such as Facebook, Google, or Apple).</li>
  <li><strong>Other partners</strong> We may receive information about you from partners we link with to place {0} advertisements (in this case, they may share some additional campaign-related information). When legally permitted, we also receive information about members suspected or confirmed to be bad actors by third parties, as part of our efforts to ensure the safety and security of our members.</li>
  <ul>
    <li><a href="https://www.google.com/policies/privacy/" target="_blank" rel="noopener noreferrer"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Google Play Services</font></font></a></li>
    <p></p>
    <li><a href="https://support.google.com/admob/answer/6128543?hl=en" target="_blank" rel="noopener noreferrer"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">AdMob</font></font></a></li>
    <p></p>
    <li><a href="https://firebase.google.com/policies/analytics" target="_blank" rel="noopener noreferrer"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Google Analytics for Firebase</font></font></a></li>
    <p></p>
    <li><a href="https://firebase.google.com/support/privacy/" target="_blank" rel="noopener noreferrer"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Firebase Crashlytics</font></font></a></li>
    <p></p>
    <li><a href="https://www.facebook.com/about/privacy/update/printable" target="_blank" rel="noopener noreferrer"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Facebook</font></font></a></li>
  </ul>
</ul>
<h4>Information collected when you use our services</h4>
<p>Your use of our services generates technical data about which features you have used, how you used them, and the devices you used to access our services. See below for more details:</p>
<ul>
  <li><strong>Information about usage</strong> Using the services creates data about your activity on our services, such as how you use them (e.g., the times you log in, the features you use """;

  PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: AssetsClass.icons.arrowRight
              .svg(width: 24, color: AppColors.accentDark),
        ),
        title: Text(
          context.l10n.privacyPolicy,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: HtmlWidget(
          privacyPolicyContent.replaceAll(
            '{0}',
            Shared.instance.packageInfo.appName,
          ),
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
