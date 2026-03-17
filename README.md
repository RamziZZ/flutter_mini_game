# Tower Battle – Realtime Strategy Mini Game

Tower Battle adalah mini game multiplayer realtime yang dibuat menggunakan **Flutter** dan **Firebase Realtime Database**.
Game ini mensimulasikan kompetisi dua tim yang berlomba menyelesaikan tower dengan nilai tertentu untuk mencapai **target number** lebih cepat dari tim lawan.

Project ini dibuat sebagai **technical test / internship project** untuk mendemonstrasikan kemampuan dalam:

* Flutter development
* Clean architecture
* Realtime database
* Game logic (BFS solver & bot AI)

---

## 🎮 Game Overview

Dalam permainan ini:

* Maksimal **8 pemain** dibagi menjadi **2 tim**
* Setiap tim memiliki **20 tower**
* Setiap tower memiliki **start value unik**
* Pemain harus **claim tower → solve tower**
* Tower yang berhasil diselesaikan akan menambah **score tim**

Tim yang mencapai **target score** lebih dulu akan menang.

---

## 🧠 Core Mechanics

### 1. Tower System

Setiap tower memiliki 3 state:

| State     | Deskripsi                   |
| --------- | --------------------------- |
| available | tower belum diambil         |
| claimed   | tower sudah diambil pemain  |
| solved    | tower berhasil diselesaikan |

---

### 2. BFS Solver

Game menggunakan algoritma **Breadth-First Search (BFS)** untuk mencari kombinasi operasi matematika yang menghasilkan target number.

Contoh:

10 + 20 × 5 = 100

Algoritma akan mencari solusi paling optimal untuk menyelesaikan tower.

---

### 3. Bot AI

Jika jumlah pemain kurang, **bot AI** akan otomatis bermain dengan:

* mencari tower available
* claim tower
* menjalankan solver
* menyelesaikan tower

---

### 4. Realtime Multiplayer

Game state disimpan di **Firebase Realtime Database** sehingga:

* semua pemain melihat update secara realtime
* tower berubah state langsung
* score tim otomatis terupdate

---

## 🏗️ Architecture

Project menggunakan **Clean Architecture** dengan pembagian layer:

```
lib
 └── features
      └── game
           ├── data
           │    ├── datasources
           │    │     └── firebase_game_datasource.dart
           │    └── repositories
           │          └── game_repository_impl.dart
           │
           ├── domain
           │    └── (entities & usecases)
           │
           └── presentation
                ├── controllers
                │     ├── game_controller.dart
                │     └── bot_controller.dart
                │
                ├── pages
                │     └── match_page.dart
                │
                └── widgets
                      └── tower_card.dart
```

---

## 🛠️ Tech Stack

| Technology                 | Usage                                   |
| -------------------------- | --------------------------------------- |
| Flutter                    | Cross platform mobile development       |
| GetX                       | State management & dependency injection |
| Firebase Realtime Database | Realtime multiplayer sync               |
| Flame                      | Game engine components                  |
| Dart                       | Programming language                    |

---

## 📱 Platform Support

* Android
* iOS
* Web (optional)

---

## ⚙️ Installation

### 1. Clone Repository

```
git clone https://github.com/yourusername/tower-battle.git
cd tower-battle
```

### 2. Install Dependencies

```
flutter pub get
```

### 3. Setup Firebase

Tambahkan file berikut:

```
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

dan pastikan file berikut ada:

```
lib/firebase_options.dart
```

### 4. Run Project

```
flutter run
```

---

## 📦 Build APK

Untuk membuat APK Android:

```
flutter build apk --release
```

Output:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📂 Project Structure

```
lib
 ├── main.dart
 ├── firebase_options.dart
 └── features
      └── game
           ├── data
           ├── domain
           └── presentation
```

---

## ✨ Features

* Realtime tower synchronization
* Tower claiming system
* BFS tower solver
* Bot AI player
* Animated tower UI
* Score tracking system

---

## 🚀 Future Improvements

Beberapa fitur yang dapat dikembangkan lebih lanjut:

* Player matchmaking
* Global leaderboard
* Attack animation
* Sound effects
* Game lobby system
* Match history

---

---

## 📄 License

This project is created for educational and internship purposes.

## AI Tools 

Chat GPT
