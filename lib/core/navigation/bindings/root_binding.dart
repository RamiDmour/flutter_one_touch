import 'package:flutter_one_touch/features/wallet/presentation/controller/wallet_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class RootBinding extends Bindings {
  RootBinding();
  @override
  void dependencies() {
    Get.put(WalletController());
  }
}
