# Hard-softI2C
Hardware/software I2C sender
> Membres du groupe 6 : Derison Marie, Versterren Loane, Pottiez Grégoire

Dans le cadre du cours de Hardware/Software donné par Prof. Valderrama à la Faculté Polytechnique de Mons, nous avons émulé un capteur de température TMP100 communiquant avec un Master via un bus I2C.  Nous avons créé le tuto suivant reprenant 2 parties distinctes du projet: la partie hardware et la partie software.

La partie Hardware se compose d'un driver, un test bench et d'un wrapper. Le driver est un composant qui sert d'interface entre le système d'exploitation et un appareil quelconque avec lequel on souhaiterait communiquer. Le  wrapper peut se définir comme un ensemble de composants logiciels, il appelle d'autres fonctions. Enfin, le test bench va simuler le "Master" (car nous sommes les envoyeurs des informations et donc les "slave") en nous envoyant une requête (une demande de valeur de température) sur le bus I2C grâce à un signal.

Le hardware 

Une vidéo youtube est également faite afin de mieux cerner les différentes parties des codes, le lien est celui-ci :https://www.youtube.com/watch?v=sxDE2S2OVQ8 

dans le software, il y a le HPS qui sert à faire fonctionner le MMAP, l'exécutable projetloane2023 qui est la target du makefile, 

