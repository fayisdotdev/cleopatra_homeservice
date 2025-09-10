import 'package:cleopatra_homecare/controllers/conformation_controller.dart';
import 'package:cleopatra_homecare/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatelessWidget {
  final List<Service> selectedServices;

  ConfirmationScreen({super.key, required this.selectedServices});

  final ConfirmationController confirmationController = Get.put(
    ConfirmationController(),
  );

  @override
  Widget build(BuildContext context) {
    final double total = selectedServices.fold(
      0,
      (sum, service) => sum + service.price,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Confirmation"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selected Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // List of selected services
            Expanded(
              child: ListView.builder(
                itemCount: selectedServices.length,
                itemBuilder: (context, index) {
                  final service = selectedServices[index];
                  return ListTile(
                    title: Text(service.name),
                    subtitle: Text(service.category),
                    trailing: Text("\$${service.price.toStringAsFixed(2)}"),
                  );
                },
              ),
            ),

            const Divider(),

            // Total price
            Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Confirm Booking Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Confirm button pressed"); // 🔹 debug
                  print(
                    "Selected services: ${selectedServices.map((s) => s.name).toList()}",
                  );
                  final double total = selectedServices.fold(
                    0,
                    (sum, s) => sum + s.price,
                  );
                  print("Total: $total");

                  try {
                    confirmationController.saveBooking(selectedServices, total);
                    print("Booking saved: ${confirmationController.bookings}");

                    Get.snackbar(
                      "Booking Confirmed",
                      "Your booking has been saved locally.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.9),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                      overlayBlur: 2,
                    );

                    Get.back(); // back to Home
                  } catch (e) {
                    print("Error saving booking: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
