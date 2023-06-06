# Hard-softI2C
Hardware/software I2C sender
> Membres du groupe 6 : Derison Marie, Versterren Loane, Pottiez Grégoire

Dans le cadre du cours de Hardware/Software donné par Prof. Valderrama à la Faculté Polytechnique de Mons, nous avons émulé un capteur de température TMP100 communiquant avec un Master via un bus I2C.  Nous avons créé le tuto suivant reprenant 2 parties distinctes du projet: la partie hardware et la partie software. Notre carte sera une Raspberry Pi.

La partie Hardware se compose des codes appartenant au driver, au test bench et au wrapper. On y trouve également "FPGA.qar" et ".qpf" qui sont le projet,ainsi que le fichier "generate" pour générer le fichier ".h". Finalement, les fichiers ".qsys" sont utilisées pour l'application 'platform designer'.

Dans la partie Software, il y a le HPS qui sert à faire fonctionner le MMAP, l'exécutable projetloane2023 qui est la target du makefile.

Une vidéo youtube est également faite afin de mieux cerner les différentes parties des codes, le lien est celui-ci :https://www.youtube.com/watch?v=sxDE2S2OVQ8 



