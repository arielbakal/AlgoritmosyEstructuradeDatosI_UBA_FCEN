from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
def filasParecidas(matriz: List[List[int]]) -> bool :
  res: bool = False
  fila: List[int] = []
  fila2: List[int] = []

  if len(matriz) == 1:
    return res
  
  elif len(matriz) > 1:

    for s in range(0, len(matriz)): # Recorro filas

        for r in range(0, len(matriz[0])): # Recorro la fila s y la guardo
            fila.append(matriz[s][r])

        for i in range(0, len(matriz)): # Recorro las filas != s
            if i != s:
                for j in range(0, len(matriz[0])):
                    fila2.append(matriz[i][j])
            if fila == fila2: # Comparo fila s con fila != s
                res = True
                return res
            else:
                fila2.clear()
        
        fila.clear()
        
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