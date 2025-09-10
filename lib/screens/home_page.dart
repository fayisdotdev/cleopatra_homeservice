import 'package:cleopatra_homecare/controllers/service_controller.dart';
import 'package:cleopatra_homecare/screens/confirmation_page.dart';
import 'package:cleopatra_homecare/screens/my_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cleopatra_homecare/models/service_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServiceController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Cleopatra HomeCare", style: GoogleFonts.poppins(),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "My Services",
            onPressed: () {
              Get.to(() => const MyServicesScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (serviceController.services.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Group services by category
        final grouped = <String, List<Service>>{};
        for (var service in serviceController.services) {
          grouped.putIfAbsent(service.category, () => []).add(service);
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            for (var entry in grouped.entries) ...[
              Text(
                entry.key,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ...entry.value.map((service) {
                final isSelected = serviceController.selectedServices.contains(
                  service,
                );
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    title: Text(
                      service.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.blueAccent : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "\$${service.price.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    trailing: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                              key: UniqueKey(),
                            )
                          : Icon(
                              Icons.radio_button_unchecked,
                              color: Colors.grey,
                              key: UniqueKey(),
                            ),
                    ),
                    onTap: () => serviceController.toggleService(service),
                  ),
                );
              }).toList(),
            ],
            const SizedBox(height: 80), // padding for bottom button
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        // final total = serviceController.totalCost;
        final isEmpty = serviceController.selectedServices.isEmpty;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isEmpty
                ? null
                : () {
                    Get.to(
                      () => ConfirmationScreen(
                        selectedServices: serviceController.selectedServices
                            .toList(),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              backgroundColor: isEmpty ? Colors.grey : Colors.blueAccent,
            ),
            child: Text(
              isEmpty ? "Select a Service" : "Book Service",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
