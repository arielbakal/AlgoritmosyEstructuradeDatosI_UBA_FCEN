module Solucion where

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

{- EJERCICIO 1 -}
-- Recupera una lista de los nombres de usuario de la red y borra los repetidos (elementos que ya se encuentren en dicha lista).
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios (us, rels, pubs) = limpiarRepetidos (nombresDeUsuariosConRepetidos us)

nombresDeUsuariosConRepetidos :: [Usuario] -> [String]
nombresDeUsuariosConRepetidos [] = []
nombresDeUsuariosConRepetidos us =
  nombreDeUsuario (head us) : nombresDeUsuariosConRepetidos (tail us)

limpiarRepetidos :: Eq a => [a] -> [a]
limpiarRepetidos [] = []
limpiarRepetidos (x : xs)
  | pertenece x xs = limpiarRepetidos xs
  | otherwise = x : limpiarRepetidos xs

pertenece :: Eq t => t -> [t] -> Bool
pertenece _ [] = False
pertenece a (x : xs) = a == x || pertenece a xs

{-  -}

{- EJERCICIO 2 -}
-- Recupera una lista de los usuarios que se encuentren en la misma relación que el usuario parámetro.
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_, rels, _) = relacionadosAUsuario rels

relacionadosAUsuario :: [Relacion] -> Usuario -> [Usuario]
relacionadosAUsuario [] u = []
relacionadosAUsuario (x : xs) u
  | u == fst x = snd x : relacionadosAUsuario xs u
  | u == snd x = fst x : relacionadosAUsuario xs u
  | otherwise = relacionadosAUsuario xs u

{-  -}

{- EJERCICIO 3 -}
-- Utilizando la función del ejercicio 2, cuenta los elementos de dicha lista.
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos rs u = cantidadDeElementos (amigosDe rs u)

cantidadDeElementos :: [a] -> Int
cantidadDeElementos [] = 0
cantidadDeElementos (x : xs) = 1 + cantidadDeElementos xs

{- -}

{- EJERCICIO 4 -}
-- Mantiene el usuario con más amigos como parámetro en la función auxiliar, para recorrer la lista de usuarios y comparar la cantidad de amigos de cada uno.
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos (u : us, rels, pubs) = usuarioConMasAmigosAux (u : us, rels, pubs) us u

usuarioConMasAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Usuario
usuarioConMasAmigosAux red [] actual = actual
usuarioConMasAmigosAux red (siguiente : us) actual
  | cantidadDeAmigos red siguiente > cantidadDeAmigos red actual = usuarioConMasAmigosAux red us siguiente
  | otherwise = usuarioConMasAmigosAux red us actual

{-  -}

{- EJERCICIO 5 -}
-- Determina si hay un usuario con mas de 1,000,000 de amigos.
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos ([], _, _) = False
estaRobertoCarlos (us, rels, pubs)
  | cantidadDeAmigos (us, rels, pubs) (head us) > 10 = True
  | otherwise = estaRobertoCarlos (tail us, rels, pubs)

{-  -}

{- EJERCICIO 6 -}
-- Recupera una lista con las publicaciones del usuario parámetro.
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (us, rels, []) u = []
publicacionesDe (us, rels, p : pubs) u
  -- \| p == head pubs = publicacionesDe (us, rels, pubs) u
  | u == usuarioDePublicacion p = p : publicacionesDe (us, rels, pubs) u
  | otherwise = publicacionesDe (us, rels, pubs) u

{-  -}

{- EJERCICIO 7 -}
-- Devuelve todas las publicaciones en las cuales el usuario dado se encuentre en la lista de likes de dicha publicación.
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA (us, rels, []) u = []
publicacionesQueLeGustanA (us, rels, p : pubs) u
  | pertenece u (likesDePublicacion p) = p : publicacionesQueLeGustanA (us, rels, pubs) u
  | otherwise = publicacionesQueLeGustanA (us, rels, pubs) u

{-  -}

{- EJERCICIO 8 -}
-- Si los usuarios parámetro se encuentran en las mismas listas de likes, devolvera True.
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones (us, rels, []) u1 u2 = True
lesGustanLasMismasPublicaciones (us, rels, p : pubs) u1 u2 =
  (pertenece u1 (likesDePublicacion p) == pertenece u2 (likesDePublicacion p))
    && lesGustanLasMismasPublicaciones (us, rels, pubs) u1 u2

{-  -}

{- EJERCICIO 9 -}
-- Si existe un usuario que se encuentre en todas las listas de likes de las publicaciones del usuario parámetro, devolvera True.
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel ([], rels, pubs) u = False
tieneUnSeguidorFiel (us, rels, pubs) u
  | head us == u = tieneUnSeguidorFiel (tail us, rels, pubs) u
  | otherwise =
      incluido (publicacionesDe (us, rels, pubs) u) (publicacionesQueLeGustanA (us, rels, pubs) (head us))
        || tieneUnSeguidorFiel (tail us, rels, pubs) u

incluido :: Eq a => [a] -> [a] -> Bool
incluido [] l = True
incluido l1 l2
  | pertenece (head l1) l2 = incluido (tail l1) l2
  | otherwise = False

{-  -}

{- EJERCICIO 10 -}
-- Si existe una secuencia de amigos en común entre los usuarios parámetro o ellos son amigos, devolvera True.
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos (users, rels, pubs) usuarioInicial usuarioFinal
  | [] == relacionesDeUsuarioInicial = False
  | siguienteUsuario == usuarioFinal || usuarioInicial == usuarioFinal = True
  | otherwise =
      existeSecuenciaDeAmigos (users, listaSinRelacion, pubs) usuarioInicial usuarioFinal
        || existeSecuenciaDeAmigos (users, listaSinRelacion, pubs) siguienteUsuario usuarioFinal
  where
    relacionesDeUsuarioInicial = relacionesDeUsuario rels usuarioInicial
    primeraRelacion = head relacionesDeUsuarioInicial
    siguienteUsuario = relacionSinUsuario primeraRelacion usuarioInicial
    listaSinRelacion = quitarDeLista primeraRelacion rels

relacionSinUsuario :: Relacion -> Usuario -> Usuario
relacionSinUsuario rel u
  | fst rel == u = snd rel
  | otherwise = fst rel

relacionesDeUsuario :: [Relacion] -> Usuario -> [Relacion]
relacionesDeUsuario [] _ = []
relacionesDeUsuario (r : rels) u
  | estaEnLaRelacion = r : relacionesDeUsuario rels u
  | otherwise = relacionesDeUsuario rels u
  where
    estaEnLaRelacion = u == fst r || u == snd r

quitarDeLista :: Eq a => a -> [a] -> [a]
quitarDeLista item [] = []
quitarDeLista item (x : xs)
  | item == x = quitarDeLista item xs
  | otherwise = x : quitarDeLista item xs

{-  -}
