import 'dart:math';
import 'package:flutter/material.dart';

class EducationQuizScreen extends StatefulWidget {
  const EducationQuizScreen({super.key});

  @override
  State<EducationQuizScreen> createState() => _EducationQuizScreenState();
}

class _EducationQuizScreenState extends State<EducationQuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      "question": "What is e-waste?",
      "options": ["Electronic waste", "Energy water", "Environmental work", "Electric wind"],
      "answer": "Electronic waste"
    },
    {
      "question": "Why is recycling e-waste important?",
      "options": ["To save space", "To recover valuable materials", "Because it’s fun", "No reason"],
      "answer": "To recover valuable materials"
    },
    {
      "question": "Which of these is an example of e-waste?",
      "options": ["Plastic bottle", "Banana peel", "Old smartphone", "Paper"],
      "answer": "Old smartphone"
    },
    {
      "question": "What harmful element is often found in e-waste?",
      "options": ["Gold", "Lead", "Water", "Oxygen"],
      "answer": "Lead"
    },
    {
      "question": "What is a circular economy?",
      "options": ["Reuse & recycle products", "Throwing everything away", "Making circles", "Economy for circus"],
      "answer": "Reuse & recycle products"
    },
    {
      "question": "Which device can be turned into a digital photo frame?",
      "options": ["Laptop", "Car", "Spoon", "Shoe"],
      "answer": "Laptop"
    },
    {
      "question": "What can we do with an old keyboard?",
      "options": ["Eat it", "Make crafts", "Throw it into the sea", "Plant it"],
      "answer": "Make crafts"
    },
    {
      "question": "What percent of phone materials can usually be reused?",
      "options": ["10%", "50%", "80%", "0%"],
      "answer": "80%"
    },
    {
      "question": "Which of these is NOT an e-waste item?",
      "options": ["Smartwatch", "Television", "Microwave", "Potato"],
      "answer": "Potato"
    },
    {
      "question": "What does ‘sustainable’ mean?",
      "options": ["Something we can keep doing", "Something expensive", "Something heavy", "Something broken"],
      "answer": "Something we can keep doing"
    },
    {
      "question": "What can we turn a broken TV into?",
      "options": ["Light box", "Fish tank", "Bookshelf", "All of the above"],
      "answer": "All of the above"
    },
    {
      "question": "What happens if e-waste is thrown into landfills?",
      "options": ["It grows", "It leaks toxins", "It disappears", "It turns into gold"],
      "answer": "It leaks toxins"
    },
    {
      "question": "Which of these is a benefit of upcycling?",
      "options": ["Less waste", "More pollution", "More garbage", "Higher costs"],
      "answer": "Less waste"
    },
    {
      "question": "What should you do with an old mouse?",
      "options": ["Recycle or reuse it", "Eat it", "Flush it", "Throw it on the road"],
      "answer": "Recycle or reuse it"
    },
    {
      "question": "What does ‘reuse’ mean?",
      "options": ["Use again", "Throw away", "Break it", "Ignore it"],
      "answer": "Use again"
    },
    {
      "question": "What’s one creative idea for an old microwave?",
      "options": ["Make it a plant pot", "Eat it", "Throw it in water", "Bury it"],
      "answer": "Make it a plant pot"
    },
    {
      "question": "E-waste can harm which of these?",
      "options": ["Environment", "Human health", "Animals", "All of the above"],
      "answer": "All of the above"
    },
    {
      "question": "What is an eco-friendly habit?",
      "options": ["Repair devices", "Throw everything", "Buy more junk", "Burn electronics"],
      "answer": "Repair devices"
    },
    {
      "question": "What metal can be recovered from e-waste?",
      "options": ["Gold", "Silver", "Copper", "All of the above"],
      "answer": "All of the above"
    },
    {
      "question": "How can e-waste support schools?",
      "options": ["Donate old laptops", "Ignore them", "Pollute them", "Sell garbage"],
      "answer": "Donate old laptops"
    },
    {
      "question": "Why should we not burn e-waste?",
      "options": ["It smells good", "It releases toxins", "It’s fun", "It grows trees"],
      "answer": "It releases toxins"
    },
    {
      "question": "What is upcycling?",
      "options": ["Making something new from old", "Breaking things", "Buying new", "Throwing away"],
      "answer": "Making something new from old"
    },
    {
      "question": "What is the goal of recycling?",
      "options": ["Reduce waste", "Increase waste", "Make more trash", "None of the above"],
      "answer": "Reduce waste"
    },
    {
      "question": "What happens if we ignore e-waste?",
      "options": ["It pollutes", "It disappears", "It cleans itself", "It fixes itself"],
      "answer": "It pollutes"
    },
    {
      "question": "Why is e-waste dangerous?",
      "options": ["It contains toxic chemicals", "It is tasty", "It is heavy", "It is shiny"],
      "answer": "It contains toxic chemicals"
    },
  ];

  late List<Map<String, dynamic>> _quizQuestions;
  int _currentQuestion = 0;
  int _score = 0;
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _quizQuestions = [..._questions]..shuffle();
    _quizQuestions = _quizQuestions.take(10).toList();
  }

  void _checkAnswer(String selected) {
    bool isCorrect = selected == _quizQuestions[_currentQuestion]['answer'];
    if (isCorrect) _score++;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? '✅ Correct!' : '❌ Wrong!'),
        content: Text('Answer: ${_quizQuestions[_currentQuestion]['answer']}'),
        actions: [
          TextButton(
            child: const Text('Next'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                if (_currentQuestion < _quizQuestions.length - 1) {
                  _currentQuestion++;
                } else {
                  _quizCompleted = true;
                }
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: _quizCompleted
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '🎉 Quiz Completed!',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Your score: $_score / 10',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _currentQuestion = 0;
                                  _score = 0;
                                  _quizCompleted = false;
                                  _quizQuestions = [..._questions]..shuffle();
                                  _quizQuestions =
                                      _quizQuestions.take(10).toList();
                                });
                              },
                              child: const Text('Restart Quiz'),
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Question ${_currentQuestion + 1} of 10',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _quizQuestions[_currentQuestion]['question'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 20),
                              ...(_quizQuestions[_currentQuestion]['options']
                                      as List<String>)
                                  .map(
                                    (opt) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: ElevatedButton(
                                        onPressed: () => _checkAnswer(opt),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(opt),
                                      ),
                                    ),
                                  )
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
