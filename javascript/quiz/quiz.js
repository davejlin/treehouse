function Quiz() {
	this.questions = [];
	this.iCurrentQuestion = 0;
	this.nCorrect = 0;
}

Quiz.prototype.add = function(question) {
	this.questions.push(question);
}

Quiz.prototype.gradeChoice = function(choice) {
	if (this.questions[this.iCurrentQuestion].isCorrectAnswer(choice)) {
		this.nCorrect++;
	}
}

Quiz.prototype.incrementCurrentQuestion = function(){
	this.iCurrentQuestion++;
}

Quiz.prototype.handleChoice = function(choice) {
	this.gradeChoice(choice);
	this.incrementCurrentQuestion();
}

Quiz.prototype.hasEnded = function() {
	return (this.iCurrentQuestion >= this.questions.length);
}

Quiz.prototype.reset = function() {
	this.iCurrentQuestion = 0;
	this.nCorrect = 0;
}

function getRandomInt(min, max) {
//Will return a number inside the given range, inclusive of both minimum and maximum
//i.e. if min=0, max=20, returns a number from 0-20
  return Math.floor(Math.random() * (max - min + 1)) + min;
}