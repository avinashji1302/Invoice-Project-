import 'package:app/view/pdf_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/invoice_controller.dart';

class ProductScreen extends StatelessWidget {
  final controller = Get.put(InvoiceController());

   ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Products"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return CheckboxListTile(
                        title: Text("${product.name} ₹${product.price}"),
                        value: product.isSelected,
                        onChanged: (value) {
                          controller.products[index].isSelected = value!;
                          controller.products.refresh();
                        },
                      );
                    },
                  )),
            ),
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (controller.validateInputs()) {
                  // Navigate to PDF preview (PDF generation logic comes next)
                  Get.to(() =>  PdfPreviewScreen());
                }
              },
              child: const Text("Generate PDF"),
            )
          ],
        ),
      ),
    );
  }
}
