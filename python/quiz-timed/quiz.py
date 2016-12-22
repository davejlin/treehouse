import datetime
import random

from questions import Add, Multiply


class Quiz:
	questions = []
	answers = []

	def __init__(self):
		question_types = (Add, Multiply)
		for i in range(10):
			
			a = random.randint(0,10)
			b = random.randint(0,10)
			
			question = random.choice(question_types)(a, b)

			self.questions.append(question)

	def take_quiz(self):
		start_time = datetime.datetime.now()
		
		for question in self.questions:
			result, start, end = self.ask(question)
			if result:
				print("You got it right!")
			else:
				print("Woops, the correct answer is: ", str(question.answer))
		
			self.output_timediff("I took you {} to solve the question.", start, end)
			self.answers.append(result)

		end_time = datetime.datetime.now()
		self.summary(start_time, end_time)


	def ask(self, question):
		start = datetime.datetime.now()
		answer = input("What is: {} > ".format(question.text))
		end = datetime.datetime.now()

		return int(answer) == question.answer, start, end


	def summary(self, start, end):
		n_questions = len(self.questions)
		n_correct = len(list(filter(lambda x: x, self.answers)))
		print("\nYou got {} out of {} correct.".format(n_correct, n_questions))
		self.output_timediff("It took you {} to answer all the questions.", start, end)
		return

	def output_timediff(self, text, start, end):
		diff = end-start
		total_seconds = diff.total_seconds()
		hours, remainder = divmod(total_seconds, 3600)
		minutes, seconds = divmod(remainder, 60)

		if hours > 0:
			time_str = "{} hr {} min {} sec".format(hours, minutes, seconds)
		elif minutes > 0:
			time_str = "{} min {} sec".format(minutes, seconds)
		else:
			time_str = "{} sec".format(seconds)
			
		print(text.format(time_str))

quiz = Quiz()
quiz.take_quiz()