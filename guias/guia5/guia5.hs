{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Use foldr" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Distribution.InstalledPackageInfo (InstalledPackageInfo(includeDirs))
import Distribution.Types.IncludeRenaming (IncludeRenaming(IncludeRenaming))
import Text.XHtml (rev)

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

