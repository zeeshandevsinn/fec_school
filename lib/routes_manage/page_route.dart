import 'package:fec_app2/screen_pages/child_info.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/events.dart';
import 'package:fec_app2/screen_pages/folders_all.dart';
import 'package:fec_app2/screen_pages/forms.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/screen_pages/profile.dart';
import 'package:fec_app2/screen_pages/email_contacts_page.dart';
import 'package:fec_app2/screen_pages/call_contacts_page.dart';
import 'package:fec_app2/screen_pages/reset_password.dart';
import 'package:fec_app2/screen_pages/save_password.dart';
import 'package:fec_app2/screen_pages/signup_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case ResetPassword.routeName:
      return MaterialPageRoute(builder: (context) => const ResetPassword());
    case SavePassword.routeName:
      return MaterialPageRoute(builder: (context) => const SavePassword());
    case DashBoard.routeName:
      return MaterialPageRoute(builder: (context) => const DashBoard());
    case NoticesScreen.routeName:
      return MaterialPageRoute(builder: (context) => const NoticesScreen());
    case EventScreen.routeName:
      return MaterialPageRoute(builder: (context) => const EventScreen());
    case FormScreen.routeName:
      return MaterialPageRoute(builder: (context) => const FormScreen());
    case ChildInformation.routeName:
      return MaterialPageRoute(builder: (context) => const ChildInformation());
    case ProfileInfo.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileInfo());
    case FoldersAll.routeName:
      return MaterialPageRoute(builder: (context) => const FoldersAll());
    case EmailContactsPage.routeName:
      return MaterialPageRoute(builder: (context) => const EmailContactsPage());
    case CallContactsPage.routeName:
      return MaterialPageRoute(builder: (context) => const CallContactsPage());
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
