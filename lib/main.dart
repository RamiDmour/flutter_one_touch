import 'package:flutter/material.dart';
import 'package:flutter_one_touch/core/navigation/bindings/root_binding.dart';
import 'package:flutter_one_touch/features/wallet/presentation/controller/wallet_controller.dart';
import 'package:flutter_one_touch/features/wallet/presentation/widgets/wallet_connect_button.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: RootBinding(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  // Generate simple button

  // Generate QR code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: Get.find<WalletController>().deploy,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WalletConnectButton(),
          Obx(() => Text(// 101112131415
              Get.find<WalletController>().currentWalletAddress.value ?? "")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => Get.find<WalletController>().deploy(),
            child: const Text(
              "Deploy",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => Get.find<WalletController>().paySellerDeposit(),
            child: const Text(
              "PaySellerDeposit",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => Get.find<WalletController>().payBuyerDeposit(),
            child: const Text(
              "PayBuyerDeposit",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () => Get.find<WalletController>().payFullAmount(),
            child: const Text(
              "PayFullAmount",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () =>
                Get.find<WalletController>().confirmPropertyTransfer(),
            child: const Text(
              "ConfirmPropertyTransfer",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
