#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stag', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=junnotiservice \
      --out=lib/firebase_options_dev.dart \
      --ios-bundle-id=com.example.multitasking.dev \
      --ios-out=ios/flavors/dev/GoogleService-Info.plist \
      --android-package-name=com.example.multitasking.dev \
      --android-out=android/app/src/dev/google-services.json
    ;;
  stg)
    flutterfire config \
      --project=junnotiservice \
      --out=lib/firebase_options_stag.dart \
      --ios-bundle-id=com.example.multitasking.stag \
      --ios-out=ios/flavors/stag/GoogleService-Info.plist \
      --android-package-name=com.example.multitasking.stag \
      --android-out=android/app/src/stag/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=junnotiservice \
      --out=lib/firebase_options_prod.dart \
      --ios-bundle-id=com.example.multitasking.toktok \
      --ios-out=ios/flavors/prod/GoogleService-Info.plist \
      --android-package-name=com.example.multitasking.toktok \
      --android-out=android/app/src/prod/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stag', or 'prod'."
    exit 1
    ;;
esac