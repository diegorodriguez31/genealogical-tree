with P_Arbre_Bin;
with P_Individu;

package P_Arbre_Genealog is

   -- Exception qui se lève si l'individu n'a pas d'ancêtre car la génération relative donnée est 0
   pas_ancetre : exception;
   -- Exception qui se lève si l'individu n'a pas de descendant ca r la génération relative donnée est 0
   pas_descendant : exception;
   
   -- Instanciation d'un individu avec l'identifiant de type Integer
   package individu_Integer is new P_Individu(T_Identifiant => Integer);
   use individu_Integer;

   -------------------------
   
   -- !!!!!!!!!! Instanciation d'un individu avec l'identifiant de type String
   -- Ici, j'ai la possibilité d'instancier l'individu avec un String en tant qu'identifiant mais j'ai décidé de ne pas le faire  !!!!!!!!!!
   --package individu_String is new P_Individu(T_Identifiant => String);
   --use individu_String;
   
   -------------------------
   
   -- FONCTION : equivalent
   -- Fonction générique pour vérifier l'égalité du contenu des noeuds
   -- Sémantique : Vérifie si les deux arbres sont égaux
   -- Paramètres :
   --    F_Arbre1, F_Arbre2 : IN T_Arbre_Bin, -- Arbre entier
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Booléen, vrai si les individus sont équivalents et non sinon
   -- Exceptions : Néant
   -- J'ai dû la déclarer plus haut dans le programme pour que l'instanciation du package
   -- P_Arbre_Bin ci-dessous comprenne que "equivalent" existe
   function equivalent(F_Individu1, F_Individu2 : in individu_Integer.T_Individu) return Boolean;
     
   -------------------------
   
   -- Instanciation d'un Arbre_Bin avec les données génériques d'un arbre généalogique
   -- Ainsi, un arbre genealogique est un arbre binaire, il peut donc utiliser les fonctions d'un arbre binaire et fonctionne comme un arbre binaire
   -- Mais avec des différences et implémentations propres à un arbre généalogique
   -- Le T_Element de l'arbre binaire sera ici un T_Individu
   -- La méthode "egaux" de l'arbre binaire sera ici la méthode "equivalent" pour comparer les éléments
   package arbre_genealogique is new P_Arbre_Bin(T_Element => T_Individu, egaux => equivalent);
   use arbre_genealogique;
   
   -------------------------
   
   -- PROCEDURE : creer
   -- Semantique : Crée un arbre minimal coutenant le seul noeud racine, sans père ni mère
   -- Paramètres :
   --     F_Arbre    : IN OUT T_Arbre_Bin -- pointeur vers l'arbre que l'ont crée
   --     F_Individu : IN T_Individu -- Individu de l'arbre créé
   -- Pré-conditions : Néant
   -- Post-conditions : F_Arbre non vide, taille = 1
   -- Exceptions : Néant
   procedure creer(F_Arbre : out T_Arbre_Bin ; F_Individu : in T_Individu);

   -------------------------
   
   -- PROCEDURE : ajouterParent
   -- Semantique : Ajoute un parent à un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Arbre auquel on ajoute un parent
   --    F_Parent : IN T_Arbre_Bin, -- Parent que l'on ajoute
   --    F_PereOuMere : IN Boolean -- Père si true et mère si false
   -- Pré-conditions : F_Arbre non vide
   -- Post-conditions : Taille(F_Arbre) := Taille(F_Arbre) + 1
   -- Exceptions :
   --   emplacement_invalide s'il existe déjà un element là où nouvel_element doit être inséré (levé par l'arbre binaire)
   procedure ajouterParent(F_Arbre : in out T_Arbre_Bin ; F_Parent : in T_Individu ; F_PereOuMere : in Boolean);

   -------------------------
   
   -- PROCEDURE : ajouterPere
   -- Semantique :  Ajoute un père à un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Arbre auquel on ajoute le père
   --    F_Parent : IN T_Arbre_Bin, -- Parent que l'on ajoute
   -- Pré-conditions : Néant
   -- Post-conditions : Taille(F_Arbre) := Taille(F_Arbre) + 1
   -- Exceptions :
   --   emplacement_invalide s'il existe déjà un element là où nouvel_element doit être inséré (levé par l'arbre binaire)
   procedure ajouterPere(F_Arbre : in out T_Arbre_Bin ; F_Pere : in T_Individu);

   -------------------------
   
   -- PROCEDURE : ajouterMere
   -- Semantique :  Ajoute une mère à un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Arbre auquel on ajoute la mère
   --    F_Parent : IN T_Arbre_Bin, -- Parent que l'on ajoute
   -- Pré-conditions : Néant
   -- Post-conditions : Taille(F_Arbre) := Taille(F_Arbre) + 1
   -- Exceptions :
   --   emplacement_invalide s'il existe déjà un element là où nouvel_element doit être inséré (levé par l'arbre binaire)
   procedure ajouterMere(F_Arbre : in out T_Arbre_Bin ; F_Mere : in T_Individu);

   -------------------------
   
   -- FONCTION : nombreAncetres
   -- Semantique : Obtient le nombre d'ancêtres connus d'un individu donné (lui compris)
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Arbre à partir duquel on va rechercher l'individu correspondant
   --    F_Individu : IN T_Individu   -- Individu auquel on va compter les ancêtres 
   -- Pré-conditions : Néant
   -- Post-conditions : Le nombre d'ancêtres est renvoyé
   -- Retourne : Integer, le nombre d'ancêtres
   -- Exceptions :
   --    arbre_null, si l'arbre donné est nul (levé par l'arbre binaire)
   function nombreAncetres(F_Arbre : in T_Arbre_Bin ; F_Individu : in T_Individu) return Integer;

   -------------------------
   
   -- PROCEDURE : identifierAncetres
   -- Sémantique : Identifie les ancêtres d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : Les ancêtres de la génération donnée est affiché
   -- Exceptions :
   --    pas_ancetre, si la génération donnée est 0 (l'arbre lui-même n'est pas un ancêtre)
   procedure identifierAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);

   -------------------------
   
   -- PROCEDURE : ensembleAncetres
   -- Semantique : Obtient l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des ancêtres est affiché
   -- Exceptions :
   --    pas_ancetre, si la génération donnée est 0 (l'arbre lui-même n'est pas un ancêtre)
   procedure ensembleAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);

   -------------------------
   
   -- PROCEDURE : identifierDescendant
   -- Sémantique : Identifie les descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Arbre_Precedent : IN T_Arbre_Bin -- Arbre précédent de l'arbre actuel pour pouvoir remonter dans la descendance
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur   : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : Le descendant de la génération donnée est affiché
   -- Exceptions :
   --    pas_descendant, si la génération donnée est 0 (l'arbre lui-même n'est pas un descendant)
   procedure identifierDescendant(F_Arbre : in T_Arbre_Bin ; F_Arbre_Precedent : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);

   -------------------------
   
   -- PROCEDURE : ensembleDescendants
   -- Sémantique : Obtient la succession de descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Arbre_Precedent : IN T_Arbre_Bin -- Arbre précédent de l'arbre actuel pour pouvoir remonter dans la descendance
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur   : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des descendants est affiché
   -- Exceptions :
   --    pas_descendant, si la génération donnée est 0 (l'arbre lui-même n'est pas un descendant)
   procedure ensembleDescendants(F_Arbre : in T_Arbre_Bin ; F_Arbre_Precedent : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);

   -------------------------
   
   -- PROCEDURE : afficherArbreGen
   -- Sémantique : Affiche l'arbre généalogique à partir d'un noeud donné
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Arbre à afficher à partir de ce noeud
   --    F_Compteur : IN Integer   -- Compteur pour l'affichage en tabulations
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure afficherArbreGen(F_Arbre : in T_Arbre_Bin ; F_Compteur : in Integer);

   -------------------------
   
   -- PROCEDURE : supprimerNoeudEtAncetres
   -- Sémantique : Supprime, pour un arbre, un noeud et ses ancêtres
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud que l'on supprime
   --    F_Individu : IN T_Individu   -- Individu à supprimer avec ses ancêtres
   -- Pré-conditions : Néant
   -- Post-conditions : Le noeud et ses ancêtres sont supprimés
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure supprimerNoeudEtAncetres(F_Arbre : in out T_Arbre_Bin ; F_Individu : in T_Individu);
   
   -------------------------
   
   -- PROCEDURE : modifierIndividu
   -- Sémantique : Modifie les valeurs d'un individu
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud que l'on met à null
   --    F_Individu_Source : IN T_Individu   -- Individu à modifier
   --    F_Individu_Cible  : IN T_Individu   -- Les nouvelles valeurs de l'individu
   -- Pré-conditions : Néant
   -- Post-conditions : Le noeud cible est modifié
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure modifierIndividu(F_Arbre : in out T_Arbre_Bin ; F_Individu_Source : in T_Individu ; F_Individu_Cible : in T_Individu);

   -------------------------
   
   -- PROCEDURE : listeAucunParent
   -- Sémantique : Obtient l'ensemble des individus dont les deux parents sont inconnus
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont pas de parent connu est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeAucunParent(F_Arbre : in T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : listeUnSeulParent
   -- Sémantique : Obtient l'ensemble des individus qui n'ont qu'un parent connu
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont qu'un parent connu est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeUnSeulParent(F_Arbre : in T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : listeDeuxParents
   -- Sémantique : Obtient l'ensemble des individus dont les deux parents sont connus
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus dont les deux parents sont connus est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeDeuxParents(F_Arbre : in T_Arbre_Bin);

   -------------------------
   
   -- PROCEDURE : identifierAncetrePaternel
   -- Sémantique : Obtient les ancêtres paternels d'une génération donnée
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : Les ancêtres sont affiché s'ils existent
   -- Exceptions :
   --    pas_ancetre, si la génération donnée est 0 (l'arbre lui-même n'est pas un ancêtre)
   procedure identifierAncetrePaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer ; F_Compteur : in Integer);

   -------------------------
   
   -- PROCEDURE : identifierAncetreMaternel
   -- Sémantique : Obtient les ancêtres maternels d'une génération donnée
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : Les ancêtres sont affiché s'ils existent
   -- Exceptions :
   --    pas_ancetre, si la génération donnée est 0 (l'arbre lui-même n'est pas un ancêtre)
   procedure identifierAncetreMaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer ; F_Compteur : in Integer);

end P_Arbre_Genealog;
