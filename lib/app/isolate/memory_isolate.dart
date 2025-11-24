import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MemoryIsolate extends StatefulWidget {
  const MemoryIsolate({super.key});

  @override
  State<MemoryIsolate> createState() => _MemoryIsolateState();
}

class _MemoryIsolateState extends State<MemoryIsolate> {
  String result = "";

  // Demo: chạy trực tiếp → UI đơ
  void runDirect() {
    setState(() => result = "Running heavy loop directly...");
    final sum = heavyLoop(); // BLOCK UI
    setState(() => result = "Done: $sum");
  }

  // Demo: chạy bằng compute → UI không đơ
  Future<void> runWithCompute() async {
    setState(() => result = "Running heavy loop with compute...");
    final sum = await compute(heavyLoopCompute, 2000000000);
    setState(() => result = "Done: $sum");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Future vs Isolate Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: runDirect,
              child: Text("Run DIRECT (UI sẽ bị đơ!)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: runWithCompute,
              child: Text("Run with COMPUTE (UI mượt)"),
            ),
            SizedBox(height: 40),
            Text(result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// A: Chạy trực tiếp → UI đơ
int heavyLoop() {
  int sum = 0;
  for (int i = 0; i < 2000000000; i++) {
    sum += i;
  }
  return sum;
}

// B: Chạy bằng isolate qua compute → UI không đơ
int heavyLoopCompute(int value) {
  int sum = 0;
  for (int i = 0; i < value; i++) {
    sum += i;
  }
  return sum;
}
