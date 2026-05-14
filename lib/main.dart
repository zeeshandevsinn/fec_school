import 'dart:io';
import 'package:fec_app2/firebase_options.dart';
import 'package:fec_app2/providers/checkbox_provider.dart';
import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/dash_form_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/dropdown_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/formdata_submission.dart';
import 'package:fec_app2/providers/initial_textformfield_provider.dart';
import 'package:fec_app2/providers/login_provider.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/profile_provider.dart';
import 'package:fec_app2/providers/radiogroup_provider.dart';
import 'package:fec_app2/providers/reset_password_provider.dart';
import 'package:fec_app2/providers/save_password_provider.dart';
import 'package:fec_app2/providers/signup_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/providers/email_contacts_provider.dart';
import 'package:fec_app2/providers/call_contacts_provider.dart';
import 'package:fec_app2/routes_manage/page_route.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/ipad_not_supported.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // Handle Flutter errors gracefully
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      print('Flutter Error: ${details.exception}');
      print('Stack trace: ${details.stack}');
    }
  };

  // Handle platform errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      print('Platform Error: $error');
      print('Stack trace: $stack');
    }
    return true; // Return true to prevent the app from crashing
  };

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with better error handling
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseInitialized = true;
    if (kDebugMode) {
      print('Firebase initialized successfully');
    }
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print('Firebase initialization error: $e');
      print('Stack trace: $stackTrace');
    }
    // Don't rethrow - allow app to continue without Firebase
    // The app should be able to work without Firebase for basic functionality
    firebaseInitialized = false;
  }

  HttpOverrides.global = MyHttpOverrides();

  SharedPreferences prefs;
  String? token;
  try {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
  } catch (e) {
    if (kDebugMode) {
      print('Error loading SharedPreferences: $e');
    }
    // Continue with null token
    token = null;
  }

  // Only set background message handler if Firebase is initialized
  if (firebaseInitialized) {
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundNotifications);
    } catch (e) {
      if (kDebugMode) {
        print('Error setting background message handler: $e');
      }
    }
  }

  try {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } catch (e) {
    if (kDebugMode) {
      print('Error setting preferred orientations: $e');
    }
  }

  runApp(MyApp(token: token != null, firebaseInitialized: firebaseInitialized));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundNotifications(
    RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase might already be initialized, which is fine
    if (kDebugMode) {
      print('Firebase background initialization: $e');
    }
  }
  if (kDebugMode) {
    print(message.notification?.title?.toString() ?? 'No title');
  }
}

class MyApp extends StatelessWidget {
  final bool token;
  final bool firebaseInitialized;
  const MyApp(
      {super.key, required this.token, this.firebaseInitialized = true});

  Future<bool> _checkIfIPad() async {
    if (!Platform.isIOS) return false;

    const platform = MethodChannel('com.example.fecApp2/device');
    try {
      final bool isIPad = await platform.invokeMethod('isIPad');
      return isIPad;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking iPad: $e');
      }
      return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfIPad(),
      builder: (context, snapshot) {
        // If still checking, show a simple loading screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        // If iPad detected, show not supported screen
        if (snapshot.hasData && snapshot.data == true) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FEC School',
            home: IpadNotSupportedScreen(),
          );
        }

        // Otherwise, show the normal app
        return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => LoginProvider()),
                      ChangeNotifierProvider(
                          create: (context) => PasswordProvider()),
                      ChangeNotifierProvider(
                          create: (context) => SignUpProvider()),
                      ChangeNotifierProvider(
                          create: (context) => SwitchingProvider()),
                      ChangeNotifierProvider(
                          create: (context) => ChildInfoProvider()),
                      ChangeNotifierProvider(
                          create: (context) => SavePasswordProvider()),
                      ChangeNotifierProvider(
                          create: (context) => ResetPasswordProvider()),
                      ChangeNotifierProvider(
                        create: (context) => TextFormFieldsProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => FilePickerProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => DateTimeProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => FormDataSubmissionProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => CheckBoxProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => DropDownProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => RadioGroupProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => ProfileUpdateProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => ProfileDeleteProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => TextFormFieldsClassProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => VisbilityProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => InitialTextformfieldProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => IntializeFormFieldsProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => SubmissionProcessForFormProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => EmailContactsProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => CallContactsProvider(),
                      ),
                    ],
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'FEC School',
                      theme: ThemeData(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.transparent),
                        useMaterial3: true,
                      ),
                      builder: (context, widget) {
                        Widget error = widget ?? const SizedBox();
                        ErrorWidget.builder =
                            (FlutterErrorDetails errorDetails) {
                          if (kDebugMode) {
                            print('ErrorWidget: ${errorDetails.exception}');
                            print('Stack trace: ${errorDetails.stack}');
                          }
                          return Material(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Something went wrong',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (kDebugMode)
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          errorDetails.exception.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        };
                        return error;
                      },
                      onGenerateRoute: (settings) => generateRoutes(settings),
                      home: token ? const DashBoard() : const LoginScreen(),
                    )));
      },
    );
  }
}
