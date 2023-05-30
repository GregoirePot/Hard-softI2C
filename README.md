# Hard-softI2C
Hardware/software I2C sender
> Membres du groupe 3 : Derison Marie, Versterren Loane, Pottiez Grégoire

Dans le cadre du cours de Hardware/Software donné par Prof. Valderrama à la Faculté Polytechnique de Mons, nous avons émulé un capteur de température TMP100 communiquant avec un Master via un bus I2C.  Nous avons créé le tuto suivant repreant 2 parties distinctes du projet: la partie hardware et la partie software.

La partie Hardware se compose d'un driver, un test bench et d'un wrapper. Le driver est un composant qui sert d'interface entre le système d'exploitation et un appareil quelconque avec lequel on souhaiterait communiquer. le  wrapper peut se définir comme un ensemble de composants logiciels


Le but de ce projet est de lire les informations reçues par un Servo Moteur, à l'aide du kit de développement DE0-Nano-SoC. Ce dernier présente une plateforme de conception matérielle robuste architecturée sur le FPGA SoC Altera. Les informations à lire seront de deux types : un compteur et un lecteur de fréquence.



La partie Hardware est responsable des I/O choisies et implémentées via 'Platform Designer' dans 'Quartus'. Le membre responsable du Hardware doit également compléter le 'ghrd' du programme afin d'y ajouter le bloc relatif à notre projet (contenant les I/O, clk, rst... utilisés). Il doit également créer un programme (ServoIn dans le cas présent) dont le but est d'établir un compteur et un lecteur de fréquence. Le compteur recense le nombre de battements d'horloge entre deux états S1. La fréquence est déterminée à l'aide de ce compteur. Finalement, le membre Hardware crée un TestBench dont l'objectif est de simuler le comportement du programme ServoIn avant de le lier à la partie Software et au processeur.

La partie Software doit quant-à-elle modifier le Main.c directement envoyé sur le processeur, permettant d'afficher les informations reçues et décodées à l'aide du programme ServoIn venant du Hardware. Le membre Software est également responsable de connecter le processeur à l'ordinateur, d'y envoyer les programmes nécessaires et de le faire fonctionner. Finalement, il doit être capable de lire à l'oscilloscope les signaux reçus et lu via le processeur.

Afin de tester le programme final, le comportement d'un Servo Moteur sera simulé par une carte PIC envoyant les informations nécessaires à la détermination du 'count' et de la fréquence.

Une vidéo explicative complète se trouve à l'aresse suivante : https://youtu.be/0BS4j2wZApQ.
L'ensemble des membres de l'équipe vous souhaite un bon visionnage et espère que le VHDL n'aura plus de secret pour vous après ce tuto !
