function QuizUI() {

}

QuizUI.prototype.assignContentToElementById = function(id, content) {
	var element = document.getElementById(id);
	element.innerHTML = content;
}

QuizUI.prototype.renderQuiz = function() {
	if (quiz.hasEnded()){
		this.renderResults();
	} else {
		this.renderQuestionsUI(quiz.questions[quiz.iCurrentQuestion].choices.length);
		this.renderNextQuestionSet();
	}
}

QuizUI.prototype.renderQuestionsUI = function(nChoices) {
	var html = '<h1>Awesome Quiz</h1>';
	html += '<h2 id="question" class="headline-secondary--grouped"></h2>';

	for (var i=0; i<nChoices; i++) {
		html += '<p id="choice';
		html += i.toString();
		html += '"></p>';
	    html += '<button id="guess';
	    html += i.toString();
	    html += '" class="btn--default">Select Answer</button>';
    }

    html += '<footer>';
    html += '<p id="progress"></p>';
    html += '</footer>';
	this.assignContentToElementById("quiz", html);
}

QuizUI.prototype.renderNextQuestionSet = function() {
	this.renderQuestion();
	this.renderChoices();
	this.renderQuestionsCount();
}

QuizUI.prototype.renderChoices = function() {
	for (var i=0; i<quiz.questions[quiz.iCurrentQuestion].choices.length; i++) {
		
		var choiceElementId = "choice" + i.toString();
		var choiceContent = quiz.questions[quiz.iCurrentQuestion].choices[i];
		this.assignContentToElementById(choiceElementId, choiceContent);

		var buttonId = "guess" + i.toString();
		this.assignButtonOnClick(buttonId, choiceContent);
	}
}

QuizUI.prototype.assignButtonOnClick = function(id, choiceContent) {
		var button = document.getElementById(id);
		button.onclick = function() {
			quiz.handleChoice(choiceContent);
			quizUI.renderQuiz();
		}
}

QuizUI.prototype.renderResults = function() {
	this.renderResultsUI();
	this.renderResultsContent();
	var button = document.getElementById("retake");
	button.onclick = function() {
		quiz.reset();
		quizUI.renderQuiz();
	}
}

QuizUI.prototype.renderResultsUI = function() {
	var html = '<h1>Quiz Results</h1>';
	html += '<h2 id="results" class="headline-secondary--grouped"></h2>';
	html += '<button id="retake" class="btn--default">Retake Quiz</button>';
	this.assignContentToElementById("quiz", html);
}

QuizUI.prototype.renderResultsContent = function() {
	var html = "You got ";
	html += quiz.nCorrect.toString();
	html += " out of ";
	html += quiz.questions.length.toString();
	html += " questions correct!";
	this.assignContentToElementById("results", html);
}

QuizUI.prototype.renderQuestion = function() {
	var html = '<p>';
	html += quiz.questions[quiz.iCurrentQuestion].question;
	html += '</p>';
	this.assignContentToElementById("question", html)
}

QuizUI.prototype.renderQuestionsCount = function() {
	var html = "Question ";
	html += (quiz.iCurrentQuestion + 1).toString();
	html += " out of ";
	html += quiz.questions.length.toString();
	this.assignContentToElementById("progress", html);
}