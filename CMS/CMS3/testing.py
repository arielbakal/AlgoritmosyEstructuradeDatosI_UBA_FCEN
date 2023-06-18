from queue import Queue

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
        cliente_sin_solucion = 0

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

fila = Queue()

avanzarFila(fila, 15)