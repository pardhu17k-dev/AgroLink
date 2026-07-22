#!/bin/bash
if [ -d "flutter" ]; then
  echo "Flutter SDK cached"
else
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi
export PATH="$PATH:`pwd`/flutter/bin"
flutter config --enable-web
flutter pub get
flutter build web --release
