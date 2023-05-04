module Solucion where

-- Completar con los datos del grupo
--
-- Nombre de Grupo: facts
-- Integrante 1: Teo Nabot, teonabot@gmail.com, 996/22
-- Integrante 2: Ariel Bakal, bakalariel2002@gmail.com, 1014/22
-- Integrante 3: Nombre Apellido, email, LU
-- Integrante 4: Nombre Apellido, email, LU

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas

usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us

-- Ejercicios

-- Devuelve una lista de Usuarios sin repetir de una Red Social
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios (us, rels, pubs) = limpiarRepetidos (nombresDeUsuariosConRepetidos us)

--La función limpiarRepetidos recibe una lista de cadenas de caracteres y devuelve la lista sin las cadenas de caracteres repetidas.
limpiarRepetidos :: [String] -> [String]
limpiarRepetidos [] = []
limpiarRepetidos (x:xs) | x `elem` xs = limpiarRepetidos xs
                        | otherwise = x : limpiarRepetidos xs

nombresDeUsuariosConRepetidos :: [Usuario] -> [String]
nombresDeUsuariosConRepetidos [] = []
nombresDeUsuariosConRepetidos us = nombreDeUsuario (head us) : nombresDeUsuariosConRepetidos (tail us)

--amigosDe devuelve todos los usuarios que se relacionan con el usuario u pasado como parámetro.
--amigosDeVieja :: RedSocial -> Usuario -> [String] :tiene que devolver una lista de Usuarios que son tuplas, no de strings. Ahora esta devolviendo solo los nombres, no la tupla id-nombre
--amigosDeVieja (us, rels, pubs) u = relacionadosAUsuario rels u

amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_, rels, _) u = relacionadosAUsuario rels u

--dada una lista de relaciones y un usuario u, devuelve los usuarios relacionados al usuario u mediante las relaciones
relacionadosAUsuario :: [Relacion] -> Usuario -> [Usuario]
relacionadosAUsuario [] u = []
relacionadosAUsuario (x:xs) u | u == fst x = snd x : relacionadosAUsuario xs u
                              | u == snd x = fst x : relacionadosAUsuario xs u
                              | otherwise = relacionadosAUsuario xs u


-- dada una red social y un usuario devuelve la cantidad de amigos del usuario, viendo la cantidad de elemntos que tiene la lista de amigos
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos rs u = cantidadDeElementos (amigosDe rs u)

--dada una lista de usuarios, devuelve la cantidad de usuarios que tiene esa lista
cantidadDeElementos :: [a] -> Int
cantidadDeElementos [] = 0
cantidadDeElementos (x:xs) = 1 + cantidadDeElementos (xs)

-- describir qué hace la función: .....
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos (u:us, rels, pubs) = usuarioConMasAmigosAux ((u:us), rels, pubs) us u

usuarioConMasAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Usuario
usuarioConMasAmigosAux red [] l = l
usuarioConMasAmigosAux red (u:us) l | cantidadDeAmigos red l >= cantidadDeAmigos red u = usuarioConMasAmigosAux red us l
                                    | otherwise = usuarioConMasAmigosAux red us u

-- Determina si hay un usuario con mas de 1000000 de amigos
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos ([], _, _) = False
estaRobertoCarlos (us, rels, pubs) | cantidadDeAmigos (us, rels, pubs) (head us) > 1000000 = True
                                   | otherwise = estaRobertoCarlos (tail us, rels, pubs) 

-- describir qué hace la función: .....
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe = 

-- describir qué hace la función: .....
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA = undefined

-- describir qué hace la función: .....
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones = undefined

-- describir qué hace la función: .....
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel = undefined

-- describir qué hace la función: .....
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos = undefined
