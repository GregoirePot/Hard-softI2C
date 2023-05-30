# Hard-softI2C
Hardware/software I2C sender
> Membres du groupe 6 : Derison Marie, Versterren Loane, Pottiez Grégoire

Dans le cadre du cours de Hardware/Software donné par Prof. Valderrama à la Faculté Polytechnique de Mons, nous avons émulé un capteur de température TMP100 communiquant avec un Master via un bus I2C.  Nous avons créé le tuto suivant reprenant 2 parties distinctes du projet: la partie hardware et la partie software.

La partie Hardware se compose d'un driver, un test bench et d'un wrapper. Le driver est un composant qui sert d'interface entre le système d'exploitation et un appareil quelconque avec lequel on souhaiterait communiquer. Le  wrapper peut se définir comme un ensemble de composants logiciels, il appelle d'autres fonctions. Enfin, le test bench va simuler le "Master" (car nous sommes les envoyeurs des informations et donc les "slave") en nous envoyant une requête (une demande de valeur de température) sur le bus I2C grâce à un signal.

La partie software  lira la température sur le signal envoyé par le Master. Le software s'occcupera aussi d'envoyer les données du capteur de température.

Une vidéo youtube est également faite afin de mieux cerner les différentes parties des codes, bienôt sur la chaîne :https://www.youtube.com/channel/UChxADP9tMTuQWn3Ich5lWsw 



