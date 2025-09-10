import 'package:cleopatra_homecare/models/service_model.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController {
  // List of all services
  final services = <Service>[].obs;

  // Selected services
  final selectedServices = <Service>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadServices();
  }

  void _loadServices() {
    services.assignAll([
      // ---------- Standard Cleaning ----------
      Service(category: "Standard Cleaning", name: "Bedroom", price: 17.25),
      Service(category: "Standard Cleaning", name: "Bathroom", price: 21.00),
      Service(category: "Standard Cleaning", name: "Half Bathroom", price: 10.50),
      Service(category: "Standard Cleaning", name: "Other Room", price: 26.00),

      // ---------- Deep Cleaning ----------
      Service(category: "Deep Cleaning", name: "Bedroom", price: 23.50),
      Service(category: "Deep Cleaning", name: "Bathroom", price: 38.50),
      Service(category: "Deep Cleaning", name: "Half Bathroom", price: 17.00),
      Service(category: "Deep Cleaning", name: "Other Room", price: 38.50),

      // ---------- Add-Ons ----------
      Service(category: "Add-Ons", name: "Refrigerator (inside)", price: 17.00),
      Service(category: "Add-Ons", name: "Microwave (inside)", price: 4.25),
      Service(category: "Add-Ons", name: "Oven (inside)", price: 19.25),
      Service(category: "Add-Ons", name: "Stovetop (scrub)", price: 8.50),
      Service(category: "Add-Ons", name: "Dishwasher (inside)", price: 6.50),
      Service(category: "Add-Ons", name: "Toaster (crumbs)", price: 2.25),
      Service(category: "Add-Ons", name: "Coffee Maker (descale)", price: 2.25),
      Service(category: "Add-Ons", name: "Blender (inside)", price: 2.25),
      Service(category: "Add-Ons", name: "Washer (inside)", price: 6.50),
      Service(category: "Add-Ons", name: "Dryer (inside)", price: 6.50),
      Service(category: "Add-Ons", name: "Air Fryer (inside)", price: 4.25),
      Service(category: "Add-Ons", name: "Electric Kettle (descale)", price: 2.25),
      Service(category: "Add-Ons", name: "Dishes (wash)", price: 8.50),
    ]);
  }

  // Toggle service selection
  void toggleService(Service service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
  }

  // Calculate total (with optional 10% platform fee)
  double get totalCost {
    double subtotal = selectedServices.fold(0, (sum, item) => sum + item.price);
    double serviceFee = subtotal * 0.10; // 10% client fee
    return subtotal + serviceFee;
  }
}
