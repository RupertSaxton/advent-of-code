#!/usr/bin/python3

instructions = ''

with open('input1.txt', 'r') as f:
	instructions += f.readline()

def find_instruction_index(instructions, target):
	floor = 0
	index = 0

	for idx, paren in enumerate(instructions):
		if paren == ')':
			floor -= 1
		elif paren == '(':
			floor += 1

		if floor == target:
			index = idx
			break

	return index

print(find_instruction_index(instructions, -1))
