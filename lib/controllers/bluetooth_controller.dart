import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  Future<void> scanDevices() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
      // Espera un tiempo antes de detener el escaneo
      await Future.delayed(const Duration(seconds: 5));
    } catch (e) {
      print('Error al escanear dispositivos: $e');
    } finally {
      FlutterBluePlus.stopScan();
    }
  }

  BluetoothDevice? selectedDevice;

  Future<void> setSelectedDevice(BluetoothDevice device) async {
    selectedDevice = device;
    await connectToDevice(); // Llamar a la función para conectar el dispositivo seleccionado
  }

  Future<void> connectToDevice() async {
    if (selectedDevice == null) {
      print('No se ha seleccionado un dispositivo.');
      return;
    }

    try {
      await selectedDevice!.connect();
      print('Conectado a: ${selectedDevice!.name}');
      // Realizar acciones después de la conexión exitosa
      // Por ejemplo, enviar datos al dispositivo Arduino
    } catch (e) {
      print('Error al conectar: $e');
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
