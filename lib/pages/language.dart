import 'package:flutter/material.dart';
import 'topics.dart';

class LanguagePage extends StatelessWidget {
  final String subject;

  const LanguagePage({super.key, required this.subject});

  void _navigateToTopics(BuildContext context, String language) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicsPage(subject: subject, language: language),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Language for $subject'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // English side
          Expanded(
            child: Container(
              color: Colors.yellow,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _navigateToTopics(context, 'English'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'English',
                    style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          // Twi side
          Expanded(
            child: Container(
              color: Colors.greenAccent,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _navigateToTopics(context, 'Twi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Twi',
                    style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}