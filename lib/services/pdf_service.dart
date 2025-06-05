import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../controller/invoice_controller.dart';

class PdfService {
  static Future<File> generateInvoice(InvoiceController controller) async {
    final pdf = pw.Document();

    final selected = controller.selectedProducts;
    final name = controller.nameController.text;
    final email = controller.emailController.text;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("INVOICE", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text("Name: $name", style: const pw.TextStyle(fontSize: 20)),
              pw.Text("Email: $email" , style: const pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 20),
              pw.Text("Products:", style: pw.TextStyle(fontSize: 22,fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...selected.map((product) => pw.Text("${product.name} -  ${product.price} Rs." , style: const pw.TextStyle(fontSize: 20)), ),
              pw.Divider(),
              pw.Text("Total:  ${controller.totalPrice} Rs.", style: pw.TextStyle(fontSize: 22 , fontWeight: pw.FontWeight.bold )),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
