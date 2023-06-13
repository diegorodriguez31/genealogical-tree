with Ada.Text_IO; use ada.Text_IO;

generic
   -- Ce type est privé afin de pouvoir le déclarer d'une autre manière pour différentes instanciations d'arbre binaire
   type T_Element is private;
   -- Cette fonction est générique afin de pouvoir comparer les différents types d'arbes binaires
   with function egaux(element1 : in T_Element; element2 : in T_Element) return Boolean;
package P_Arbre_Bin is

   type T_Arbre_Bin is private;

   -- Exception qui se lève si le pointeur d'un arbre est null
   arbre_null : exception;
   -- Exception qui se lève si l'on recherche un élément inexistant dans l'arbre
   element_absent : exception;
   -- Exception qui se lève si l'on souhaite insérer un élément dans une zone déjà existante de l'arbre
   emplacement_invalide : exception;


   -------------------------

   -- PROCEDURE : initialiser
   -- Sémantique : Initialise l'arbre binaire
   -- Paramètres :
   --     F_Arbre : OUT T_Arbre_Bin, un pointeur vers l'arbre a initialiser
   -- Pré-conditions : taille de l'arbre = 0, F_donnee non null
   -- Post-conditions :  F_arbre non null, taille de l'arbre = 1
   -- Exceptions : Néant
   procedure initialiser(F_Arbre : out T_Arbre_Bin);

   -------------------------

   -- PROCEDURE : creerArbre
   -- Semantique : Crée un arbre binaire avec une donnée
   -- Paramètres :
   --     F_Arbre : IN OUT T_Arbre_Bin, Arbre a créer
   --     F_Element : IN T_Element
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure creerArbre(F_arbre  : in out T_Arbre_Bin ; F_Element : in T_Element);

   -------------------------

   -- FONCTION : estVide
   -- Sémantique : Indique si l'arbre est vide
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dont le catactère 'vide' doit être determinée
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Boolean, true si l'arbre est vide et false sinon
   -- Exceptions : Néant
   function estVide(F_Arbre : in T_Arbre_Bin) return Boolean;

   -------------------------

   -- FONCTION : taille
   -- Sémantique : Renvoie le nombre de noeuds de l'arbre.
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dont la taille doit être determinée
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Integer, le nombre de noeuds dans l'arbre donné
   -- Exceptions : element_absent
   function taille(F_Arbre : in T_Arbre_Bin) return Integer;

   -------------------------

   -- PROCEDURE : inserer
   -- Sémantique : Crée un nouvel arbre à partir d'un élément et l'insère après l'arbre courant
   -- Si l'arbre est vide, les paramètres F_Nouvel_Element et F_Inserer_A_Droite ne seront pas pris en compte
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut inserer
   --   F_Nouvel_Element : IN T_Element, l'element à insérer
   --   F_Inserer_A_Droite : IN Boolean, vrai si l'element doit être inséré à droite, faux si l'element doit être inséré à gauche
   -- Pré-conditions : Néant
   -- Post-conditions : Un sous-arbre est ajouté à l'arbre courant
   -- Exceptions :
   --   emplacement_invalide s'il existe déjà un element là où nouvel_element doit être inséré
   procedure inserer(F_Arbre : in out T_Arbre_Bin ; F_Nouvel_Element : in T_Element; F_Inserer_A_Droite : in Boolean);

   -------------------------

   -- PROCEDURE : insererSousArbreDroit
   -- Sémantique : Crée un nouvel arbre à partir d'un élément et l'insère après l'arbre courant
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut inserer
   --   F_Nouvel_Element : in T_Element, l'element à insérer
   -- Pré-conditions : Néant
   -- Post-conditions : Un sous-arbre droit est ajouté à l'arbre courant
   -- Exceptions :
   --   emplacement_invalide s'il existe déjà un element là où nouvel_element doit être inséré
   procedure insererSousArbreDroit(F_Arbre : in out T_Arbre_Bin ; F_Nouvel_Element : in T_Element);

   -------------------------

   -- PROCEDURE : insererSousArbreGauche
   -- Sémantique : Crée un nouvel arbre à partir d'un élément et l'insère après l'arbre courant
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut inserer
   --   F_Nouvel_Element : in T_Element, l'element à insérer
   -- Pré-conditions : Néant
   -- Post-conditions : Un sous-arbre gauche est ajouté à l'arbre courant
   -- Exceptions :
   --   emplacement_invalide s'il existe déjà un element là où nouvel_element doit être inséré
   procedure insererSousArbreGauche(F_Arbre : in out T_Arbre_Bin ; F_Nouvel_Element : in T_Element);

   -------------------------

   -- FONCTION : getElement
   -- Sémantique : Renvoie l'élément de l'arbre courant
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire courant
   -- Pré-conditions : Néant
   -- Post-conditions : L'élément de l'arbre est renvoyé
   -- Retourne : T_Element, l'élément de l'arbre courant (F_Arbre.all.Element)
   -- Exceptions :
   --   arbre_null si l'arbre donné en paramètre est null
   function getElement(F_Arbre : T_Arbre_Bin) return T_Element;

   -------------------------

   -- PROCEDURE : setElement
   -- Sémantique : Modifie l'élément de l'arbre courant
   -- Paramètres :
   --   F_Arbre : IN OUT T_Arbre_Bin, un pointeur vers l'arbre binaire courant
   --   F_Element : IN T_Element, le nouvel élément
   -- Pré-conditions : Néant
   -- Post-conditions : L'élément de l'arbre est modifiée (F_Arbre.all.Element = F_Element)
   -- Exceptions :
   --   arbre_null si l'arbre donné en paramètre est null
   procedure setElement(F_Arbre : in out T_Arbre_Bin ; F_Element : in T_Element);

   -------------------------

   -- FONCTION : recherche
   -- Sémantique : Renvoie un pointeur vers un arbre contenant l'élément recherché dans l'arbre donné
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut effectuer la recherche
   --   F_Element : IN T_Element, l'element recherché
   --   F_Retourner_Precedent : in Boolean, vrai s'il faut retourner l'element précédent, faux sinon
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : T_Arbre_Bin, un pointeur vers l'arbre binaire recherché. Vaut null si l'element n'as pas été trouvé.
   -- Exceptions :
   --    element_absent si on recherche l'élément précédent (F_Retourner_Precedent) et qu'on se trouve à la racine de l'arbre
   function recherche(F_Arbre : T_Arbre_Bin; F_Element : in T_Element; F_Retourner_Precedent : in Boolean) return T_Arbre_Bin;

   -------------------------

   -- FONCTION : existe
   -- Sémantique : Indique si un élément existe dans l'arbre
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut effectuer la recherche
   --   F_Element : IN T_Element, l'element recherché
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Boolean, true si l'arbre existe déjà et false sinon
   -- Exceptions : Néant
   function existe(F_Arbre : T_Arbre_Bin; F_Element : in T_Element) return Boolean;

   -------------------------

   -- PROCEDURE : modifier
   -- Sémantique : Modifie l'element dans l'arbre
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut modifier un element
   --   F_Src_Element : IN T_Element, l'element à modifier
   --   F_Tar_Element : IN T_Element, la nouvelle valeur de l'élement
   -- Pré-conditions : Néant
   -- Post-conditions : F_Arbre.Element := F_Tar_Element
   -- Exceptions :
   --   arbre_null si l'arbe est vide
   --   element_absent si l'élément source à modifier est absent
   procedure modifier(F_Arbre : in out T_Arbre_Bin ; F_Src_Element : in T_Element; F_Tar_Element : in T_Element);

   -------------------------

   -- PROCEDURE : supprimer
   -- Sémantique : Supprime un arbre et tous les sous-arbres qui en résultent
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre binaire dans lequel il faut supprimer un element
   --   F_Element : IN T_Element, l'élément à supprimer
   -- Pré-conditions : Néant
   -- Post-conditions : taille(F_Arbre) := taille(F_Arbre) - 1 et recherche(F_Arbre, F_Element) renvoie null
   -- Exceptions :
   --   arbre_null si l'arbe est vide
   --   element_absent si l'élément à supprimer est absent
   procedure supprimer(F_Arbre : in out T_Arbre_Bin; F_Element : in T_Element);

   -------------------------

   --  !!!!!!!!!!!!! J'ai laissé la procédure pour vous montrer que je comprends comment la faire
   --  Et il faudrait mettre en place de la généricité, mais je n'ai pas eu besoin de faire comme ceci
   --  Dans mon programme, j'ai donc décidé de la laisser en commentaire.   !!!!!!!!!!!!!
   -- Semantique : Affiche l'arbre dans l'ordre préfixé
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, l'arbre binaire à afficher
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché
   -- Exceptions : Néant
   -- Généricité de la fonction afficher de l'arbre binaire, j'ai choisis de ne pas l'utiliser
   -- Car j'ai adopté une autre manière de faire (j'affiche directement depuis l'arbre généalogique)
   --generic
   --    with procedure afficherElement(Element : in T_Element);
   --procedure afficher(F_Arbre : in T_Arbre_Bin);

   -------------------------

   -- FONCTION : getSousArbreGauche
   -- Semantique : Renvoie le sous-arbre gauche de l'arbre donné en entrée
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre dans lequel on récupère son sous-arbre gauche
   -- Pré-conditions : Néant
   -- Post-conditions : Le sous-arbre gauche est renvoyé (F_Arbre.all.Sous_Arbre_Gauche)
   -- Retourne : T_Arbre_Bin un pointeur vers le sous-arbre gauche de l'arbre courant
   -- Exceptions :
   --    arbre_null si l'arbre donné en paramètre est null
   function getSousArbreGauche(F_Arbre : in T_Arbre_Bin) return T_Arbre_Bin;

   -------------------------

   -- PROCEDURE : setSousArbreGauche
   -- Semantique : Modifie le sous-arbre gauche
   -- Paramètres :
   --   F_Arbre : IN OUT T_Arbre_Bin, l'arbre binaire qu'on veut modifier
   --   F_SousArbreGauche : IN T_Arbre_Bin, le nouveau sous-arbre gauche
   -- Pré-conditions : Néant
   -- Post-conditions : Le sous-arbre gauche est modifié (F_Arbre.all.Sous_Arbre_Gauche = F_SousArbreGauche)
   -- Exceptions :
   --    arbre_null si l'arbre donné en paramètre est null
   procedure setSousArbreGauche(F_Arbre : in out T_Arbre_Bin ; F_SousArbreGauche : in T_Arbre_Bin);

   -------------------------

   -- FONCTION : getSousArbreDroit
   -- Semantique : Renvoie le sous-arbre droit de l'arbre donné en entrée
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, un pointeur vers l'arbre dans lequel on récupère son sous-arbre droit
   -- Pré-conditions : Néant
   -- Post-conditions : Le sous-arbre droit est renvoyé (F_Arbre.all.Sous_Arbre_Droit)
   -- Retourne : T_Arbre_Bin un pointeur vers le sous-arbre droit de l'arbre courant
   -- Exceptions :
   --    arbre_null si l'arbre donné en paramètre est null
   function getSousArbreDroit(F_Arbre : in T_Arbre_Bin) return T_Arbre_Bin;

   -------------------------

   -- PROCEDURE : setSousArbreDroit
   -- Semantique : Modifie le sous-arbre droit
   -- Paramètres :
   --   F_Arbre : IN OUT T_Arbre_Bin, l'arbre binaire qu'on veut modifier
   --   F_SousArbreDroit : IN T_Arbre_Bin, le nouveau sous-arbre droit
   -- Pré-conditions : Néant
   -- Post-conditions : Le sous-arbre droit est modifié (F_Arbre.all.Sous_Arbre_Droit = F_SousArbreDroit)
   -- Exceptions :
   --    arbre_null si l'arbre donné en paramètre est null
   procedure setSousArbreDroit(F_Arbre : in out T_Arbre_Bin ; F_SousArbreDroit : in T_Arbre_Bin);

   -------------------------

private
   -- Un arbre pointe donc sur un noeud, quand je parle d'arbre ou de noeud, cela signifie la même chose
   type T_Noeud;
   -- Le pointeur de T_Arbre_Bin qui pointe sur un noeud. Il représente donc l'arbre binaire ou un noeud.
   type T_Arbre_Bin is access T_Noeud;

   -- L'enregistrement de ce que contient le noeud
   type T_Noeud is record
      Element : T_Element; -- L'élément du noeud
      Sous_Arbre_Gauche : T_Arbre_Bin; -- Le sous-arbre gauche du noeud
      Sous_Arbre_Droit : T_Arbre_Bin; -- Le sous-arbre droit du noeud
   end record;

end P_Arbre_Bin;
