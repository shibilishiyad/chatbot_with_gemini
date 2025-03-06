# ChatApp with Gemini AI

A powerful and modern chat application built with Flutter, featuring AI-powered conversations using Gemini AI.

## 🚀 Features
- **Real-time Chat:** Seamless messaging with a beautiful UI.
- **AI Integration:** Chat with Gemini AI for smart, contextual responses.
- **User Authentication:** Secure login and sign-up.
- **Message History:** View and manage previous conversations.
- **Responsive Design:** Works perfectly on both Android and iOS.

## 🛠️ Installation

1. **Clone the Repository:**
```bash
git clone https://github.com/shibilishiyad/chatbot_with_gemini.git
cd chatbot_with_gemini
```

2. **Install Dependencies:**
```bash
flutter pub get
```

3. **Run the App:**
```bash
flutter run
```

Make sure you have Flutter installed. Check out the [Flutter installation guide](https://docs.flutter.dev/get-started/install) if needed.

## 📂 Project Structure
```
lib/
├── main.dart                # App entry point
├── screens/
│   ├── chat_screen.dart     # Chat UI
│   └── login_screen.dart    # Login screen
├── services/
│   └── gemini_api.dart      # API integration with Gemini AI
└── widgets/
    └── message_bubble.dart  # Chat message component
```

## ⚡ API Configuration
1. Get your Gemini AI API key.
2. Add a `.env` file in the root directory:
```
GEMINI_API_KEY=your_api_key_here
```
3. Install the `flutter_dotenv` package for environment variables:
```yaml
dependencies:
  flutter_dotenv: ^5.0.2
```

## 🧠 How it Works
- Users send messages through the chat interface.
- Messages are sent to the Gemini AI API.
- The API processes the input and returns an intelligent response.
- The response is displayed in the chat UI.

## 📜 License
This project is open-source and available under the MIT License.

---

Made with ❤️ by [Shibili Shiyad](https://github.com/shibilishiyad)

---

Want me to add more sections, or is this good to go? Let me know! 🚀

