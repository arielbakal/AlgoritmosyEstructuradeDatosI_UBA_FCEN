from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
def mesetaMasLarga(l: List[int]) -> int : 
  res: int = 1
  contador: int = 1

  if len(l) == 0:
    res: int = 0

  if len(l) >= 2:
    for i in range(0, len(l)-1, 1):
      if l[i] == l[i+1]:
        contador += 1
      else: 
        contador = 1
      if contador > res:
        res = contador
        
  return res

if __name__ == '__main__':
  x = input()
  print(mesetaMasLarga([int(j) for j in x.split()]))