import 'package:cleopatra_homecare/controllers/conformation_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final confirmationController = Get.put(ConfirmationController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Services",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        final bookings = confirmationController.bookings;
        if (bookings.isEmpty) {
          return Center(
            child: Text(
              "No services booked yet.",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          itemCount: bookings.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final booking = bookings[index];
            final services = booking['services'] as List<dynamic>;
            final total = booking['total'];
            final timestamp = booking['timestamp'];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking #${index + 1}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...services
                        .map(
                          (s) => Text(
                            "• ${s['name']} (${s['category']}) - \$${s['price'].toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(),
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 10),
                    Text(
                      "Total: \$${total.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Date: $timestamp",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
