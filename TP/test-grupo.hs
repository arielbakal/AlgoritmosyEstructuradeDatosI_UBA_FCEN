import Solucion
import Test.HUnit

main = runTestTT casos -- para correr los tests ejecutar este archivo y escribir "main"

{- ESCRIBIR CASOS DE TEST ACÁ -}
ejercicio1casoA = nombresDeUsuarios redA ~?= ["Teo", "Ariel", "Juan Cruz", "Luca", "Roberto Carlos"]

ejercicio1casoB = nombresDeUsuarios redB ~?= ["Teo", "Ariel", "Juan Cruz", "Luca"]

ejercicio1casoC = nombresDeUsuarios ([], [], []) ~?= []

--
ejercicio2casoA = amigosDe redA usuario1 ~?= [usuario2, usuario4]

ejercicio2casoB = amigosDe redA usuario3 ~?= [usuario4, usuario5]

ejercicio2casoC = amigosDe redA usuario6 ~?= []

--
ejercicio3casoA = cantidadDeAmigos redA usuario6 ~?= 0

ejercicio3casoB = cantidadDeAmigos redA usuario3 ~?= 2

ejercicio3casoC = cantidadDeAmigos redA usuario4 ~?= 3

--
ejercicio4casoA = usuarioConMasAmigos ([usuario1], [], []) ~?= usuario1

ejercicio4casoB = usuarioConMasAmigos redA ~?= usuario4

ejercicio4casoC = usuarioConMasAmigos ([usuario1, usuario2], [(usuario1, usuario2)], []) ~?= usuario1

--
ejercicio5casoA = estaRobertoCarlos ([], [], []) ~?= False

ejercicio5casoB = estaRobertoCarlos redA ~?= False

ejercicio5casoC = estaRobertoCarlos redC ~?= True

ejercicio5casoD = estaRobertoCarlos redD ~?= False

--

ejercicio6casoA = publicacionesDe ([usuario1], [], []) usuario1 ~?= []

ejercicio6casoB = publicacionesDe ([usuario1, usuario2], [], [(usuario1, "Hi", [usuario1, usuario2])]) usuario1 ~?= [(usuario1, "Hi", [usuario1, usuario2])]

ejercicio6casoC = publicacionesDe ([usuario1, usuario2], [], [(usuario1, "Hi", [usuario1, usuario2])]) usuario2 ~?= []

-- ejercicio6casoD = publicacionesDe ([usuario1, usuario2], [], [(usuario1, "Hi", [usuario1,usuario2]), (usuario1, "Hi", [usuario1, usuario2])]) usuario1 ~?= [(usuario1, "Hi", [usuario1,usuario2])]

--
ejercicio7casoA = publicacionesQueLeGustanA redA usuario6 ~?= []

ejercicio7casoB = publicacionesQueLeGustanA redA usuario2 ~?= [publicacion1_1, publicacion3_2, publicacion4_1]

ejercicio7casoC = publicacionesQueLeGustanA red7 usuario2 ~?= []

--

ejercicio8casoA = lesGustanLasMismasPublicaciones ([usuario1, usuario2], [], []) usuario1 usuario2 ~?= True

ejercicio8casoB = lesGustanLasMismasPublicaciones ([usuario1, usuario2], [], [(usuario1, "Hi", [usuario1, usuario2])]) usuario1 usuario1 ~?= True

ejercicio8casoC = lesGustanLasMismasPublicaciones ([usuario1, usuario2], [], [(usuario1, "Hi", [usuario1, usuario2])]) usuario1 usuario2 ~?= True

ejercicio8casoD = lesGustanLasMismasPublicaciones redB usuario2 usuario5 ~?= False

--

 ejercicio9casoA = tieneUnSeguidorFiel ([usuario1, usuario2], [], []) usuario1 ~?= False 
-- red sin publicaciones

ejercicio9casoB = tieneUnSeguidorFiel ([usuario1], [], [(usuario1, "Hola", [])]) usuario1 ~?= False
-- red con un solo usuario

ejercicio9casoC = tieneUnSeguidorFiel ([usuario1, usuario2], [], [(usuario2, "Hola", [])]) usuario1 ~?= False 
-- red con publicaciones, pero usuario sin pulbicacion

ejercicio9casoD = tieneUnSeguidorFiel ([usuario1, usuario2], [], [(usuario1, "Hola", [])]) usuario1 ~?= False
-- 

ejercicio9casoE = tieneUnSeguidorFiel ([usuario1, usuario2], [], [(usuario1, "Hola", [usuario2])]) usuario1 ~?= True

ejercicio9casoF = tieneUnSeguidorFiel ([usuario1, usuario2], [], [(usuario1, "Hola", [usuario1])]) usuario1 ~?= False

ejercicio9casoG = tieneUnSeguidorFiel ([usuario1, usuario2], [], [(usuario2, "Hola", [usuario2])]) usuario1 ~?= True

--
ejercicio10casoA = existeSecuenciaDeAmigos redA usuario1 usuario5 ~?= True

ejercicio10casoB = existeSecuenciaDeAmigos redA usuario1 usuario2 ~?= True

ejercicio10casoC = existeSecuenciaDeAmigos redA usuario5 usuario6 ~?= False

ejercicio10casoD = existeSecuenciaDeAmigos redE usuario1 usuario2 ~?= False

ejercicio10casoE = existeSecuenciaDeAmigos redA usuario1 usuario1 ~?= True

ejercicio10casoF = existeSecuenciaDeAmigos redF usuario1 usuario1 ~?= True

{- Y AGREGARLOS ACÁ con un nombre descriptivo -}
casos =
  TestList
    [ -- CASOS EJERCICIO 1
      TestLabel "nombresDeUsuarios sin repetidos" ejercicio1casoA,
      TestLabel "nombresDeUsuarios con repetidos" ejercicio1casoB,
      TestLabel "nombresDeUsuarios con red vacia" ejercicio1casoC,
      -- CASOS EJERCICIO 2
      TestLabel "amigosDe" ejercicio2casoA,
      TestLabel "amigosDe con amigos de nombre repetido" ejercicio2casoB,
      TestLabel "amigosDe sin amigos" ejercicio2casoC,
      -- CASOS EJERCICIO 3
      TestLabel "cantidadDeAmigos usuario sin amigos" ejercicio3casoA,
      TestLabel "cantidadDeAmigos usuario con amigos, con nombres de amigos repetidos" ejercicio3casoB,
      TestLabel "cantidadDeAmigos usuario con amigos, sin nombres de amigos repetidos" ejercicio3casoC,
      -- CASOS EJERCICIO 4
      TestLabel "usuarioConMasAmigos usuario unico" ejercicio4casoA,
      TestLabel "usuarioConMasAmigos usuario con mas amigos" ejercicio4casoB,
      TestLabel "usuarioConMasAmigos usuarios con misma cantidad de amigos" ejercicio4casoC,
      -- CASOS EJERCICIO 5
      TestLabel "estaRobertoCarlos lista de usuarios vacia" ejercicio5casoA,
      TestLabel "estaRobertoCarlos usuario con cantidadDeAmigos <10" ejercicio5casoB,
      TestLabel "estaRobertoCarlos usuario con cantidadDeAmigos >10" ejercicio5casoC,
      TestLabel "estaRobertoCarlos usuario con cantidadDeAmigos =10" ejercicio5casoD,
      -- CASOS EJERCICIO 6
      TestLabel "publicacionesDe, red sin publicaciones" ejercicio6casoA1,
      TestLabel "publicacionesDe, publicaciones del usuario" ejercicio6casoB,
      TestLabel "publicacionesDe, usuario sin publicaciones" ejercicio6casoC,
      -- TestLabel "publicacionesDe, publicaciones repetidas" ejercicio6casoD,   la funcion debe eliminar publicaciones repetidas
      -- CASOS EJERCICIO 7
      TestLabel "publicacionesQueLeGustanA usuario sin publicaciones gustadas" ejercicio7casoA,
      TestLabel "publicacionesQueLeGustanA usuario con publicaciones gustadas" ejercicio7casoB,
      TestLabel "publicacionesQueLeGustanA red social sin publicaciones" ejercicio7casoC,
      -- CASOS EJERCICIO 8
      TestLabel "lesGustanLasMismasPublicaciones, red sin publicaciones" ejercicio8casoA,
      TestLabel "lesGustanLasMismasPublicaciones, compara el mismo usuario" ejercicio8casoB,
      TestLabel "lesGustanLasMismasPublicaciones, likean las mismas publicaciones" ejercicio8casoC,
      TestLabel "lesGustanLasMismasPublicaciones, likean una misma publicacion pero las demas no" ejercicio8casoD,
      -- CASOS EJERCICIO 9
      -- TestLabel "tieneUnSeguidorFiel usuario sin publicaciones" ejercicio9casoA,
      TestLabel "tieneUnSeguidorFiel usuario con publicaciones sin seguidor fiel " ejercicio9casoB,
      TestLabel "tieneUnSeguidorFiel usuario con publicaciones con seguidor fiel " ejercicio9casoC,
      -- CASOS EJERCICIO 10
      TestLabel "existeSecuenciaDeAmigos con red sin relaciones" ejercicio10casoD, -- False
      TestLabel "existeSecuenciaDeAmigos con secuencia inválida" ejercicio10casoC, -- False
      TestLabel "existeSecuenciaDeAmigos con secuencia válida" ejercicio10casoA, -- True
      TestLabel "existeSecuenciaDeAmigos con usuarios amigos" ejercicio10casoB, -- True
      TestLabel "existeSecuenciaDeAmigos con usuario inicial = usuario final" ejercicio10casoE, -- True
      TestLabel "existeSecuenciaDeAmigos con usuario inicial = usuario final y solo una relacion" ejercicio10casoF -- True
    ]

{- DATOS -}
-- Tratar de editar lo menos posible, agregar los usuarios, relaciones, publicaciones y redes que sean necesario/as.
usuario1 = (1, "Teo")

usuario2 = (2, "Ariel")

usuario3 = (3, "Juan Cruz")

usuario4 = (4, "Luca")

usuario5 = (5, "Luca")

usuario6 = (6, "Roberto Carlos")

usuario7 = (7, "Martin")

usuario8 = (8, "Diego")

usuario9 = (9, "Maria")

usuario10 = (10, "Carolina")

usuario11 = (11, "Carla")

usuario12 = (12, "Marta")

relacion1_2 = (usuario1, usuario2)

relacion1_3 = (usuario1, usuario3)

relacion1_4 = (usuario4, usuario1)

relacion2_3 = (usuario3, usuario2)

relacion2_4 = (usuario2, usuario4)

relacion3_4 = (usuario4, usuario3)

relacion3_5 = (usuario3, usuario5)

relacion1_5 = (usuario1, usuario5)

relacion1_6 = (usuario1, usuario6)

relacion1_7 = (usuario1, usuario7)

relacion1_8 = (usuario1, usuario8)

relacion1_9 = (usuario1, usuario9)

relacion1_10 = (usuario1, usuario10)

relacion1_11 = (usuario1, usuario11)

relacion1_12 = (usuario1, usuario12)

publicacion1_1 = (usuario1, "Este es mi primer post", [usuario2, usuario4])

publicacion1_2 = (usuario1, "Este es mi segundo post", [usuario4])

publicacion1_3 = (usuario1, "Este es mi tercer post", [usuario2, usuario5])

publicacion1_4 = (usuario1, "Este es mi cuarto post", [])

publicacion1_5 = (usuario1, "Este es como mi quinto post", [usuario5])

publicacion2_1 = (usuario2, "Hello World", [usuario4])

publicacion2_2 = (usuario2, "Good Bye World", [usuario1, usuario4])

publicacion3_1 = (usuario3, "Lorem Ipsum", [])

publicacion3_2 = (usuario3, "dolor sit amet", [usuario2])

publicacion3_3 = (usuario3, "consectetur adipiscing elit", [usuario2, usuario5])

publicacion4_1 = (usuario4, "I am Alice. Not", [usuario1, usuario2])

publicacion4_2 = (usuario4, "I am Bob", [])

publicacion4_3 = (usuario4, "Just kidding, i am Mariela", [usuario1, usuario3])

publicacion5_1 = (usuario5, "Alea iacta est", [usuario1, usuario3])

publicacion5_2 = (usuario5, "Ab imo pectore", [usuario2, usuario3])

publicacion5_3 = (usuario5, "Carpe diem", [usuario4, usuario3])

publicacion5_4 = (usuario5, "Mens sana in corpore sano", [usuario3])

publicacion5_5 = (usuario5, "Errare humanum est", [usuario3])

-- red A
usuariosA = [usuario1, usuario2, usuario3, usuario4, usuario6]

relacionesA = [relacion1_2, relacion1_4, relacion2_4, relacion3_4, relacion3_5]

publicacionesA = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]

redA = (usuariosA, relacionesA, publicacionesA)

-- red B
usuariosB = [usuario1, usuario2, usuario3, usuario4, usuario5]

relacionesB = [relacion1_2, relacion2_3]

publicacionesB = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]

redB = (usuariosB, relacionesB, publicacionesB)

red7 = (usuariosA, relacionesA, [])

-- red c
usuariosC = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11, usuario12]

relacionesC = [relacion1_2, relacion1_3, relacion1_4, relacion1_5, relacion1_6, relacion1_7, relacion1_8, relacion1_9, relacion1_10, relacion1_11, relacion1_12]

publicacionesC = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion5_1, publicacion5_2, publicacion5_3, publicacion5_4, publicacion5_5]

redC = (usuariosC, relacionesC, publicacionesC)

-- red d
usuariosD = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11, usuario12]

relacionesD = [relacion1_2, relacion1_3, relacion1_4, relacion1_5, relacion1_6, relacion1_7, relacion1_8, relacion1_9, relacion1_10, relacion1_11]

publicacionesD = [publicacion1_3, publicacion1_4, publicacion1_5]

redD = (usuariosD, relacionesD, publicacionesD)

redE = (usuariosA, [], publicacionesA)

relacionesF = [relacion1_2]

redF = (usuariosA, relacionesF, publicacionesA)
