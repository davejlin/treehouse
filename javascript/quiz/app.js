var quiz = new Quiz();
var quizUI = new QuizUI();

quiz.add(new Question("What is 1 + 1?", ["0","1","2"], "2"));
quiz.add(new Question("What is 2 + 1?", ["1","2","3","4"], "3"));
quiz.add(new Question("What is 3 + 0?", ["2","3"], "3"));
quiz.add(new Question("What is 4 + 1?", ["3","4","5","6","7"], "5"));

quizUI.renderQuiz();