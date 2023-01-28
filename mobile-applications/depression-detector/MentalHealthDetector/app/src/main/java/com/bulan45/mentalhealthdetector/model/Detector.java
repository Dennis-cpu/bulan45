package com.bulan45.mentalhealthdetector.model;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.Continuation;
import com.google.firebase.ml.common.modeldownload.FirebaseModelDownloadConditions;
import com.google.firebase.ml.common.modeldownload.FirebaseModelManager;
import com.google.firebase.ml.custom.FirebaseCustomRemoteModel;

import org.tensorflow.lite.support.label.Category;
import org.tensorflow.lite.task.text.nlclassifier.NLClassifier;

import java.io.File;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicReference;

public class Detector {

    private static final String TAG = "TextClassificationDemo";

    private TextView resultTextView;
    private EditText inputEditText;
    private ExecutorService executorService;
    private ScrollView scrollView;
    private Button predictButton;
    private Context context;

    // TODO 5: Define a NLClassifier variable
    private NLClassifier textClassifier;
    public Detector(Context context) {
        this.context = context;
        Log.v(TAG, "onCreate");

        executorService = Executors.newSingleThreadExecutor();




//        predictButton = findViewById(R.id.predict_button);
//        predictButton.setOnClickListener(
//                (View v) -> {
//                    classify(inputEditText.getText().toString());
//                });

        // TODO 3: Call the method to download TFLite model
        //downloadModel("sentiment_analysis");
        //downloadModel("Google_ML_Testing");
        //downloadModel("Twitter_Model");
        //downloadModel("damnmodel");
        //downloadModel("model9");

    }

    /** Send input text to TextClassificationClient and get the classify messages. */
    public String classify(final String text) {
        downloadModel("model9");
        AtomicReference<Float> temp = new AtomicReference<>(0f);
        executorService.execute(
                () -> {
                    // TODO 7: Run sentiment analysis on the input text
                    List<Category> results = textClassifier.classify(text);

                    // TODO 8: Convert the result to a human-readable text
                    //String textToShow = "Input: " + text + "\nOutput:\n";
                    for (int i = 0; i < results.size(); i++) {
                        Category result = results.get(i);
//                        textToShow +=
//                                String.format("    %s: %s\n", result.getLabel(), result.getScore());
                        temp.set(result.getScore());

                    }
                    //textToShow += "---------\n";
                    //Toast.makeText(MainActivity.this,String.valueOf(temp),Toast.LENGTH_LONG).show();
                    //Log.d("Results", String.valueOf(temp.get()));
                    // Show classification result on screen
                    //showResult(textToShow);

                });
        return temp.toString();
    }

    /** Show classification result on the screen. */


    // TODO 2: Implement a method to download TFLite model from Firebase
    /** Download model from Firebase ML. */
    private synchronized void downloadModel(String modelName) {
        final FirebaseCustomRemoteModel remoteModel =
                new FirebaseCustomRemoteModel
                        .Builder(modelName)
                        .build();
        FirebaseModelDownloadConditions conditions =
                new FirebaseModelDownloadConditions.Builder()
                        .requireWifi()
                        .build();
        final FirebaseModelManager firebaseModelManager = FirebaseModelManager.getInstance();
        firebaseModelManager
                .download(remoteModel, conditions)
                .continueWithTask(task ->
                        firebaseModelManager.getLatestModelFile(remoteModel)
                )
                .continueWith(executorService, (Continuation<File, Void>) task -> {
                    // Initialize a text classifier instance with the model
                    File modelFile = task.getResult();
                    Log.d("Size", String.valueOf(modelFile.getPath()));

                    // TODO 6: Initialize a TextClassifier with the downloaded model
                    textClassifier = NLClassifier.createFromFile(modelFile);

                    // Enable predict button
                    //predictButton.setEnabled(true);
                    return null;
                })
                .addOnFailureListener(e -> {
                    Log.e(TAG, "Failed to download and initialize the model. ", e);
                    Toast.makeText(
                            context,
                            "Model download failed, please check your connection.",
                            Toast.LENGTH_LONG)
                            .show();
                   // predictButton.setEnabled(false);
                });
    }
}
