from typing import List
from typing import Dict
import json

def unir_diccionarios(a_unir: List[Dict[str,str]]) -> Dict[str,List[str]]:

  res: Dict[str,List[str]] = {}
    
  for diccionario in a_unir:
    for clave, valor in diccionario.items():
      if clave in res:
        res[clave].append(valor)
      else:
        res[clave] = [valor]

  return res


if __name__ == '__main__':
  x = json.loads(input()) # Ejemplo de input: [{"a":2},{"b":3,"a":1}]
  print(unir_diccionarios(x))