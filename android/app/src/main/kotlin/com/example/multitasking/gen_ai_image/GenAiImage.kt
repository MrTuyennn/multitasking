package com.example.multitasking.gen_ai_image

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import com.google.mlkit.genai.common.FeatureStatus
import com.google.mlkit.genai.common.GenAiException
import com.google.mlkit.genai.common.DownloadCallback
import com.google.mlkit.genai.imagedescription.ImageDescriber
import com.google.mlkit.genai.imagedescription.ImageDescriberOptions
import com.google.mlkit.genai.imagedescription.ImageDescription
import com.google.mlkit.genai.imagedescription.ImageDescriptionRequest
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class GenAiImage(context: Context) {

    val ctx: Context = context
    private val scope = CoroutineScope(Dispatchers.Main)

    fun init(messenger: BinaryMessenger?){
        if (messenger != null) {
            MethodChannel(messenger, "genAIImage")
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    when (call.method) {
                        "methodGenAiImage" -> {
                            val imageBytes: ByteArray? = call.argument("imageBytes")
                            // Tạo bitmap từ byte array
                            val bitmap =
                                imageBytes?.let { BitmapFactory.decodeByteArray(imageBytes, 0, it.size) }
                            println("bitmap ====> $bitmap")
                            if(bitmap != null) {
                                scope.launch {
                                    prepareAndStartImageDescription(ctx,bitmap)
                                }
                            }
                        }

                        else -> {
                            result.notImplemented()
                        }
                    }
                }
        }
    }

    suspend fun prepareAndStartImageDescription(
        context: Context,
        bitmap: Bitmap
    ) {
        val options = ImageDescriberOptions.builder(context).build()
        val imageDescriber = ImageDescription.getClient(options)
        val featureStatus = imageDescriber.checkFeatureStatus().get()
        println("bitmap ====> featureStatus $featureStatus")
        when (featureStatus) {
            FeatureStatus.DOWNLOADABLE -> {
                imageDescriber.downloadFeature(object : DownloadCallback {
                    override fun onDownloadStarted(bytesToDownload: Long) {
                        println("bitmap ====> bytesToDownload $bytesToDownload")
                    }
                    override fun onDownloadFailed(e: GenAiException) {
                        println("bitmap ====> e eeeee $e")
                    }
                    override fun onDownloadProgress(totalBytesDownloaded: Long) {
                        println("bitmap ====> totalBytesDownloaded $totalBytesDownloaded")
                    }
                    override fun onDownloadCompleted() {
                        startImageDescriptionRequest(bitmap, imageDescriber)
                    }
                })
            }
            FeatureStatus.DOWNLOADING -> {
                // Inference will automatically run once feature is downloaded
                startImageDescriptionRequest(bitmap, imageDescriber)
            }
            FeatureStatus.AVAILABLE -> {
                startImageDescriptionRequest(bitmap, imageDescriber)
            }
            else -> {
                startImageDescriptionRequest(bitmap, imageDescriber)
            }
        }
    }

    fun startImageDescriptionRequest(
        bitmap: Bitmap,
        imageDescriber: ImageDescriber
    ) {
        try {
            println("bitmap ====> end")
            // Create task request
            val imageDescriptionRequest = ImageDescriptionRequest
                .builder(bitmap)
                .build()

            // Run inference with a streaming callback
            imageDescriber.runInference(imageDescriptionRequest) { outputText ->
                // Append new output text to show in UI
                // This callback is called incrementally as the description
                // is generated
                println("bitmap ====> Image description: $outputText")
            }

            // You can also get a non-streaming response from the request
            // val imageDescription = imageDescriber.runInference(
            //        imageDescriptionRequest).await().description
        } catch (e: Exception) {
            println("bitmap ====> error $e")
        }
    }

}