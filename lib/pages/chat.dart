import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:string_similarity/string_similarity.dart'; // Add this

class ChatPage extends StatefulWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isSpeaking = false;
  bool _isListening = false;
  bool _isAITyping = false;

  List<Map<String, dynamic>> _qaList = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();

    _flutterTts.setStartHandler(() => setState(() => _isSpeaking = true));
    _flutterTts.setCompletionHandler(() => setState(() => _isSpeaking = false));
    _flutterTts.setErrorHandler((msg) => setState(() => _isSpeaking = false));

    _loadAllQA();

    if (widget.question.trim().isNotEmpty) {
      _sendMessage(widget.question.trim());
    }

    _textController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> _loadAllQA() async {
    final files = [
      'english.json',
      'maths.json',
      'science.json',
      'ict.json',
      'social.json',
      'creative.json',
      'general.json',
    ];
    List<Map<String, dynamic>> allQA = [];

    for (final file in files) {
      try {
        final jsonString = await rootBundle.loadString('assets/data/$file');
        final List<dynamic> data = json.decode(jsonString);
        allQA.addAll(List<Map<String, dynamic>>.from(data));
      } catch (e) {
        debugPrint("Failed to load $file: $e");
      }
    }

    setState(() => _qaList = allQA);
  }

  String _getBestMatchAnswer(String question) {
    if (_qaList.isEmpty) return "I'm still loading knowledge. Please try again.";

    double bestScore = 0.0;
    String bestAnswer = "I'm not sure about that yet. Check your spellings also";

    for (final item in _qaList) {
      final knownQ = (item['question'] ?? '').toString().toLowerCase().trim();
      double score = StringSimilarity.compareTwoStrings(
        question.toLowerCase(),
        knownQ,
      );

      if (score > bestScore) {
        bestScore = score;
        bestAnswer = item['answer'] ?? bestAnswer;
      }
    }

    return bestScore > 0.36? bestAnswer : "I'm not sure about that yet. Check your spellings";
  }

  Future<void> _sendMessage(String question) async {
    if (_isListening) await _speech.stop();
    if (_isSpeaking) await _flutterTts.stop();

    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _isAITyping = true;
    });

    _scrollToBottom();
    await Future.delayed(const Duration(milliseconds: 500));

    final answer = _getBestMatchAnswer(question);

    setState(() {
      _messages.add({'role': 'bot', 'text': answer});
      _isAITyping = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _speak(String text) async {
    if (!_isSpeaking && text.trim().isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  void _handleSpeakLastBotMessage() {
    final last = _messages.lastWhere(
          (msg) => msg['role'] == 'bot',
      orElse: () => {'text': ''},
    );
    final text = last['text'] ?? '';
    if (_isSpeaking) {
      _flutterTts.stop();
    } else {
      _speak(text);
    }
  }

  void _listen() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() => _isSpeaking = false);
    }

    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          setState(() => _isListening = _speech.isListening);
        },
        onError: (val) {
          setState(() => _isListening = false);
          _speech.stop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('STT Error: ${val.errorMsg}')),
          );
        },
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'en_US',
          onResult: (val) {
            setState(() {
              _textController.text = val.recognizedWords;
            });
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 5),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available.')),
        );
      }
    } else {
      await _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _flutterTts.stop();
    _speech.stop();
    _speech.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _textController.text.trim().isNotEmpty;
    final canSpeak = _messages.any((m) => m['role'] == 'bot' && (m['text']?.isNotEmpty ?? false));

    return Scaffold(
      appBar: AppBar(
        title: const Text("One-On-One With Sir Sammy"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isAITyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isAITyping && index == _messages.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(children: [
                      CircularProgressIndicator(strokeWidth: 2),
                      SizedBox(width: 10),
                      Text("Sir Sammy is typing...")
                    ]),
                  );
                }

                final msg = _messages[index];
                final isUser = msg['role'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -1),
                  blurRadius: 1,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration.collapsed(
                          hintText: _isListening
                              ? 'Listening...'
                              : (_isSpeaking ? 'Speaking...' : 'Ask Sir Sammy...'),
                        ),
                        onSubmitted: (_) {
                          if (_textController.text.trim().isNotEmpty) {
                            _sendMessage(_textController.text.trim());
                            _textController.clear();
                          }
                        },
                      ),
                    ),
                    if (canSpeak || _isSpeaking)
                      IconButton(
                        icon: Icon(
                          _isSpeaking
                              ? Icons.stop_circle_outlined
                              : Icons.volume_up_outlined,
                          color: _isSpeaking
                              ? Colors.redAccent
                              : Theme.of(context).primaryColor,
                        ),
                        onPressed: _handleSpeakLastBotMessage,
                      ),
                    IconButton(
                      icon: Icon(
                        hasText
                            ? Icons.send
                            : (_isListening ? Icons.mic : Icons.mic_none_outlined),
                        color: _isListening
                            ? Colors.redAccent
                            : Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (hasText) {
                          _sendMessage(_textController.text.trim());
                          _textController.clear();
                        } else {
                          _listen();
                        }
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 6, left: 8, right: 8),
                  child: Text(
                    'Please ask clear and simple questions. Check Spellings!!',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.redAccent,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
