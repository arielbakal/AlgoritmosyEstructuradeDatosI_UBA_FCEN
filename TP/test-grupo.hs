import Solucion
import Test.HUnit

run = runTestTT casos -- para correr los tests ejecutar este archivo y escribir "run"

{- ESCRIBIR CASOS DE TEST ACÁ -}
ejercicio1casoA = nombresDeUsuarios redA ~?= ["Teo", "Ariel", "Juan Cruz", "Luca", "Roberto Carlos"]
ejercicio1casoB = nombresDeUsuarios redB ~?= ["Teo", "Ariel", "Luca"]
--
ejercicio2casoA = amigosDe redA usuario1 ~?= [usuario2, usuario4]
ejercicio2casoB = amigosDe redA usuario3 ~?= [usuario4, usuario5]
ejercicio2casoC = amigosDe redA usuario6 ~?= []

ejercicio3casoA = cantidadDeAmigos redA usuario6 ~?= 0
ejercicio3casoB = cantidadDeAmigos redA usuario3 ~?= 2
ejercicio3casoC = cantidadDeAmigos redA usuario4 ~?= 3

{- Y AGREGARLOS ACÁ con un nombre descriptivo -}
casos = TestList [
  --CASOS EJERCICIO 1
  TestLabel "nombresDeUsuarios sin repetidos" ejercicio1casoA,
  TestLabel "nombresDeUsuarios con repetidos" ejercicio1casoB,
  --CASOS EJERCICIO 2
  TestLabel "amigosDe" ejercicio2casoA,
  TestLabel "amigosDe con amigos de nombre repetido" ejercicio2casoB,
  TestLabel "amigosDe sin amigos" ejercicio2casoC,
  --CASOS EJERCICIO 3
  TestLabel "cantidadDeAmigos usuario sin amigos" ejercicio3casoA,
  TestLabel "cantidadDeAmigos usuario con al menos 1 amigo, con amigos con nombres repetidos" ejercicio3casoB,
  TestLabel "cantidadDeAmigos usuario con al menos 1 amigo, con amigos sin nombres repetidos" ejercicio3casoC
  ]

{- DATOS -}
--Tratar de editar lo menos posible, agregar los usuarios, relaciones, publicaciones y redes que sean necesario/as.
usuario1 = (1, "Teo")
usuario2 = (2, "Ariel")
usuario3 = (3, "Juan Cruz")
usuario4 = (4, "Luca")
usuario5 = (5, "Luca")
usuario6 = (6, "Roberto Carlos")

relacion1_2 = (usuario1, usuario2)
relacion1_3 = (usuario1, usuario3)
relacion1_4 = (usuario4, usuario1)
relacion2_3 = (usuario3, usuario2)
relacion2_4 = (usuario2, usuario4)
relacion3_4 = (usuario4, usuario3)
relacion3_5 = (usuario3, usuario5)

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

--red A
usuariosA = [usuario1, usuario2, usuario3, usuario4, usuario6]
relacionesA = [relacion1_2, relacion1_4, relacion2_4, relacion3_4, relacion3_5]
publicacionesA = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]
redA = (usuariosA, relacionesA, publicacionesA)

--red B
usuariosB = [usuario1, usuario2, usuario4, usuario5]
relacionesB = [relacion1_2, relacion2_3]
publicacionesB = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redB = (usuariosB, relacionesB, publicacionesB)
