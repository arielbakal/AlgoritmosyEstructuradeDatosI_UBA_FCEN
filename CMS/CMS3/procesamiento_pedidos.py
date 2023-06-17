from queue import Queue
from typing import List
from typing import Dict
from typing import Union
import json

# ACLARACIÓN: El tipo de "pedidos" debería ser: pedidos: Queue[Dict[str, Union[int, str, Dict[str, int]]]]
# Por no ser soportado por la versión de CMS, usamos simplemente "pedidos: Queue"
def procesamiento_pedidos(pedidos: Queue,
                          stock_productos: Dict[str, int],
                          precios_productos: Dict[str, float]) -> List[Dict[str, Union[int, str, float, Dict[str, int]]]]:
  
  # inicializo mis pedidos procesados
  pedidos_procesados: List = []
  # llamo mi stock de productos para ir actualizandose segun pasan los pedidos
  stock_productos_final: Dict[str, int] = stock_productos

  # ITERACION SOBRE LOS PEDIDOS #
  while not pedidos.empty():

    pedido: Dict[str, Union[int, str, Dict[str, int]]] = pedidos.get() # tomo primer pedido de la cola

    pedido_procesado: Dict[str, Union[int, str, float, Dict[str, int]]] = pedido  # parto del pedido y lo voy procesando
    estado: str = 'completo'  # inicializo el estado, por default 'completo'
    precio_total: float = 0  # inicializo el precio_total

    # Itero los productos y su cantidad pedida #
    for producto_pedido, cantidad_pedida in pedido['productos'].items():

      cantidad_pedida_final: int = 0  # inicializo la cantidad total que se lleva el cliente

      stock: int = stock_productos[producto_pedido]  # tomo el stock del producto

      # Comparo stock con la cantidad pedida #
      if stock == 0: # Sin stock

        estado = 'incompleto'
        pedido_procesado['productos'][producto_pedido] = stock  # !

      elif cantidad_pedida > stock: # Pedido excede stock

        estado = 'incompleto'
        precio_total += ( stock * precios_productos[producto_pedido] )
        cantidad_pedida_final = stock
        pedido_procesado['productos'][producto_pedido] = cantidad_pedida_final  # !

      else: # Pedido <= stock

        precio_total += ( cantidad_pedida * precios_productos[producto_pedido] )
        cantidad_pedida_final = cantidad_pedida
        pedido_procesado['productos'][producto_pedido] = cantidad_pedida_final  # !
      
      # ! : detallo la cantidad final que se lleva el cliente de un pedido

      stock_productos_final[producto_pedido] = stock - cantidad_pedida_final  # Actualizo el stock
    
    pedido_procesado['precio_total'] = precio_total  
    pedido_procesado['estado'] = estado 

    pedidos_procesados.append(pedido_procesado)  # agrego el pedido procesado

  return pedidos_procesados


if __name__ == '__main__':
  pedidos: Queue = Queue()
  list_pedidos = json.loads(input())
  [pedidos.put(p) for p in list_pedidos]
  stock_productos = json.loads(input())
  precios_productos = json.loads(input())
  print("{} {}".format(procesamiento_pedidos(pedidos, stock_productos, precios_productos), stock_productos))

# Ejemplo input  
# pedidos: [{"id":21,"cliente":"Gabriela", "productos":{"Manzana":2}}, {"id":1,"cliente":"Juan","productos":{"Manzana":2,"Pan":4,"Factura":6}}]
# stock_productos: {"Manzana":10, "Leche":5, "Pan":3, "Factura":0}
# precios_productos: {"Manzana":3.5, "Leche":5.5, "Pan":3.5, "Factura":5}