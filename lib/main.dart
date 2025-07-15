import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScannerScreen(),
    );
  }
}

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  String result = 'Scan a QR Code';
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    cameraController.start();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _launchURL() async {
    final uri = Uri.tryParse(result);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri,mode: LaunchMode.externalApplication, );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch: $result')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                if (!isScanning) return;

                final barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  setState(() {
                    result = barcodes.first.rawValue ?? 'No data found';
                    isScanning = false; // Pause after scan
                  });

                  // Resume scanning after 2 seconds
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() => isScanning = true);
                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Result: $result',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (result.startsWith('http'))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: _launchURL,
                                  child: const Text('Open Link'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: result));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Result copied!'))
                                    );
                                  },
                                  child: Text('Copy'),
                                )

                              ],
                            ),

                          if (!isScanning)
                            ElevatedButton(
                              onPressed: () => setState(() => isScanning = true),
                              child: const Text('Scan Again'),
                            ),
                        ],
                      ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}