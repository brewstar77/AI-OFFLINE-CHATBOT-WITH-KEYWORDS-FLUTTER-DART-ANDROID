import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'language.dart';
import 'chat.dart';
import 'quiz.dart';
import '../main.dart'; // for currentUsername
import 'profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Homepage> {
  final TextEditingController _textController = TextEditingController();
  bool _isTyping = false;
  int _selectedIndex = 0;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _currentLocaleId = 'en_US'; // Default locale

  bool _isLoading = true;

  // Assuming currentUsername is globally accessible as shown in your import
  // If not, you'll need to pass it or retrieve it differently.

  final List<Map<String, dynamic>> subjects = [
    {
      'title': 'English',
      'image': 'assets/images/english.jpg',
      'color': Colors.redAccent,
    },
    {
      'title': 'Science',
      'image': 'assets/images/science.jpg',
      'color': Colors.green,
    },
    {
      'title': 'Mathematics',
      'image': 'assets/images/maths.png',
      'color': Colors.amber,
    },
    {
      'title': 'ICT',
      'image': 'assets/images/ict.png',
      'color': Colors.black,
    },
    {
      'title': 'Social Studies',
      'image': 'assets/images/social.jpg',
      'color': Colors.blue,
    },
    {
      'title': 'Creative Arts and Design',
      'image': 'assets/images/creative.jpg',
      'color': Colors.orange,
    },
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    _textController.addListener(() {
      final typingNow = _textController.text
          .trim()
          .isNotEmpty;
      if (_isTyping != typingNow) {
        if (mounted) {
          setState(() => _isTyping = typingNow);
        }
      }
    });

    _initializeHomepage();
  }

  Future<void> _initializeHomepage() async {
    // Precache images
    if (subjects.isNotEmpty) {
      for (var subject in subjects) {
        if (subject['image'] is String &&
            (subject['image'] as String).isNotEmpty) {
          try {
            if (mounted) {
              await precacheImage(AssetImage(subject['image']), context);
            }
          } catch (_) {
            // Optionally handle image precaching errors
            // print("Error precaching image: ${subject['image']}");
          }
        }
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (mounted) setState(() => _isListening = _speech.isListening);
        },
        onError: (val) {
          if (mounted) setState(() => _isListening = false);
          _speech.stop();
          // Optionally show an error message to the user
          // print("Speech recognition error: $val");
        },
      );
      if (available) {
        if (mounted) setState(() => _isListening = true);
        _speech.listen(
          localeId: _currentLocaleId,
          onResult: (val) {
            if (mounted) {
              _textController.text = val.recognizedWords;
              // Ensure _isTyping state is also updated based on recognized words
              setState(() =>
              _isTyping = _textController.text
                  .trim()
                  .isNotEmpty);
            }
          },
        );
      } else {
        if (mounted) setState(() => _isListening = false);
        // Optionally inform user speech is not available
        // print("Speech recognition not available.");
      }
    } else {
      _speech.stop();
      if (mounted) setState(() => _isListening = false);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    if (_speech.isListening) {
      _speech.stop();
    }
    // According to some docs, _speech.cancel() might be useful
    // or _speech.destroy() if available and needed for complete cleanup.
    // For speech_to_text, stop() is usually sufficient.
    super.dispose();
  }

  void _navigateToChatPage(String question, {bool isFromNav = false}) {
    if (_isListening) {
      _speech.stop();
      if (mounted) setState(() => _isListening = false);
    }

    String questionToSend = _textController.text
        .trim()
        .isNotEmpty
        ? _textController.text.trim()
        : question; // Use provided question if text field is empty

    if (questionToSend.isEmpty && !isFromNav) {
      // Optionally, handle if there's no question to send
      // print("No question to send to chat.");
      return;
    }


    if (_textController.text
        .trim()
        .isNotEmpty) {
      _textController.clear();
      // _isTyping state will be updated by the listener
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatPage(question: questionToSend)),
    );
  }

  void _onNavTapped(int index) {
    if (_selectedIndex == index && index == 0)
      return; // Avoid redundant navigation to home

    if (_isListening) {
      _speech.stop();
      if (mounted) setState(() => _isListening = false);
    }

    // Update selected index immediately for visual feedback if not navigating away
    // or if navigation is conditional (like for home)
    if (index != 2) { // Don't set _selectedIndex for chat, as it's a direct nav
      if (mounted) setState(() => _selectedIndex = index);
    }


    switch (index) {
      case 0:
      // Navigate to a new instance of Homepage to refresh it,
      // or just ensure it's the current view if already on it.
      // If you want to pop back to an existing Homepage, logic would be different.
        Navigator
            .pushReplacement( // Use pushReplacement if you don't want to stack homepages
            context, MaterialPageRoute(builder: (context) => const Homepage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const QuizPage()));
        break;
      case 2:
        _navigateToChatPage(
            "",
            isFromNav: true); // Ask/Chat tab, navigate to chat, potentially with empty initial q
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
    }
  }

  String _getGreeting() {
    final hour = DateTime
        .now()
        .hour;
    if (hour < 12) return "Good morning";
    if (hour < 17) return "Good afternoon";
    return "Good evening";
  }

  @override
  Widget build(BuildContext context) {
    final username = currentUsername ??
        'Student'; // Ensure currentUsername is accessible

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Waiting for Sir Sammy to start class...",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    // Define TextStyles for the greeting
    // These will pick up the AppBar's default title color unless overridden
    const TextStyle greetingLine1Style = TextStyle(
      fontSize: 18, // Adjust as needed
      fontWeight: FontWeight.bold,
    );
    const TextStyle greetingLine2Style = TextStyle(
      fontSize: 15, // Adjust as needed
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Center the text lines within the Column
          children: [
            Text(
              "${_getGreeting()}, $username!",
              style: greetingLine1Style,
              textAlign: TextAlign.center,
            ),
            Text(
              "Welcome to class!",
              style: greetingLine2Style,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true, // This centers the Column widget in the AppBar
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .cardColor, // Use theme color
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: _isListening
                              ? 'Listening...'
                              : 'Ask a quick question...',
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onSubmitted: (_) {
                          if (_textController.text
                              .trim()
                              .isNotEmpty) {
                            _navigateToChatPage(_textController.text.trim());
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isTyping
                            ? Icons.send
                            : (_isListening ? Icons.mic : Icons
                            .mic_none_outlined),
                        color: _isListening
                            ? Colors.redAccent
                            : Theme
                            .of(context)
                            .colorScheme
                            .secondary, // Use theme color
                      ),
                      onPressed: () {
                        if (_textController.text
                            .trim()
                            .isNotEmpty) {
                          _navigateToChatPage(_textController.text.trim());
                        } else {
                          _listen();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GridView
                    .builder( // Using GridView.builder for potentially better performance
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return GestureDetector(
                      onTap: () {
                        if (_isListening) {
                          _speech.stop();
                          if (mounted) setState(() => _isListening = false);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LanguagePage(
                                    subject: subject['title'] as String), // Added 'as String' for type safety
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(subject['image'] as String),
                            // Added 'as String'
                            fit: BoxFit.fill,
                            // Changed to BoxFit.cover for better image scaling
                            colorFilter: ColorFilter.mode(
                              (subject['color'] as Color).withOpacity(0.55),
                              // Slightly adjusted opacity
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          subject['title'] as String, // Added 'as String'
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // Consistent font size
                            shadows: [
                              Shadow(
                                  blurRadius: 4, // Adjusted shadow
                                  color: Colors.black87,
                                  offset: Offset(1, 1))
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme
            .of(context)
            .colorScheme
            .primary,
        // Use theme color
        unselectedItemColor: Colors.grey[600],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined),
              activeIcon: Icon(Icons.quiz),
              label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Ask'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}