import 'package:flutter/material.dart';
// Import your other pages if you are navigating to them by type
 import 'homepage.dart'; // Assuming you have a HomePage
 import 'quiz.dart'; // Assuming you have a QuizPage
 import 'chat.dart'; // Assuming you have a ChatPage

// We'll create this page next
// import 'explanation_page.dart';

class TopicsPage extends StatelessWidget {
  final String subject;
  final String language;

  const TopicsPage({
    super.key,
    required this.subject,
    required this.language,
  });

  // Helper to get main topics (which are now the keys of the sub-topics map)
  List<String> _getMainTopics(String currentSubject, String currentLanguage) {
    return _getTopicsData(currentSubject, currentLanguage).keys.toList();
  }

  // Helper to get sub-topics for a main topic
  // List<String> _getSubTopics(
  //     String currentSubject, String currentLanguage, String mainTopic) {
  //   // For the new structure:
  //   return _getTopicsData(currentSubject, currentLanguage)[mainTopic] ?? [];
  // }

  // Adjusted to return the map for the given language and subject
  Map<String, List<String>> _getTopicsData(
      String currentSubject, String currentLanguage) {
    final Map<String, Map<String, Map<String, List<String>>>> detailedTopicMap =
    _getDetailedTopicMap(); // Using the new detailed map
    return detailedTopicMap[currentSubject]?[currentLanguage] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    final List<String> mainTopics = _getMainTopics(subject, language);

    // Assuming 'Topics' is the second item in your bottom nav (index 1)
    // Adjust this if your Topics icon is at a different position
    const int currentBottomNavIndex = 1; // 0: Home, 1: Topics, 2: Quiz, 3: Chat

    return Scaffold(
      appBar: AppBar(
        title: Text('$subject - $language (${mainTopics.length} Topics)'), // Slightly more informative title
        centerTitle: true,
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: mainTopics.isEmpty
          ? Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No topics available for "$subject" in $language.\nPlease check back later or select a different subject/language.',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ))
          : ListView.builder(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 70.0), // Added padding for BottomNavBar
        itemCount: mainTopics.length,
        itemBuilder: (context, index) {
          final mainTopic = mainTopics[index];
          final List<String> subItems =
              _getTopicsData(subject, language)[mainTopic] ?? [];

          return Card(
            elevation: 2.0,
            margin:
            const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ExpansionTile(
              key: PageStorageKey<String>(
                  mainTopic), // For maintaining expansion state
              title: Text(
                mainTopic,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              leading: Icon(
                _getIconForTopic(mainTopic,
                    subject), // Helper to get an icon
                color: Theme.of(context).primaryColor,
              ),
              childrenPadding: const EdgeInsets.only(
                  left: 16.0, bottom: 8.0, right: 16.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: subItems.map((subTopic) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  title: Text(
                    subTopic,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.9),
                    ),
                  ),
                  leading: const Icon(Icons.label_outline,
                      size: 20, color: Colors.grey),
                  onTap: () {
                    // TODO: Navigate to ExplanationPage
                    // For now, show a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Selected Sub-Topic: $subTopic (under $mainTopic)')),
                    );
                    /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExplanationPage(
                                subject: subject,
                                mainTopic: mainTopic,
                                subTopic: subTopic,
                                language: language,
                              ),
                            ),
                          );
                          */
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentBottomNavIndex, // Highlight the 'Topics' icon
        type: BottomNavigationBarType.fixed, // To show all labels
        backgroundColor: Theme.of(context).cardColor, // Or your preferred color
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12.0, // Adjust size if needed
        unselectedFontSize: 12.0, // Adjust size if needed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'Topics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
        ],
        onTap: (index) {
          // --- NAVIGATION LOGIC ---
          // This is where you'd handle navigation when an icon is tapped.
          // You'll likely want to use Navigator.pushReplacementNamed or
          // communicate with a parent widget that controls the page views.

          if (index == currentBottomNavIndex) return; // Do nothing if already on this page's tab

          switch (index) {
            case 0:
            // TODO: Implement navigation to Home Page
            // Example: Navigator.pushReplacementNamed(context, '/home');
            // Or if not using named routes:
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
              break;
            case 1:
            // This is the current page, usually no action or refresh
              break;
            case 2:
            // TODO: Implement navigation to Quiz Page
            // Example: Navigator.pushReplacementNamed(context, '/quiz');
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const QuizPage()));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizPage()),
              );
// In topics.dart (case 3):
          // In topics.dart, inside the onTap for the Chat icon (case 3):
            case 3: // Chat
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatPage(question:""
                    //question: "General Help", // Or any default question string
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  IconData _getIconForTopic(String topic, String mainSubject) {
    // You can expand this with more specific icons based on topic names or subject
    // This is a simple example.
    switch (mainSubject.toLowerCase()) {
      case 'english':
        return Icons.translate;
      case 'science':
        return Icons.science_outlined;
      case 'mathematics':
        return Icons.calculate_outlined;
      case 'ict':
        return Icons.computer_outlined;
      case 'social studies':
        return Icons.public_outlined;
      case 'creative arts and design':
        return Icons.palette_outlined;
      default:
        return Icons.library_books_outlined; // Default icon
    }
  }

  // IMPORTANT: You need to restructure your topicMap to support this new design.
  // The outer keys are subjects, the next keys are languages.
  // The values are then a Map where:
  //    - keys are the "main topics" (which will be the ExpansionTile titles)
  //    - values are a List<String> of "sub-topics" for that main topic.

  Map<String, Map<String, Map<String, List<String>>>> _getDetailedTopicMap() {
    // --- PASTE YOUR DETAILED TOPIC MAP FROM THE PREVIOUS VERSION HERE ---
    // Make sure this map is correctly populated with your subjects, languages,
    // main topics, and their respective sub-topic lists.
    return {
      'English': {
        'English': {
          'Oral Language': ['Pronunciation', 'Fluency', 'Listening Skills'],
          'Reading': ['Comprehension', 'Vocabulary', 'Speed Reading'],
          'Grammar Usage': ['Sentence Structure', 'Tenses', 'Parts of Speech in Use'],
          'Grammar': ['Nouns', 'Verbs', 'Adjectives', 'Syntax Rules'],
          'Writing': ['Essay Writing', 'Letter Writing', 'Creative Writing'],
          'Literature': ['Poetry Analysis', 'Novel Study', 'Drama Elements']
        },
        'Twi': {
          'Anom Nsemmisa': ['Nneɛma a Wɔka Gu Anim', 'Kasakasa Mfiridwuma'],
          'Akenkan': ['Nteaseɛ', 'Nsɛmfua'],
          'Kasasin Mmara Dwumadie': ['Kasasin Nhyehyɛeɛ', 'Mmere'],
          'Kasasin Mmara': ['Edin', 'Adɛyɛ'],
          'Atwerɛ': ['Nsɛm Atwerɛ', 'Nwoma Atwerɛ'],
          'Nwoma Su': ['Anwonsɛm Su', 'Ayɛsɛm Su']
        },
      },
      'Science': {
        'English': {
          'Diversity of Matter': ['Materials', 'Living Cells'],
          'Cycles': ['Earth Sciences', 'Life Cycles of Organisms', 'Crop Production', 'Animal Production'],
          'Systems': ['The Human Body System', 'The Solar System', 'Farming Systems', 'Ecosystems'], // Corrected typo
          'Forces and Energy': ['Energy', 'Electricity and Electronics', 'Conversion and Conversation of Energy', 'Force and Motion'],
          'Humans and the Environment': ['Waste Management', 'Human Health', 'Science and Industry', 'Climate Change and Green Economy', 'Understanding the Environment']
        },
        'Twi': {
          'Nneɛma Ahodoɔ ne Wɔn Su': ['Nneɛma Tebea', 'Nneɛma a Wɔaka Abom'],
          'Nsakraeɛ Ahorow': ['Nsuo Nsakraeɛ', 'Mframa Nsakraeɛ'],
          'Onipa Niponam Nhyehyɛeɛ': ['Yafunu mu Nhyehyɛeɛ', 'Home Nhyehyɛeɛ'],
          'Tumi ne Ahooden': ['Nsonseɛtɔ', 'Ahogono Tumi'],
          'Onipa ne N\'atenaeɛ': ['Efi', 'Nneɛma Akoraeɛ']
        },
      },
      'Mathematics': {
        'English': {
          'Number': ['Number and Numeration System', 'Number Operations', 'Decimals and Percentages','Ratios and Proportion'], // Corrected typo
          'Geometry and Measurement': ['Shapes and Space', 'Measurement', 'Position and Transformation'],
          'Algebra': ['Patterns and Relations', 'Algebraic Expressions', 'Variables and Equations'],
          'Handling Data': ['Data', 'Chance and Probability']
        },
        'Twi': {
          'Nkontabuo': ['Nkontabuo Mull', 'Mpaemuka'],
          'Nsusuiɛ ne Ahunmu Nsɛm': ['Ahunmu Nsɛm', 'Nsusuiɛ'],
          'Nsɛnkyerɛnne Nkontabuo': ['Nsɛnkyerɛnne', 'Nsɛmpɛsoɔ'],
          'Nsɛm Ho Dwumadie': ['Nkrataa So Nkyerɛkyerɛmu', 'Akontaabu Mfinimfini']
        }
      },
      'ICT': {
        'English': {
          'Intro to Computing': ['Components of Computers and Computer Systems', 'Technology in the Community (Communication)', 'Health and Safety In the Use of ICT Tools'], // Corrected typo
          'Productivity Software': ['Introduction to Word Processing', 'Introduction to Electronic Spreadsheets', 'Introduction to Presentations', 'Introduction to Desktop Publishing'],
          'Communication Networks': ['Internet and Social Media', 'Computer Networks', 'Information Security', 'Web Technologies'], // Corrected typo
          'Computational Thinking': ['Introduction to Programming', 'Algorithms', 'Robotics', 'Artificial Intelligence']
        },
        'Twi': {
          'Kɔmputa Ho Nsɛm Mfitiaseɛ': ['Mfidie Nnipadua', 'Mfidie Adwuma'],
          'Adwumayɛ Mfidie': ['Nsɛm Kyerɛw Mfidie', 'Nkontabuo Mfidie'],
          'Nkitahodie Nhyiamu': ['Intanɛt Mfitiaseɛ', 'Email Adesrɛ'],
          'Kɔmputa Dwenebɔ': ['Akwan Ahorow', 'Nsɛmnenam Ho Adesua']
        }
      },
      'Social Studies': {
        'English': {
          'Environment': ['Environmental Issues', 'Our Natural and Human Resources', 'Mapping Skills', 'Understanding Our Natural World'],
          'Family Life': ['Adolescent Reproductive Health', 'Socialisation', 'The Family', 'Population'],
          'Sense of Purpose': ['Self Identity', 'Culture and National Identity'],
          'Law and Order': ['Citizenship and Human Rights', 'The 1992 Constitution','Conflict Prevention and Management', 'Peace and Security In Our Nation', 'Promoting Democracy and Political Stability'],
          'Socio-Economic Development': ['Human Resource Development', 'Tourism', 'Science and Technology', 'Financial and Investment Issues'],
          'Nationhood': ['Independent Ghana', 'The Republics']
        },
        'Twi': {
          'Yɛn Atenaeɛ': ['Adebɔ Mu Nneɛma', 'Efi Ho Banbɔ'],
          'Abusua Asetena': ['Ahwɛdeɛ ne Asɛdeɛ', 'Abusua Sombo'],
          'Asetena mu Atirimpɔ': ['Botaeɛ Ahyɛdeɛ', 'Ɔmanfoɔ Asɛdeɛ'],
          'Mmara ne Nhyehyɛeɛ': ['Mmara Nkyerɛkyerɛmu', 'Ɔman Nhyehyɛeɛ'],
          'Asetena mu Sikasɛm Nkɔsoɔ': ['Nnwuma', 'Wiase Ayɔnkofa'],
          'Omanye': ['Ghana Hoteɛ', 'Oman Mu']
        }
      },
      'Creative Arts and Design': {
        'English': {
          'Design Principles': ['Color Theory', 'Composition', 'Typography'],
          'Creative Arts Forms': ['Drawing & Painting', 'Sculpture', 'Music', 'Drama']
        },
        'Twi': {
          'Nhyehyɛeɛ Nnyinasoɔ': ['Ahosuo Ho Nsɛm', 'Nnwom Nhyehyɛeɛ'],
          'Nsaano Adwuma Ahodoɔ': ['Mfoniniyɛ', 'Nnwom', 'Awaresɛm']
        }
      },
    };
    // Make sure this is the same comprehensive map from your previous version!
  }
}

// Placeholder for ExplanationPage - create this file next (if not already created)
/*
// explanation_page.dart
import 'package:flutter/material.dart';

class ExplanationPage extends StatelessWidget {
  final String subject;
  final String mainTopic;
  final String subTopic;
  final String language;

  const ExplanationPage({
    super.key,
    required this.subject,
    required this.mainTopic,
    required this.subTopic,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subTopic),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: $subject ($language)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Main Topic: $mainTopic', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Sub-Topic: $subTopic', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            SizedBox(height: 20),
            Text(
              'Detailed explanation for "$subTopic" under "$mainTopic" in $language goes here...',
              style: TextStyle(fontSize: 16),
            ),
            // TODO: Add actual explanation content
          ],
        ),
      ),
    );
  }
}
*/