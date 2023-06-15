{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Use foldr" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Distribution.InstalledPackageInfo (InstalledPackageInfo(includeDirs))
import Distribution.Types.IncludeRenaming (IncludeRenaming(IncludeRenaming))
import Text.XHtml (rev, multiple)
import Distribution.Simple.Test.Log (summarizePackage)
import Control.Monad.Cont (cont)

-- Ejercicio 1

-- 1.1
longitud :: [t] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud(xs)

-- 1.2
ultimo :: [t] -> t
ultimo [t] = t
ultimo (x:xs) = ultimo (xs)

-- 1.3
principio :: [t] -> [t]
principio x = x

-- 1.4
reverso :: [t] -> [t]
reverso [] = []
reverso (x:xs) = reverso xs ++ [x]

-- Ejercicio 2

-- 2.1

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece x xs = elem x xs

pertenece2 :: (Eq t) => t -> [t] -> Bool
pertenece2 e [] = False
pertenece2 e (x:xs) | e == x = True 
                    | otherwise = False || pertenece2 e xs 

-- 2.2

todosIguales :: (Eq t) => [t] -> Bool
todosIguales [] = True
todosIguales [x] = True
todosIguales (x:xs) | x == head xs = todosIguales xs
                    | otherwise = False

-- 2.3

todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] = True
todosDistintos [x] = True
todosDistintos (x:xs) = not ( elem x xs ) && todosDistintos xs

-- 2.4

hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos [] = False
hayRepetidos [x] = False
hayRepetidos (x:xs) = elem x xs || hayRepetidos xs

-- 2.5

quitar :: (Eq t) => t -> [t] -> [t]
quitar e [] = []
quitar e (x:xs) | e == x = xs
                | otherwise = [x] ++ quitar e xs

-- 2.6
quitarTodos :: (Eq t) => t -> [t] -> [t]
quitarTodos e [] = []
quitarTodos e (x:xs) | e == x = quitarTodos e xs
                     | otherwise = [x] ++ quitarTodos e xs  

-- 2.7
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos [x] = [x]
eliminarRepetidos (x:xs) | elem x xs = eliminarRepetidos xs
                         | otherwise = [x] ++ eliminarRepetidos xs  

-- 2.8
incluido [] [] = True
incluido _ [] = False
incluido [] y = True
incluido (x:xs) y = elem x y && incluido xs y

mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos x y = incluido x y && incluido y x

-- 2.9
capicua :: (Eq t) => [t] -> Bool
capicua xs = reverso xs == xs 

-- Ejercicio 3

-- 3.1
sumatoria :: [Integer] -> Integer
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

--3.2
productoria :: [Integer] -> Integer
productoria [] = 0
productoria [x] = x
productoria (x:xs) = x * productoria xs

--3.3
maximo :: [Integer] -> Integer
maximo [x] = x
maximo (x:xs) | x > head xs = maximo (x : tail xs)
              | otherwise = maximo xs

--3.4
sumarN :: Integer -> [Integer] -> [Integer]
sumarN _ [] = []
sumarN n (x:xs) = [x + n] ++ sumarN n xs

--3.5
sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero (x:xs) = sumarN x (x:xs)

--3.6
sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo (x:xs) = reverso ( sumarElPrimero ( reverso(x:xs) ) )

--3.7
pares :: [Integer] -> [Integer]
pares [] = []
pares (x:xs) | mod x 2 == 0 = [x] ++ pares xs
             | otherwise = pares xs

--3.8
multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN _ [] = []
multiplosDeN 0 xs = xs
multiplosDeN n (x:xs) | mod x n == 0 = [x] ++ multiplosDeN n xs
                      | otherwise = multiplosDeN n xs

--3.9
ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar xs = ordenar ( quitar (maximo xs) xs ) ++ [maximo xs]


-- Ejercicio 4

--4.1
sacarBlancosRepetidos :: [Char] -> [Char]
sacarBlancosRepetidos [] = []
sacarBlancosRepetidos [x] = [x]
sacarBlancosRepetidos (x:y:xs) | x == ' ' && y == ' ' = [' '] ++ sacarBlancosRepetidos xs 
                               | otherwise = [x] ++ [y] ++ sacarBlancosRepetidos xs 

sacarBlancosRepetidos2 :: [Char] -> [Char]
sacarBlancosRepetidos2 [] = []
sacarBlancosRepetidos2 [x] = [x]
sacarBlancosRepetidos2 (x:y:xs) | x == ' ' && y == ' ' = (' ' : sacarBlancosRepetidos2 xs )
                                | otherwise = (x:y: sacarBlancosRepetidos2 xs )

--4.2
contarPalabras :: [Char] -> Integer
contarPalabras [] = 0
contarPalabras [x] | x == ' ' = 0  
                   | otherwise = 1
contarPalabras (x:xs) | x == ' ' = 1 + contarPalabras xs
                      | otherwise = contarPalabras xs

-- Ejercicio 5

--5.1
nat2bin :: Integer -> [Integer]
nat2bin 0 = []
nat2bin n = nat2bin (n `div` 2) ++ [n `mod` 2]

--5.2
bin2nat :: [Integer] -> Integer
bin2nat [] = 0
bin2nat (x:xs) = x * 2^(longitud xs) + bin2nat xs

-- Ejercicio 6

type Set a = [a]

vacio :: Set Int
vacio = []

--6.1
agregarATodos :: Integer -> Set (Set Integer) -> Set (Set Integer)
agregarATodos n [] = []
agregarATodos n (c:cls) = eliminarRepetidos (n:c) : agregarATodos n cls

--6.2
partes :: Integer -> Set (Set Integer)
partes 0 = [[]]
partes n = partes (n-1) ++ agregarATodos n (partes(n-1))

--6.3
productoCartesiano :: Set Int -> Set Int -> Set (Int, Int)
productoCartesiano [] ys = []
productoCartesiano (x:xs) ys = productoAUx x ys ++ productoCartesiano xs ys

productoAUx n [] = []
productoAUx n (x:xs) = [(n,x)] ++ productoAUx n xs