import sys

def quienGana(j1: str, j2: str) -> str: 
  res: str = "Empate"

  if (j1 == "Piedra" and j2 == "Tijera") or (j1 == "Tijera" and j2 == "Papel") or (j1 == "Papel" and j2 == "Piedra"):
    res = "Jugador1"
  elif (j2 == "Piedra" and j1 == "Tijera") or (j2 == "Tijera" and j1 == "Papel") or (j2 == "Papel" and j1 == "Piedra"):
    res = "Jugador2"  
       
  return res


if __name__ == '__main__':
  x = input()
  jug = str.split(x)
  print(quienGana(jug[0], jug[1]))