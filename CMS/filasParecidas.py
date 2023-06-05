from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
def filasParecidas(matriz: List[List[int]]) -> bool :
  res: bool = True
  enteros: List[int] = []

  # Falta caso para len(matriz) == 1
  
  if len(matriz) > 1:
    for i in range(1, len(matriz), 1):
        for j in range(0, len(matriz[i]), 1):
            enteros.append(matriz[len(matriz) -i -1][j] - matriz[len(matriz) - i][j])

        for s in range(0, len(enteros) - 1):
            if enteros[s] != enteros[s+1]:
                res = False
                return res
        enteros.clear()
        
  return res


if __name__ == '__main__':
  filas = int(input())
  columnas = int(input())
 
  matriz = []
 
  for i in range(filas):         
    fila = input()
    if len(fila.split()) != columnas:
      print("Fila " + str(i) + " no contiene la cantidad adecuada de columnas")
    matriz.append([int(j) for j in fila.split()])
  
  print(filasParecidas(matriz))