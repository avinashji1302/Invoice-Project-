import 'package:get/get.dart';
import '../model/product_model.dart';
import 'package:flutter/material.dart';

class InvoiceController extends GetxController {
  // List of hardcoded products
  var products = <ProductModel>[
    ProductModel(name: 'Product A', price: 100),
    ProductModel(name: 'Product B', price: 200),
    ProductModel(name: 'Product C', price: 150),
    ProductModel(name: 'Product D', price: 250),
    ProductModel(name: 'Product E', price: 300),
  ].obs;

  // Text controllers for Name and Email
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  // Get selected products
  List<ProductModel> get selectedProducts =>
      products.where((p) => p.isSelected).toList();

  // Calculate total
  double get totalPrice => selectedProducts.fold(0, (sum, item) => sum + item.price);

  // Validate input
  bool validateInputs() {
    if (selectedProducts.isEmpty) {
      Get.snackbar("Error", "Please select at least one product");
      return false;
    }
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter name and email");
      return false;
    }
    return true;
  }
}
