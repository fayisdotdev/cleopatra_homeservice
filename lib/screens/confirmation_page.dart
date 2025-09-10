import 'package:cleopatra_homecare/controllers/conformation_controller.dart';
import 'package:cleopatra_homecare/models/service_model.dart';
import 'package:cleopatra_homecare/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Booking Confirmation",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selected Services",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // List of selected services
            Expanded(
              child: ListView.builder(
                itemCount: selectedServices.length,
                itemBuilder: (context, index) {
                  final service = selectedServices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        service.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        service.category,
                        style: GoogleFonts.poppins(),
                      ),
                      trailing: Text(
                        "\$${service.price.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 30, thickness: 1),

            // Total price
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Total: \$${total.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Confirm Booking Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Confirm button pressed");
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
                      "Your booking has been saved.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.9),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                      overlayBlur: 2,
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      Get.offAll(() => const HomeScreen());
                    });
                  } catch (e) {
                    print("Error saving booking: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  "Confirm Booking",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
