class Service {
  final String category; // e.g. "Standard Cleaning", "Deep Cleaning", "Add-Ons"
  final String name;     // e.g. "Bedroom", "Bathroom"
  final double price;    // e.g. 17.25

  Service({
    required this.category,
    required this.name,
    required this.price,
  });
}
