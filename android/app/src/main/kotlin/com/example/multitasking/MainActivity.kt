package com.example.multitasking

import com.example.multitasking.gen_ai_image.GenAiImage
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GenAiImage(this,).init(flutterEngine.dartExecutor.binaryMessenger)
    }
}
