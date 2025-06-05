import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../controller/invoice_controller.dart';
import '../services/pdf_service.dart';

class PdfPreviewScreen extends StatefulWidget {
  const PdfPreviewScreen({super.key});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  File? pdfFile;
  final controller = Get.find<InvoiceController>();

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final file = await PdfService.generateInvoice(controller);
    setState(() => pdfFile = file);
  }

  Future<void> _downloadPdf() async {
    if (pdfFile == null) return;

    final directory = await getExternalStorageDirectory();
    final path = "${directory!.path}/invoice_downloaded.pdf";
    final newFile = await pdfFile!.copy(path);

    Get.snackbar("Saved", "PDF saved to ${newFile.path}");
  }

  Future<void> _sharePdf() async {
    if (pdfFile != null) {
      await Share.shareXFiles([XFile(pdfFile!.path)], text: "Here's your invoice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Soft lavender
      appBar: AppBar(
        title: const Text("📄 Invoice Preview"),
        backgroundColor: const Color.fromARGB(255, 173, 173, 173),
        centerTitle: true,
      ),
      body: pdfFile == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PDFView(
                      filePath: pdfFile!.path,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _downloadPdf,
                        icon: const Icon(Icons.download, color: Colors.black),
                        label: const Text("Download", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 173, 173, 173),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _sharePdf,
                        icon: const Icon(Icons.share ,  color: Colors.black),
                        label: const Text("Share" , style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 173, 173, 173),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
