import sys

def fibonacciNoRecursivo(n: int) -> int:
  res: int = 0
  l: list = [0]

  if n >= 1:
    l.append(1)

  if n > 1:
    for i in range(2, n+1, 1):
      l.append(l[i-1] + l[i-2])
  
  res = l[len(l)-1]

  return res


if __name__ == '__main__':
  x = int(input())
  print(fibonacciNoRecursivo(x))