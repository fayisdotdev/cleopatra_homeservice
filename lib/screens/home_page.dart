import 'package:cleopatra_homecare/controllers/service_controller.dart';
import 'package:cleopatra_homecare/screens/confirmation_page.dart';
import 'package:cleopatra_homecare/screens/my_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleopatra_homecare/models/service_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServiceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Services"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
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
          padding: const EdgeInsets.all(16),
          children: [
            for (var entry in grouped.entries) ...[
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...entry.value.map((service) {
                final isSelected =
                    serviceController.selectedServices.contains(service);
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(service.name),
                    subtitle: Text("\$${service.price.toStringAsFixed(2)}"),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isSelected ? Colors.green : Colors.grey,
                    ),
                    onTap: () => serviceController.toggleService(service),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final total = serviceController.totalCost;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: serviceController.selectedServices.isEmpty
                ? null
                : () {
                    Get.to(() => ConfirmationScreen(
                          selectedServices:
                              serviceController.selectedServices.toList(),
                        ));
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              serviceController.selectedServices.isEmpty
                  ? "Select a Service"
                  : "Book Service (\$${total.toStringAsFixed(2)})",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}
