from queue import Queue

# El tipo de fila debería ser Queue[int], pero la versión de python del CMS no lo soporta. Usaremos en su lugar simplemente "Queue"
def avanzarFila(fila: Queue, min: int):

  historico_clientes: int = fila.qsize() 

  # 10:00
  historico_clientes += 1
  fila.put(historico_clientes) # agrego nueva persona 

  if min >= 1 :

    cliente_sin_solucion: int = 0
    i: int = 0 # contador de 3 min para reingresar cliente_sin_solucion a la fila
  
    for m in range(1, min + 1):

      if (m % 4 == 0):
        historico_clientes += 1
        fila.put(historico_clientes)

      i += 1
      
      if i == 3 and cliente_sin_solucion != 0:
        fila.put(cliente_sin_solucion)

      if not fila.empty():
        # CAJA 1
        if (((m - 1) % 10) == 0) or m == 1:
          fila.get()

        # CAJA 2  
        if (((m - 3) % 4) == 0) or m == 3:
          fila.get()

        # CAJA 3
        if (((m - 2) % 4) == 0) or m == 2:
          i = 0
          cliente_sin_solucion = fila.get()

if __name__ == '__main__':
  fila: Queue = Queue()
  fila_inicial: int = int(input())
  for numero in range(1, fila_inicial+1):
    fila.put(numero)
  min: int = int(input())
  avanzarFila(fila, min)
  res = []
  for i in range(0, fila.qsize()):
    res.append(fila.get())
  print(res)


# Caja1: Empieza a atender 10:01, y atiende a una persona cada 10 minutos
# Caja2: Empieza a atender 10:03, atiende a una persona cada 4 minutos
# Caja3: Empieza a atender 10:02, y atiende una persona cada 4 minutos, pero no le resuelve el problema y la persona debe volver a la fila (se va al final y tarda 3 min en llegar. Es decir, la persona que fue atendida 10:02 vuelve a entrar a la fila a las 10:05)
# La fila empieza con las n personas que llegaron antes de que abra el banco. Cuando abre (a las 10), cada 4 minutos llega una nueva persona a la fila (la primera entra a las 10:00)

