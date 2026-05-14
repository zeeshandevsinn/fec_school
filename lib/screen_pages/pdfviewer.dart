import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfviewer extends StatefulWidget {
  final String newNotice;
  const Pdfviewer(this.newNotice, {super.key});

  @override
  State<Pdfviewer> createState() => _PdfviewerState();
}

class _PdfviewerState extends State<Pdfviewer> {
  bool _isLoading = true;
  String? _errorMessage;
  String? _localFilePath;
  Uint8List? _pdfBytes;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      if (kDebugMode) {
        print('Loading PDF from: ${widget.newNotice}');
      }

      // Get authentication token
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? token = preferences.getString('token');

      // Download PDF with authentication headers
      final response = await http.get(
        Uri.parse(widget.newNotice),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/pdf',
          'Accept': 'application/pdf',
        },
      );

      if (response.statusCode == 200) {
        _pdfBytes = response.bodyBytes;
        
        // Save to temporary file for Syncfusion PDF viewer
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/temp_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(_pdfBytes!);
        _localFilePath = file.path;

        if (kDebugMode) {
          print('PDF loaded successfully. File path: $_localFilePath');
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print('Failed to load PDF. Status code: ${response.statusCode}');
          print('Response: ${response.body}');
        }
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load PDF. Status code: ${response.statusCode}';
        });
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error loading PDF: $e');
        print('Stack trace: $stackTrace');
      }
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading PDF: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    // Clean up temporary file
    if (_localFilePath != null) {
      try {
        final file = File(_localFilePath!);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error deleting temporary file: $e');
        }
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 25, 74, 159),
        title: Text(
          "PDF Viewer",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading PDF...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _loadPdf();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_localFilePath != null && _pdfBytes != null) {
      try {
        // Use memory bytes if available, otherwise use file path
        return SfPdfViewer.memory(_pdfBytes!);
      } catch (e) {
        if (kDebugMode) {
          print('Error displaying PDF from memory: $e');
        }
        // Fallback to file path
        try {
          return SfPdfViewer.file(File(_localFilePath!));
        } catch (e) {
          if (kDebugMode) {
            print('Error displaying PDF from file: $e');
          }
          return Center(
            child: Text('Error displaying PDF: ${e.toString()}'),
          );
        }
      }
    }

    return const Center(
      child: Text('No PDF data available'),
    );
  }
}

/// Show Image online

class ImageView extends StatelessWidget {
  final String newNotice;
  const ImageView(this.newNotice, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 25, 74, 159),
        title: Text(
          "Image Viewer",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
      body: Image.network(newNotice),
    );
  }
}
