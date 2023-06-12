## Programas interactivos

# 3.1
def nombres_estudiantes():
    nombre: str = input("Ingrese estudiante:")
    res: list = []

    while nombre != "listo":
        res.append(nombre)
        nombre = input("Ingrese estudiante:")
    
    print(res)

# 3.2
def historial_monedero():
    saldo: int = 0
    movimientos: list = []
    monto: int = 0

    while True:
        print("\n------ Menú ------")
        print("1. Cargar créditos")
        print("2. Descontar créditos")
        print("3. Finalizar la simulación")
        
        opcion = input("\nSelecciona una opción: ")
        
        if opcion == "1":
            monto = int(input("\nIngrese el monto: "))
            saldo += monto
            movimientos.append(("C", monto))

        
        elif opcion == "2":
            monto = int(input("\nIngrese el monto: "))
            saldo -= monto
            movimientos.append(("D", monto))
            
        elif opcion == "3":
            print("\nFinalizando simulacion...")
            print("\nHistorial: ")
            for i in range(0, len(movimientos)):
                print(movimientos[i])
            print("\nSaldo final =", saldo)
            break
        
        else:
            print("Elija una opción válida.")

# 4.2

def es_matriz(matriz: list) -> bool:
    res: bool = True

    if len(matriz) == 0 or len(matriz[0]) == 0:
        res = False
    else:  
        for i in range(0, len(matriz)):
            if len(matriz[i]) != len(matriz[0]):
                res = False

    return res
