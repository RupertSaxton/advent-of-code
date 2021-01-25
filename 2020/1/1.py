#!/usr/bin/python3

expenses = []

with open('input1.txt', 'r') as f:
    for x in f:
        expenses.append(int(x))

expenses.sort()

lower = 0
upper = len(expenses) - 1
while lower < upper:
    total = expenses[lower] + expenses[upper]
    if total == 2020:
        break
    elif total > 2020:
        upper -= 1
    else:
        lower += 1

print(f'{expenses[lower] * expenses[upper]}')
