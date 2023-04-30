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
nombresDeUsuarios rs = limpiarRepetidos(nombresDeUsuariosConRepetidos(rs))

--La función limpiarRepetidos recibe una lista de cadenas de caracteres y devuelve la lista sin las cadenas de caracteres repetidas.
limpiarRepetidos :: [String] -> [String]
limpiarRepetidos [] = []
limpiarRepetidos (x:xs) | elem x xs = limpiarRepetidos xs 
                        | otherwise = [x] ++ limpiarRepetidos xs

nombresDeUsuariosConRepetidos :: RedSocial -> [String]
nombresDeUsuariosConRepetidos ([], _ , _) = []
nombresDeUsuariosConRepetidos (us, rels, pubs) = [nombreDeUsuario(head(us))] ++ nombresDeUsuarios( ( tail(us), rels, pubs ) )

--amigosDe devuelve todos los usuarios que se relacionan con el usuario u pasado como parámetro.
-- describir qué hace la función: .....
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe rs u = undefined

-- describir qué hace la función: .....
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos = undefined

-- describir qué hace la función: .....
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos = undefined

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
