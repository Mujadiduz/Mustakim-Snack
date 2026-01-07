import 'package:get/get.dart';
import 'package:mustakim_snack/barang_service.dart';

class BarangController extends GetxController {
  final BarangService service = BarangService();

  var barangList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBarang();
    super.onInit();
  }

  Future<void> fetchBarang() async {
    isLoading.value = true;
    barangList.value = await service.getBarang();
    isLoading.value = false;
  }
}
