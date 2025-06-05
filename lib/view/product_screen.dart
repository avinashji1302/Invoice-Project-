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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFBBDEFB)], // Soft lavender to blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF7E57C2), // Lavender app bar
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "🛍️ Select Products",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() => ListView.builder(
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                final product = controller.products[index];
                                return Card(
                                  elevation: 2,
                                  child: CheckboxListTile(
                                    title: Text("${product.name} ₹${product.price}"),
                                    value: product.isSelected,
                                    onChanged: (value) {
                                      controller.products[index].isSelected = value!;
                                      controller.products.refresh();
                                    },
                                  ),
                                );
                              },
                            )),
                      ),
                      TextField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (controller.validateInputs()) {
                            Get.to(() => const PdfPreviewScreen());
                          }
                        },
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text("Generate PDF", style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 230, 227, 227), // match with app bar
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
