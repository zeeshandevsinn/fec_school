import 'package:url_launcher/url_launcher.dart';

class CallsAndMessageServices {
  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback for simulators or restricted environments
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch call: $e');
    }
  }

  void makePhoneSMS(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch SMS: $e');
    }
  }

  void makePhoneEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch Email: $e');
    }
  }

  void launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Example Subject', 'body': 'Example Body:'},
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      } else {
        // Many simulators don't support mailto, try to launch anyway as a last resort
        await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch $emailLaunchUri: $e');
    }
  }
}
