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
nombresDeUsuarios (us, rels, pubs) = limpiarRepetidos(nombresDeUsuariosConRepetidos(us))

--La función limpiarRepetidos recibe una lista de cadenas de caracteres y devuelve la lista sin las cadenas de caracteres repetidas.
limpiarRepetidos :: [String] -> [String]
limpiarRepetidos [] = []
limpiarRepetidos (x:xs) | elem x xs = limpiarRepetidos xs 
                        | otherwise = [x] ++ limpiarRepetidos xs

nombresDeUsuariosConRepetidos :: [Usuario] -> [String]
nombresDeUsuariosConRepetidos [] = []
nombresDeUsuariosConRepetidos us = [nombreDeUsuario(head(us))] ++ nombresDeUsuariosConRepetidos(tail(us))

--amigosDe devuelve todos los usuarios que se relacionan con el usuario u pasado como parámetro.
amigosDe :: RedSocial -> Usuario -> [String]
amigosDe (us, rels, pubs) u = relacionesUsuario(rels)(u)

relacionesUsuario :: [Relacion] -> Usuario -> [String]
relacionesUsuario [] u = []
relacionesUsuario (x:xs) u | u == fst(x) = [nombreDeUsuario(snd(x))] ++ relacionesUsuario(xs)(u)
                           | u == snd(x) = [nombreDeUsuario(fst(x))] ++ relacionesUsuario(xs)(u)
                           | otherwise = relacionesUsuario(xs)(u)

-- describir qué hace la función: .....
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red u = contadorDeLista(amigosDe(red)(u))

contadorDeLista :: [String] -> Int
contadorDeLista [] = 0
contadorDeLista (x:xs) = 1 + contadorDeLista(xs)

-- describir qué hace la función: .....
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos (u:us, rels, pubs) = usuarioConMasAmigosAux (us, rels, pubs) us u

usuarioConMasAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Usuario
usuarioConMasAmigosAux red [] l = l
usuarioConMasAmigosAux red (u:us) l | cantidadDeAmigos red l >= cantidadDeAmigos red u = usuarioConMasAmigosAux red us l
                                    | otherwise = usuarioConMasAmigosAux red us u

-- describir qué hace la función: .....
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos = undefined

-- describir qué hace la función: .....
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe = undefined

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
