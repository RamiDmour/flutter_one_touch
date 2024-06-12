import 'package:flutter/material.dart';
import 'package:flutter_one_touch/features/wallet/presentation/controller/wallet_controller.dart';
import 'package:flutter_one_touch/features/wallet/presentation/widgets/wallet_connect_modal.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletConnectButton extends StatelessWidget {
  const WalletConnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF8C4B),
      ),
      onPressed: () => Get.dialog(WalletConnectModal()),
      child: const Text(
        "Connect wallet",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
