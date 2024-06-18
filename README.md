# Processeur mono-cycle ARM7TDMI simplifié

Ce projet consiste à concevoir et simuler le cœur d'un processeur ARM7TDMI simplifié monocycle en utilisant VHDL. Le processeur est assemblé en utilisant des composants de base tels que des registres, des multiplexeurs, des bancs de mémoire et une Unité Arithmétique et Logique (ALU). Ces composants sont intégrés pour former les différents blocs du système, notamment l'unité de traitement, l'unité de gestion des instructions et l'unité de contrôle.

## Fonctionnalités
- **Conception du processeur** : Construit à partir de composants fondamentaux comme les registres, les multiplexeurs, les bancs de mémoire, une ALU...
- **Système intégré** : Comprend l'unité de traitement, l'unité de gestion des instructions et l'unité de contrôle.
- **Simulation et test** : Fonctionnalité vérifiée par la simulation de l'exécution d'un programme test simple et testée sur un FPGA.
- **Description comportementale en VHDL** : Circuits décrits en VHDL et simulés à l'aide de Modelsim avec un banc de test personnalisé.

## Outils utilisés
- **VHDL** : Pour décrire le comportement des circuits.
- **Modelsim** : Pour la simulation et la vérification.
- **FPGA** : Pour tester le processeur dans un environnement matériel réel.
