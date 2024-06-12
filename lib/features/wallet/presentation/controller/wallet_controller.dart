import 'package:darttonconnect/models/wallet_app.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:darttonconnect/ton_connect.dart';

const _manifestUrl =
    "https://backend-one-touch.fly.dev/static/tonconnect-manifest.json";
const _smartContractAddress =
    "EQDeS7TvOSIIZ2ggnoqybyeZmoxXlemUGg5aHu6D7OYCSgkn";

class WalletController extends GetxController {
  final connector = TonConnect(_manifestUrl);
  final wallets = <WalletApp>[].obs;
  final currentWalletAddress = Rx<String?>(null);
  final universalLink = Rx<String?>(null);
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  @override
  void onInit() {
    if (!connector.connected) {
      connector.restoreConnection();
    } else {
      currentWalletAddress.value = connector.wallet?.account?.address;
    }
    connector.onStatusChange((value) {
      currentWalletAddress.value = connector.wallet?.account?.address;
    });

    super.onInit();
  }

  Future<void> deploy() async {
    try {
      final result = await _dio.post('/deploy', data: {
        "escrowService": "0QARDTD3OM_lm2fEpRoW1UgKM0lxa7JwER7KKQPlEV8gnMo1",
        "propertyPrice": 0.1,
      });

      final transaction = result.data;

      await connector.sendTransaction(transaction);
    } catch (e) {
      final error = e as DioError;

      Get.snackbar(
          "Error", error.response?.data['error'] ?? "Something went wrong");
    }
  }

  Future<void> paySellerDeposit() async {
    try {
      final result = await _dio.post('/paySellerDeposit', data: {
        "escrowService": "0QARDTD3OM_lm2fEpRoW1UgKM0lxa7JwER7KKQPlEV8gnMo1",
        "propertyPrice": 0.1,
      });

      final transaction = result.data;

      await connector.sendTransaction(transaction);
    } catch (e) {
      final error = e as DioError;

      Get.snackbar(
          "Error", error.response?.data['error'] ?? "Something went wrong");
    }
  }

  Future<void> payBuyerDeposit() async {
    try {
      final result = await _dio.post('/payBuyerDeposit', data: {
        "escrowService": "0QARDTD3OM_lm2fEpRoW1UgKM0lxa7JwER7KKQPlEV8gnMo1",
        "propertyPrice": 0.1,
      });

      final transaction = result.data;

      await connector.sendTransaction(transaction);
    } catch (e) {
      final error = e as DioError;

      Get.snackbar(
          "Error", error.response?.data['error'] ?? "Something went wrong");
    }
  }

  Future<void> payFullAmount() async {
    try {
      final result = await _dio.post('/payFullAmount', data: {
        "escrowService": "0QARDTD3OM_lm2fEpRoW1UgKM0lxa7JwER7KKQPlEV8gnMo1",
        "propertyPrice": 0.1,
      });

      final transaction = result.data;

      await connector.sendTransaction(transaction);
    } catch (e) {
      final error = e as DioError;

      Get.snackbar(
          "Error", error.response?.data['error'] ?? "Something went wrong");
    }
  }

  Future<void> confirmPropertyTransfer() async {
    try {
      final result = await _dio.post('/confirmPropertyTransfer', data: {
        "escrowService": "0QARDTD3OM_lm2fEpRoW1UgKM0lxa7JwER7KKQPlEV8gnMo1",
        "propertyPrice": 0.1,
      });

      final transaction = result.data;

      await connector.sendTransaction(transaction);
    } catch (e) {
      final error = e as DioError;

      Get.snackbar(
          "Error", error.response?.data['error'] ?? "Something went wrong");
    }
  }

  Future<void> fetchWallets() async {
    final fetchedWallets = await connector.getWallets();

    wallets.clear();
    wallets.addAll(fetchedWallets);
  }

  Future<void> connectWallet(WalletApp wallet) async {
    if (connector.connected) {
      await connector.disconnect();
    }
    universalLink.value = await connector.connect(wallet);
  }
}
