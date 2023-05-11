module Solucion where

-- Completar con los datos del grupo
--
-- Nombre de Grupo: facts
-- Integrante 1: Teo Nabot, teonabot@gmail.com, 996/22
-- Integrante 2: Ariel Bakal, bakalariel2002@gmail.com, 1014/22
-- Integrante 3: Juan Cruz Berton, juanceberton@gmail.com 835/22
-- Integrante 4: Luca Dardenne, lucadardenne@gmail.com, 564/23

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

pertenece _ [] = False
pertenece a (x:xs) = a == x || pertenece a xs

-- La función limpiarRepetidos recibe una lista de cadenas de caracteres y devuelve la lista sin las cadenas de caracteres repetidas.
limpiarRepetidos :: [String] -> [String]
limpiarRepetidos [] = []
limpiarRepetidos (x : xs) 
  | pertenece x xs = limpiarRepetidos xs
  | otherwise = x : limpiarRepetidos xs

nombresDeUsuariosConRepetidos :: [Usuario] -> [String]
nombresDeUsuariosConRepetidos [] = []
nombresDeUsuariosConRepetidos us = nombreDeUsuario (head us) : nombresDeUsuariosConRepetidos (tail us)

amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_, rels, _) = relacionadosAUsuario rels

-- dada una lista de relaciones y un usuario u, devuelve los usuarios relacionados al usuario u mediante las relaciones
relacionadosAUsuario :: [Relacion] -> Usuario -> [Usuario]
relacionadosAUsuario [] u = []
relacionadosAUsuario (x : xs) u
  | u == fst x = snd x : relacionadosAUsuario xs u
  | u == snd x = fst x : relacionadosAUsuario xs u
  | otherwise = relacionadosAUsuario xs u

-- dada una red social y un usuario devuelve la cantidad de amigos del usuario, viendo la cantidad de elemntos que tiene la lista de amigos
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos rs u = cantidadDeElementos (amigosDe rs u)

-- dada una lista de usuarios, devuelve la cantidad de usuarios que tiene esa lista
cantidadDeElementos :: [a] -> Int
cantidadDeElementos [] = 0
cantidadDeElementos (x : xs) = 1 + cantidadDeElementos xs

-- describir qué hace la función: .....
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos (u : us, rels, pubs) = usuarioConMasAmigosAux (u : us, rels, pubs) us u

usuarioConMasAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Usuario
usuarioConMasAmigosAux red [] l = l
usuarioConMasAmigosAux red (u : us) l
  | cantidadDeAmigos red l >= cantidadDeAmigos red u = usuarioConMasAmigosAux red us l
  | otherwise = usuarioConMasAmigosAux red us u

-- Determina si hay un usuario con mas de 1000000 de amigos
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos ([], _, _) = False
estaRobertoCarlos (us, rels, pubs)
  | cantidadDeAmigos (us, rels, pubs) (head us) > 1000000 = True
  | otherwise = estaRobertoCarlos (tail us, rels, pubs)

-- Devuelve las publicaciones de un usuario
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (us, rels, []) u = []
publicacionesDe (us, rels, p : pubs) u
  | u == usuarioDePublicacion p = p : publicacionesDe (us, rels, pubs) u
  | otherwise = publicacionesDe (us, rels, pubs) u

-- describir qué hace la función: .....
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA (us, rels, []) u = []
publicacionesQueLeGustanA (us, rels, p : pubs) u
  | pertenece u likesDePublicacion p = p : publicacionesQueLeGustanA (us, rels, pubs) u
  | otherwise = publicacionesQueLeGustanA (us, rels, pubs) u

-- describir qué hace la función: .....
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones (us, rels, []) u1 u2 = True
lesGustanLasMismasPublicaciones (us, rels, p : pubs) u1 u2 =
  (pertenece u1 (likesDePublicacion p) == pertenece u2 (likesDePublicacion p))
    && lesGustanLasMismasPublicaciones (us, rels, pubs) u1 u2

-- un usuario debe haberle dado like a todas las publicaciones del usuario parametro
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel ([], rels, pubs) u = False
tieneUnSeguidorFiel (us, rels, pubs) u
  | head us == u = tieneUnSeguidorFiel (tail us, rels, pubs) u
  | otherwise =
      incluido (publicacionesDe (us, rels, pubs) u) (publicacionesQueLeGustanA (us, rels, pubs) (head us))
        || tieneUnSeguidorFiel (tail us, rels, pubs) u

-- si una lista esta incluida en otra lista
incluido :: Eq a => [a] -> [a] -> Bool
incluido [] l = True
incluido l1 l2
  | pertenece (head l1) l2 = incluido (tail l1) l2
  | otherwise = False

-- "recorre" la lista de relaciones partiendo del usuario inicial,
-- descartando en las que no se encuentra el usuario final
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos (users, rels, pubs) usuarioInicial usuarioFinal
  | [] == relacionesDeUsuarioInicial = False
  | siguienteUsuario == usuarioFinal = True
  | otherwise =
      existeSecuenciaDeAmigos (users, listaSinRelacion, pubs) usuarioInicial usuarioFinal
        || existeSecuenciaDeAmigos (users, listaSinRelacion, pubs) siguienteUsuario usuarioFinal
  where
    relacionesDeUsuarioInicial = relacionesDeUsuario rels usuarioInicial
    primeraRelacion = head relacionesDeUsuarioInicial
    siguienteUsuario = relacionSinUsuario primeraRelacion usuarioInicial
    listaSinRelacion = quitarDeLista primeraRelacion rels

{- aux -}
-- devuelve el otro usuario en la relacion
relacionSinUsuario :: Relacion -> Usuario -> Usuario
relacionSinUsuario rel u
  | fst rel == u = snd rel
  | otherwise = fst rel

-- devuelve las relaciones donde aparece el usuario
relacionesDeUsuario :: [Relacion] -> Usuario -> [Relacion]
relacionesDeUsuario [] _ = []
relacionesDeUsuario (r : rels) u
  | estaEnLaRelacion = r : relacionesDeUsuario rels u
  | otherwise = relacionesDeUsuario rels u
  where
    estaEnLaRelacion = u == fst r || u == snd r

-- devuelve la lista sin el elemento
quitarDeLista :: Eq a => a -> [a] -> [a]
quitarDeLista item [] = []
quitarDeLista item (x : xs)
  | item == x = quitarDeLista item xs
  | otherwise = x : quitarDeLista item xs

{- aux -}
