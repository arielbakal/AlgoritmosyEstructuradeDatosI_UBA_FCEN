{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Use foldr" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

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

