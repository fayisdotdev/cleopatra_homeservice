import 'package:cleopatra_homecare/models/service_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ConfirmationController extends GetxController {
  final _storage = GetStorage();
  final _storageKey = 'bookings';

  // Reactive list of bookings
  final bookings = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  // Save a booking (services + total + timestamp)
  void saveBooking(List<Service> services, double total) {
    final booking = {
      "services": services
          .map((s) => {
                "name": s.name,
                "category": s.category,
                "price": s.price,
              })
          .toList(),
      "total": total,
      "timestamp": DateTime.now().toIso8601String(),
    };

    bookings.add(booking);
    // Write a plain List, not an RxList
    _storage.write(_storageKey, bookings.toList());
  }

  void loadBookings() {
    final stored = _storage.read<List>(_storageKey);
    if (stored != null) {
      bookings.assignAll(
        stored.map((e) => Map<String, dynamic>.from(e)),
      );
    }
  }

  // ✅ Add this: convenience method your screen is calling
  List<Map<String, dynamic>> getBookings() => bookings.toList();

  void clearBookings() {
    bookings.clear();
    _storage.remove(_storageKey);
  }

  void removeBookingAt(int index) {
    bookings.removeAt(index);
    _storage.write(_storageKey, bookings.toList());
  }
}
