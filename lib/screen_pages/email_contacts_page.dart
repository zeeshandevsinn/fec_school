import 'package:fec_app2/providers/email_contacts_provider.dart';
import 'package:fec_app2/utils/calls_and_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EmailContactsPage extends StatefulWidget {
  static const String routeName = '/email-contacts';

  const EmailContactsPage({super.key});

  @override
  State<EmailContactsPage> createState() => _EmailContactsPageState();
}

class _EmailContactsPageState extends State<EmailContactsPage> {
  final CallsAndMessageServices _andMessageServices = CallsAndMessageServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmailContactsProvider>().fetchEmailContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Contact Emails',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 25, 74, 159),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<EmailContactsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => provider.fetchEmailContacts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.contacts.isEmpty) {
            return Center(
              child: Text(
                'No contacts found',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: provider.contacts.length,
            itemBuilder: (context, index) {
              final contact = provider.contacts[index];
              return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    title: Text(
                      contact.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 25, 74, 159),
                      ),
                    ),
                    subtitle: Text(
                      contact.email,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        print("${contact.email}");
                        _andMessageServices.launchEmail(contact.email);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
