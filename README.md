Titre

Implémentation d’un processeur ARM monocycle en VHDL

Description

Ce projet implémente une version simplifiée d’un processeur ARM32 monocycle en VHDL, respectant l’architecture et le format d’instructions ARM.
L’objectif est de modéliser le chemin de données complet, les unités de contrôle et les blocs fonctionnels nécessaires pour exécuter un sous-ensemble cohérent d’instructions ARM.

Le processeur exécute chaque instruction en un seul cycle d’horloge, sans pipeline, ce qui simplifie l’analyse temporelle et met l’accent sur la compréhension du datapath.

Fonctionnalités implémentées
1. Jeu d’instructions

Le processeur prend en charge un sous-ensemble des instructions ARM, notamment :

Instructions arithmétiques/logiques : ADD, SUB, AND, ORR, CMP, MVN, MOV

Instructions de décalage : LSL, LSR, ASR

Instructions mémoire : LDR, STR

Branching simple : B

Instructions avec flags (N, Z, C, V)

2. Composants principaux

ALU ARM (avec gestion des drapeaux NZCV)

Shifter (barrel shifter : LSL, LSR, ASR)

Registre d’état CPSR

Mémoire d’instructions (ROM)

Mémoire de données (RAM)

Banc de registres 16x32 bits

Unité de contrôle

Extensions immédiates

Chemin de données complet (datapath)

3. Architecture

Modèle monocycle complet

Aucun pipeline

Chaque instruction est entièrement exécutée en un seul cycle

Signaux internes exposés pour analyse (ALUControl, RegWrite, MemRead, MemWrite, Flags, ShifterControl, PCSrc, etc.)
/src
    alu.vhd
    shifter.vhd
    control_unit.vhd
    register_file.vhd
    instruction_memory.vhd
    data_memory.vhd
    datapath.vhd
    top.vhd

/testbench
    tb_alu.vhd
    tb_shifter.vhd
    tb_datapath.vhd
    tb_top.vhd

/docs
    architecture_diagram.png
    instruction_set_description.pdf
    notes.md

/constraints
    clock.xdc
Simulation

Les testbench permettent de :

Vérifier les opérations ALU (flags, overflow, carry, etc.)

Tester le shifter indépendamment

Valider le datapath complet sur plusieurs instructions ARM

Tracer les signaux critiques (RegWrite, ALUResult, MemoryData, Flags, PC, etc.)

Les simulations sont réalisées sous ModelSim / QuestaSim / GHDL.

Objectif pédagogique

Ce projet vise à :

Comprendre la structure interne d’un processeur ARM

Implémenter un datapath complet en VHDL

Gérer les signaux de contrôle et les flags

Construire et tester un design numérique complexe

Auteurs

Ulruch Marcial — Université du Québec à Trois-Rivières (UQTR)
