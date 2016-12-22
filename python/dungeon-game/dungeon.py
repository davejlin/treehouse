import random

CELLS = [(0,0), (0,1), (0,2),
		 (1,0), (1,1), (1,2),
		 (2,0), (2,1), (2,2)]

player = (0,0)
door = (0,0)
dragon = (0,0)

def set_initial_positions():
	while True:
		player = random.choice(CELLS)
		door = random.choice(CELLS)
		dragon = random.choice(CELLS)

		if player != door and door != dragon and player != dragon:
			break

	return player, door, dragon

def move_player(player, move):
	if move == 'UP':
		player = (player[0]-1, player[1])
	elif move == 'DOWN':
		player = (player[0]+1, player[1])
	elif move == 'RIGHT':
		player = (player[0], player[1]+1)
	elif move == 'LEFT':
		player = (player[0], player[1]-1)

	return player

def get_moves(player):
	xPlayer = player[1]
	yPlayer = player[0]

	moves = []

	if yPlayer > 0:
		moves.append('UP')

	if yPlayer < 2:
		moves.append('DOWN')

	if xPlayer < 2:
		moves.append('RIGHT')

	if xPlayer > 0:
		moves.append('LEFT')

	return moves

def check_win_lose(player, door, dragon):
	if player == door:
		print("\n*** Congratulations! You escaped!! ***\n")
		return True
	elif player == dragon:
		print("\n*** Sorry, the dragon got you! ***\n")
		return True
	else:
		return False

def draw_map(player):
	print(' _ _ _')
	tile = '|{}'
	for idx, cell in enumerate(CELLS):
		if idx in [0, 1, 3, 4, 6, 7]:
			if cell == player:
				print(tile.format('X'), end = '')
			else:
				print(tile.format('_'), end = '')
		else:
			if cell == player:
				print(tile.format('X|'))
			else:
				print(tile.format('_|'))

# main
print("Welcome to the dungeon!")
(player, door, dragon) = set_initial_positions()

while True:
	print("You're currently in room {}.".format(player))
	draw_map(player)

	valid_moves = get_moves(player)
	
	print("You can move {}.".format(valid_moves))
	print("Enter QUIT to quit.")

	move = input("> ")
	move = move.upper()

	if move == 'QUIT':
		break

	if move not in valid_moves:
		print("\n*** Sorry, you cannot move {}.  Try again!\n".format(move))
		continue

	player = move_player(player, move)

	if check_win_lose(player, door, dragon):
		break

