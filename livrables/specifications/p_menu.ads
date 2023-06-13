with P_Arbre_Genealog; use P_Arbre_Genealog;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
package P_Menu is

   -- PROCEDURE : manipulation_arbre_gen
   -- Semantique : Traitement principal qui permet à l'utilisateur de manipuler l'arbre tant qu'il ne quitte pas le programme
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre à manipuler
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure manipulation_arbre_gen(F_arbre : in out arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
  
private
   -- PROCEDURE : afficherMenu
   -- Semantique : Affiche le menu des choix à l'utilisateur
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure afficherMenu;

   -------------------------
   
   -- PROCEDURE : commande_1_creer_arbre
   -- Semantique : Crée un arbre avec une donnée initiale
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre a initialiser
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_1_creer_arbre(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_2_ajouter_pere
   -- Semantique : Ajoute un père à l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre auquel on ajoute un père
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_2_ajouter_pere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_3_ajouter_mere
   -- Semantique : Ajoute une mère à l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre auquel on ajoute une mère
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_3_ajouter_mere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_4_nombre_ancetres
   -- Semantique : Affiche le nombre d'ancêtres que possède l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on cherche son nombre d'ancêtres
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_4_nombre_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_5_identifier_ancetres
   -- Semantique : Affiche les ancêtres de génération demandé pour l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on recherche des ancêtres de génération donnée
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_5_identifier_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_6_ensemble_ancetres
   -- Semantique : Affiche tous les ancêtres existants jusqu'à la génération donnée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on recherche les ancêtres jusqu'à la génération donnée
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_6_ensemble_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_7_identifier_descendant
   -- Semantique : Affiche les descendants de génération demandé pour l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on recherche des descendants de génération donnée
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_7_identifier_descendant(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_8_ensemble_descendants
   -- Semantique : Affiche tous les descendants existants jusqu'à la génération donnée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on recherche les descendants jusqu'à la génération donnée
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_8_ensemble_descendants(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_9_afficher
   -- Semantique : Affiche l'arbre généalogique
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre a afficher
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_9_afficher(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_10_supprimer_branche
   -- Semantique : Supprime une branche de l'arbre
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre auquel on supprime une branche
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_10_supprimer_branche(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_11_modifier_individu
   -- Semantique : Modifie une information d'un individu
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre auquel on supprime une branche
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_11_modifier_individu(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
     
   -------------------------
   
   -- PROCEDURE : commande_12_modifier_totalement_individu
   -- Semantique : Modifier toutes les informations d'un individu
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre auquel on supprime une branche
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_12_modifier_totalement_individu(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : commande_13_aucun_parent_connu
   -- Semantique : Affiche le nombre d'individus qui n'ont aucun parent connu
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on fait la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_13_aucun_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_14_un_parent_connu
   -- Semantique : Affiche le nombre d'individus qui n'ont qu'un seul parent connu
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on fait la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_14_un_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_15_deux_parents_connus
   -- Semantique : Affiche le nombre d'individus qui ont les deux parents connus
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre duquel on fait la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_15_deux_parents_connus(F_Arbre : in arbre_genealogique.T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : commande_16_identifier_ancetre_paternel
   -- Semantique : Affiche l'ancêtre maternel de génération demandé pour l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre à manipuler
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_16_identifier_ancetre_paternel(F_Arbre : in arbre_genealogique.T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : commande_17_identifier_ancetre_maternel
   -- Semantique : Affiche l'ancêtre maternel de génération demandé pour l'arbre passé en entrée
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre à manipuler
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_17_identifier_ancetre_maternel(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   
   -------------------------
   
   -- PROCEDURE : commande_18_afficher_entierement
   -- Semantique : Affiche l'arbre généalogique entièrement depuis la racine
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, l'arbre a afficher
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_18_afficher_entierement(F_Arbre : in arbre_genealogique.T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : commande_19_creer_arbre_prerempli
   -- Semantique : Fabrique un arbre prérempli
   -- Paramètres :
   --     F_Arbre : IN OUT T_Arbre_Bin, l'arbre prérempli
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure commande_19_creer_arbre_prerempli(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : traitement_choix
   -- Semantique : Traitement du choix de l'utilisateur par rapport au menu
   -- Paramètres :
   --     F_Choix : IN Integer, Choix de l'utilisateur
   --     F_Arbre : IN T_Arbre_Bin, l'arbre appelé dans chaque commande
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure traitement_choix(F_Choix : in Integer; F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   
end P_Menu;
