import 'package:flutter/material.dart';
import 'package:flutter_one_touch/features/wallet/presentation/controller/wallet_controller.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletConnectModal extends StatefulWidget {
  const WalletConnectModal({super.key});

  @override
  State<WalletConnectModal> createState() => _WalletConnectModalState();
}

class _WalletConnectModalState extends State<WalletConnectModal> {
  late final WalletController _walletController;
  var _isWalletConnected = false;
  @override
  void initState() {
    _walletController = Get.find()..fetchWallets();
    _walletController.currentWalletAddress.listen((address) {
      if (address != null) {
        Get.back();
      }
    });
    super.initState();
  }

  void _onWalletConnect(int index) {
    _walletController.connectWallet(_walletController.wallets[index]);
    setState(() {
      _isWalletConnected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          if (_isWalletConnected)
            IconButton(
              onPressed: () => setState(() => _isWalletConnected = false),
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          const Text(
            "Select wallet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFF8C4B),
      content: SizedBox(
        width: 300,
        child: Obx(
          () => _walletController.wallets.isEmpty
              ? const CircularProgressIndicator(
                  color: Colors.orange,
                )
              : !_isWalletConnected
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: InkWell(
                              onTap: () => _onWalletConnect(index),
                              child: Row(
                                children: [
                                  Image.network(
                                    _walletController.wallets[index].image,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(_walletController.wallets[index].name,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                      itemCount: _walletController.wallets.length)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QrImageView(
                          version: QrVersions.auto,
                          data: _walletController.universalLink.value!,
                          // backgroundColor: Colors.white,
                          dataModuleStyle:
                              const QrDataModuleStyle(color: Colors.white),
                          eyeStyle: const QrEyeStyle(color: Colors.white),
                        ),
                        Text(
                          _walletController.universalLink.value!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
