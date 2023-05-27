# guia 8 ej 1.3

# usando for, iterando sobre los elementos de la lista
def suma_total1(s: list) -> int:
    res: int = 0

    for i in s:
        res = res + i

    return res

# usando for, usando los indices de la lista
def suma_total2(s: list) -> int:
    res: int = 0

    # range(desde, hasta, 1) = [desde, desde+1, desde+2, ...., hasta-1]
    for i in range(0, len(s), 1):
        res = res + s[i]

    return res

# version con while
def suma_total3(s: list) -> int:
    res: int = 0
    i: int = 0

    while i < len(s):
        res = res + s[i]
        i = i + 1

    return res


# guia 8 ej 1.4

# version con for iterando sobre los indices de la lista,
# comparando un elemento con el siguiente
def ordenado1(s: list) -> bool:
    res : bool = True

    for i in range(0, len(s)-1, 1):
        if s[i] >= s[i+1]:
            res = False
    
    return res

# comparando un elemento con el anterior 
def ordenado2(s: list) -> bool:
    res : bool = True

    for i in range(1, len(s), 1):
        if s[i-1] >= s[i]:
            res = False
        
    return res

# implementacion 'tramposa' usando sort()
def ordenado2(s: list) -> bool:
    aux : list = s.copy()
    res : bool = False

    s.sort()
    if aux == s:
        res = True
    
    return res

# usando while con 2 condiciones
def ordenado3(s: list) -> bool:
    i: int = 0
    res: bool = False

    while i < len(s)-1 and s[i] < s[i+1]:
        i = i + 1

    if i == len(s)-1: # tengo que determinar por cual de las 2 condiciones termino el ciclo
        res = True
    
    return res


# guia 8. Ej 1.6

def esPar(n: int) -> bool:
    return n %2 == 0

def palindromo2(palabra: str) -> bool:
    p:str = palabra.upper()
    res: bool = None

    if esPar(len(p)):
        res = palindroma_par(p)
    else:
        res = palindroma_impar(p)
    
    return res

def palindroma_par(palabra: str) -> bool:
    valor: bool = True
    fin: int = len(palabra) -1

    while fin >= len(palabra)/2:
        for letra in palabra:
            if letra == palabra[fin]:
                fin = fin - 1
            else:
                valor = False

    return valor

# falta armar palindroma_impar(). 
# pregunta: hace falta, o podemos modificar la anterior?

# implementacion 'tramposa' usando una funcion auxiliar que llama a `reverse()` de listas
def palindroma3(s: str) -> bool:
    res: bool = False

    if s == reverso(s):
        res = True
    
    return res

def reverso(s: str) -> str:
    s_aux: list = list(s)
    s_aux.reverse()
    return "".join(s_aux)


# implementacion usando un if dentro de un for
# compara todas las posiciones de a 2
def palindroma4(s: str) -> bool:
    res: bool = True
    for i in range(0, len(s), 1):
        if s[i] != s[len(s)-i-1]:
            res = False
    return res

# una variante de la anterior que hace la mitad de comparaciones
import math
def palindroma5(s: str) -> bool:
    res: bool = True
    mitad: int = math.ceil(len(s)/2)

    for i in range(0, mitad, 1):
        if s[i] != s[len(s)-i-1]:
            res = False
    return res

# una implementacion usando while y 2 indices
# (uno que se mueve para adelante desde la posicion 0 y otro desde la ultima posicion hacia adelante)
def palindromo6(p: str) -> bool:
    p:str = p.upper()
    i:int = len(p)-1
    j:int = 0
    res:bool = True

    while j <= i:
        if p[j] != p[i]:
            res = False
        j = j + 1
        i = i - 1
    
    return res

# implementacion que funciona pero que no pudieron explicar porque :P
def palindromo1(n: str) -> bool:
    return n[::-1] == n