import 'package:flutter/material.dart';
import 'homepage.dart';
import 'topics.dart';
import 'chat.dart';


// --- Data Structures for Quiz ---
class QuizQuestion {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex; // Index of the correct option in the options list

  QuizQuestion({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// --- Sample Quiz Data ---
final Map<String, List<QuizQuestion>> sampleQuizzes = {
  'English': [
    QuizQuestion(
      questionText: 'Which word is a synonym for "happy"?',
      options: ['Sad', 'Joyful', 'Angry', 'Tired'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What is the plural form of "child"?',
      options: ['Childs', 'Childes', 'Children', 'Childer'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Choose the correct verb: The dogs ___ barking loudly.',
      options: ['is', 'are', 'was', 'be'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which of these is a pronoun?',
      options: ['Run', 'Quickly', 'She', 'Beautiful'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What punctuation mark is used at the end of a question?',
      options: [
        'Period (.)',
        'Comma (,)',
        'Question Mark (?)',
        'Exclamation Mark (!)'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Identify the adjective in the sentence: "The red car is fast."',
      options: ['Car', 'Red', 'Fast', 'Is'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What is the opposite of "hot"?',
      options: ['Warm', 'Cold', 'Spicy', 'Burning'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which sentence is grammatically correct?',
      options: [
        'Her goed to the store.',
        'She went to the store.',
        'She goed to store.',
        'Her went to store.'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What does the prefix "un-" mean in "unhappy"?',
      options: ['Very', 'Not', 'Again', 'Before'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which word is a noun?',
      options: ['Sing', 'Song', 'Softly', 'Loud'],
      correctAnswerIndex: 1,
    ),
  ],
  'Science': [
    QuizQuestion(
      questionText: 'What is H2O commonly known as?',
      options: ['Salt', 'Sugar', 'Water', 'Oxygen'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which planet is known as the Red Planet?',
      options: ['Earth', 'Mars', 'Jupiter', 'Venus'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What gas do plants absorb from the atmosphere?',
      options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What force pulls objects towards the center of the Earth?',
      options: ['Magnetism', 'Friction', 'Gravity', 'Tension'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is the process by which plants make their own food?',
      options: ['Respiration', 'Photosynthesis', 'Digestion', 'Transpiration'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'How many legs does a spider have?',
      options: ['4', '6', '8', '10'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is the largest organ in the human body?',
      options: ['Heart', 'Brain', 'Liver', 'Skin'],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      questionText: 'Sound travels fastest through which of these?',
      options: ['Air', 'Water', 'Solids', 'Vacuum'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is the primary source of energy for the Earth?',
      options: ['Moon', 'Stars', 'Sun', 'Wind'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which of these is a mammal?',
      options: ['Shark', 'Lizard', 'Whale', 'Frog'],
      correctAnswerIndex: 2,
    ),
  ],
  'Mathematics': [
    QuizQuestion(
      questionText: 'What is 5 multiplied by 7?',
      options: ['12', '30', '35', '40'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'How many sides does a triangle have?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What is 100 divided by 10?',
      options: ['1', '10', '20', '1000'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'If a square has a side length of 4 cm, what is its perimeter?',
      options: ['8 cm', '12 cm', '16 cm', '20 cm'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is 15 + 23?',
      options: ['35', '38', '42', '45'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which of these numbers is an even number?',
      options: ['7', '11', '14', '19'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is the next number in the sequence: 2, 4, 6, 8, __?',
      options: ['9', '10', '11', '12'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'How many minutes are in an hour?',
      options: ['30', '45', '60', '90'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is 50 - 17?',
      options: ['23', '30', '33', '37'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which shape has no corners?',
      options: ['Square', 'Triangle', 'Rectangle', 'Circle'],
      correctAnswerIndex: 3,
    ),
  ],
  'ICT': [
    QuizQuestion(
      questionText: 'What does "CPU" stand for?',
      options: [
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Program Unit',
        'Computer Power Unit'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      questionText: 'Which of these is an input device?',
      options: ['Monitor', 'Printer', 'Keyboard', 'Speaker'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What does "WWW" stand for in a website address?',
      options: [
        'World Wide Web',
        'Web World Wide',
        'Wide World Web',
        'World Web Wide'
      ],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      questionText: 'Which software is used for browsing the internet?',
      options: ['Word Processor', 'Spreadsheet', 'Web Browser', 'Media Player'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is a common way to send electronic messages?',
      options: ['Post Office', 'Email', 'Fax', 'Telegram'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which of these is a type of computer memory?',
      options: ['RAM', 'CPU', 'URL', 'USB'],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      questionText: 'What is used to click and select items on a computer screen?',
      options: ['Keyboard', 'Mouse', 'Scanner', 'Microphone'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which company developed the Windows operating system?',
      options: ['Apple', 'Google', 'Microsoft', 'IBM'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is a "file" in a computer context?',
      options: [
        'A metal tool',
        'A collection of data',
        'A type of folder',
        'A hardware component'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'To protect your computer from harmful software, you should install:',
      options: ['Games', 'Antivirus software', 'More browsers', 'Photo editor'],
      correctAnswerIndex: 1,
    ),
  ],
  'Social Studies': [
    QuizQuestion(
      questionText: 'What is the capital city of Ghana?',
      options: ['Kumasi', 'Accra', 'Takoradi', 'Tamale'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Who is the head of state in a republic like Ghana?',
      options: ['King', 'Prime Minister', 'President', 'Chief'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which of these is a primary color?',
      options: ['Green', 'Orange', 'Blue', 'Purple'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is the main function of the Police Service?',
      options: [
        'Making laws',
        'Teaching students',
        'Maintaining law and order',
        'Farming'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'A map is used for?',
      options: [
        'Cooking food',
        'Finding locations',
        'Playing music',
        'Building houses'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which Ghanaian festival is celebrated by the Ga people?',
      options: ['Hogbetsotso', 'Aboakyir', 'Homowo', 'Damba'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is the currency used in Ghana?',
      options: ['Dollar', 'Naira', 'Cedi', 'Euro'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which of these is a responsibility of a good citizen?',
      options: ['Littering', 'Paying taxes', 'Ignoring laws', 'Fighting'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What is the name of the large man-made lake in Ghana?',
      options: ['Lake Bosomtwe', 'Lake Chad', 'Lake Victoria', 'Lake Volta'],
      correctAnswerIndex: 3,
    ),
    QuizQuestion(
      questionText: 'Our environment includes:',
      options: [
        'Only buildings',
        'Only people',
        'Living and non-living things',
        'Only schools'
      ],
      correctAnswerIndex: 2,
    ),
  ],
  'Creative Arts and Design': [
    QuizQuestion(
      questionText: 'Which of these is a tool used for drawing straight lines?',
      options: ['Brush', 'Ruler', 'Palette', 'Sponge'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What are the primary colors in painting?',
      options: [
        'Green, Orange, Purple',
        'Red, Yellow, Blue',
        'Black, White, Grey',
        'Brown, Pink, Teal'
      ],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'Which material is commonly used for sculpting?',
      options: ['Paper', 'Clay', 'Water', 'Fabric'],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      questionText: 'What is a "collage" in art?',
      options: [
        'A type of paint',
        'A song',
        'Art made by sticking various materials together',
        'A dance style'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which of these is a musical instrument?',
      options: ['Easel', 'Chisel', 'Drum', 'Canvas'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is "texture" in art?',
      options: [
        'The color of an object',
        'The sound an object makes',
        'How a surface feels or looks like it would feel',
        'The size of an object'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which art form involves using thread and needle?',
      options: ['Pottery', 'Painting', 'Embroidery', 'Origami'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What is a "pattern" in design?',
      options: [
        'A single color',
        'A random arrangement',
        'A repeated decorative design',
        'A type of brush'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'What do you mix to get the color green?',
      options: [
        'Red and Yellow',
        'Blue and Red',
        'Yellow and Blue',
        'Red and White'
      ],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      questionText: 'Which of these is an example of Ghanaian traditional textile?',
      options: ['Denim', 'Silk', 'Kente', 'Velvet'],
      correctAnswerIndex: 2,
    ),
  ],
};

// List of subjects for selection
const List<String> subjectsForQuiz = [
  'English',
  'Science',
  'Mathematics',
  'ICT',
  'Social Studies',
  'Creative Arts and Design',
];
// --- End Quiz Data ---

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  String? _selectedSubject;
  List<QuizQuestion> _currentQuizQuestions = [];
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;
  bool _quizCompleted = false;

  // Added for BottomNavigationBar
  // 0: Home, 1: Topics, 2: Quiz, 3: Chat
  final int _currentBottomNavIndex = 2; // Quiz is the active tab here

  // Placeholder for last selected subject and language for TopicsPage
  String _lastSelectedTopicSubject = 'English'; // Example default
  String _lastSelectedTopicLanguage = 'English'; // Example default


  void _startQuiz(String subject) {
    if (sampleQuizzes.containsKey(subject) &&
        sampleQuizzes[subject]!.length >= 10) {
      setState(() {
        _selectedSubject = subject;
        // Shuffle questions for variety each time, then take 10
        var allQuestions = List<QuizQuestion>.from(sampleQuizzes[subject]!);
        allQuestions.shuffle();
        _currentQuizQuestions = allQuestions.take(10).toList();
        _currentQuestionIndex = 0;
        _selectedOptionIndex = null;
        _score = 0;
        _quizCompleted = false;
      });
    } else {
      if (mounted) { // Check if widget is still in the tree
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Quiz for $subject is not available or has less than 10 questions.')),
        );
      }
    }
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _nextQuestion() {
    if (_selectedOptionIndex == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an answer!')),
        );
      }
      return;
    }

    if (_selectedOptionIndex ==
        _currentQuizQuestions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _currentQuizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      _selectedSubject = null;
      _currentQuizQuestions = [];
      _currentQuestionIndex = 0;
      _selectedOptionIndex = null;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedSubject == null
            ? 'Select Quiz Subject'
            : '$_selectedSubject Quiz'),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        foregroundColor: Colors.white,
        actions: [
          if (_selectedSubject != null && !_quizCompleted)
            TextButton(
              onPressed: _resetQuiz,
              child: const Text('Change Subject',
                  style: TextStyle(color: Colors.white)),
            )
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _selectedSubject ==
          null // Only show when selecting a subject
          ? BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme
            .of(context)
            .cardColor,
        selectedItemColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
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
          if (index == _currentBottomNavIndex) return;

          switch (index) {
            case 0: // Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
              break;
            case 1: // Topics
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TopicsPage(
                          subject: _lastSelectedTopicSubject,
                          language: _lastSelectedTopicLanguage,
                        )),
              );
              break;
            case 2: // Quiz (Current Page)
            // Should not happen if index == _currentBottomNavIndex check is working
              break;
            case 3: // Chat
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage(question:"")),
              );
              break;
          }
        },
      )
          : null, // No BottomNavigationBar during the quiz or on results page
    );
  }

  Widget _buildBody() {
    if (_quizCompleted) {
      return _buildResultsPage();
    }
    if (_selectedSubject == null) {
      return _buildSubjectSelectionPage();
    }
    return _buildQuizTakingPage();
  }

  Widget _buildSubjectSelectionPage() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16.0, 16.0, 16.0, _selectedSubject == null ? 70.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Choose a subject to start the quiz:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: subjectsForQuiz.length,
              itemBuilder: (context, index) {
                final subject = subjectsForQuiz[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(subject, style: const TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _startQuiz(subject),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizTakingPage() {
    if (_currentQuizQuestions.isEmpty) {
      // This can happen briefly if _startQuiz is somehow delayed
      // or if there's an issue loading questions.
      return const Center(child: Text("Loading questions..."));
    }
    if (_currentQuestionIndex >= _currentQuizQuestions.length) {
      // Safety check, should ideally not be reached if logic is correct
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _quizCompleted = true;
        });
      });
      return const Center(child: Text("Finishing quiz..."));
    }


    final question = _currentQuizQuestions[_currentQuestionIndex];
    bool isLastQuestion =
        _currentQuestionIndex == _currentQuizQuestions.length - 1;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${_currentQuestionIndex + 1}/${_currentQuizQuestions
                .length}',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                question.questionText,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  color: _selectedOptionIndex == index
                      ? Theme
                      .of(context)
                      .primaryColorLight
                      .withOpacity(0.5)
                      : Theme
                      .of(context)
                      .cardColor,
                  child: RadioListTile<int>(
                    title: Text(question.options[index]),
                    value: index,
                    groupValue: _selectedOptionIndex,
                    onChanged: (int? value) {
                      if (value != null) {
                        _selectOption(value);
                      }
                    },
                    activeColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
            _selectedOptionIndex == null ? null : _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(isLastQuestion ? 'Finish Quiz' : 'Next Question'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsPage() {
    double percentage = _currentQuizQuestions.isNotEmpty
        ? (_score / _currentQuizQuestions.length) * 100
        : 0;
    String feedback;
    Color feedbackColor;

    if (percentage >= 80) {
      feedback = 'Excellent Work!';
      feedbackColor = Colors.green.shade700;
    } else if (percentage >= 60) {
      feedback = 'Good Job!';
      feedbackColor = Colors.lightGreen.shade700;
    } else if (percentage >= 40) {
      feedback = 'Not Bad, Keep Practicing!';
      feedbackColor = Colors.orange.shade700;
    } else {
      feedback = 'Needs More Practice.';
      feedbackColor = Colors.redAccent.shade700;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Text(
              'Your Score for $_selectedSubject:',
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '$_score / ${_currentQuizQuestions.length}',
              style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .primaryColorDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '(${percentage.toStringAsFixed(1)}%)',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Text(
              feedback,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: feedbackColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: _resetQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Take Another Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}