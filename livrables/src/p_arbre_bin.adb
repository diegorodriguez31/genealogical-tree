package body P_Arbre_Bin is

   -- R0 : Initialise l'arbre binaire
   procedure initialiser(F_Arbre : out T_Arbre_Bin) is
   begin
      -- R1 : Initialiser le pointeur à la valeur null
      F_Arbre := null;
   end initialiser;

   procedure creerArbre(F_arbre  : in out T_Arbre_Bin ; F_Element : in T_Element) is
   begin
      -- R1 : Instancier le pointeur avec l'élément passé en entrée et des sous-arbres nulls
      F_arbre :=  new T_Noeud'(F_Element, null, null);
   end creerArbre;

   -- R0 : Indique si l'arbre est vide
   function estVide(F_Arbre : in T_Arbre_Bin) return Boolean is
   begin
      -- R1 : Renvoie vrai si l'arbre est null et faux sinon par une simple assertion
      return F_Arbre = null;
   end estVide;

   -- R0 : Renvoie le nombre d’éléments de l'arbre
   function taille(F_Arbre : in T_Arbre_Bin) return Integer is
   begin
      -- R1 : On vérifie si l'arbre est vide.
      if not estVide(F_Arbre) then
         -- R2 : Si l'arbre n'est pas vide, on calcule sa taille par récursivité des sous-arbres et en ajoutant 1 pour comptabiliser le noeud courant
         return taille(F_Arbre.all.Sous_Arbre_Gauche) + taille(F_Arbre.all.Sous_Arbre_Droit) + 1;
      else
         -- R2 : Sinon on renvoie 0
         return 0;
      end if;
   end taille;


   -- R0 : Insère l'element avec l'identifiant et la donnée dans l'arbre
   procedure inserer(F_Arbre : in out T_Arbre_Bin ; F_Nouvel_Element : in T_Element ; F_Inserer_A_Droite : in Boolean) is
   begin
      -- R1 : On vérifie que l'arbre n'est pas vide.
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, on crée un nouveau noeud avec la valeur du l'élément donné en entrée
         F_Arbre := new T_Noeud'(F_Nouvel_Element, null, null);
      else
         -- R2 : Sinon, on regarde la paramètre F_Inserer_A_Droite pour savoir si on l'insède à droite
         if F_Inserer_A_Droite then
            -- R3 : Si le paramètre vaut true, alors on vérifie que le sous-arbre droit soit vide
            if not estVide(F_Arbre.all.Sous_Arbre_Droit) then
               -- R4 : S'il n'est pas vide, on lève une exception pour dire que l'insertion est impossible
               raise emplacement_invalide;
            else
               -- R4 : Sinon, on crée un nouveau noeud pour le sous-arbre droit
               F_Arbre.all.Sous_Arbre_Droit := new T_Noeud'(F_Nouvel_Element, null, null);
            end if;
         else
            -- R3 : Sinon, on sait qu'il faut insérer à gauche et on vérifie  que le sous-arbre gauche soit vide
            if not estVide(F_Arbre.all.Sous_Arbre_Gauche) then
               -- R4 : S'il n'est pas vide, on lève une exception pour dire que l'insertion est impossible
               raise emplacement_invalide;
            else
               -- R4 : Sinon, on crée un nouveau noeud pour le sous-arbre gauche
               F_Arbre.all.Sous_Arbre_Gauche := new T_Noeud'(F_Nouvel_Element, null, null);
            end if;
         end if;
      end if;
   end inserer;

   -- R0 : Insère l'element à droite de l'arbre courant
   procedure insererSousArbreDroit(F_Arbre : in out T_Arbre_Bin ; F_Nouvel_Element : in T_Element) is
   begin
      -- R1 : On appelle insérer avec le dernier paramètre à true pour insérer un sous-arbre droit
      inserer(F_Arbre, F_Nouvel_Element, true);
   end insererSousArbreDroit;

   -- R0 : Insère l'element à gauche de l'arbre courant
   procedure insererSousArbreGauche(F_Arbre : in out T_Arbre_Bin ; F_Nouvel_Element : in T_Element) is
   begin
      -- R1 : On appelle insérer avec le dernier paramètre à false pour insérer un sous-arbre gauche
      inserer(F_Arbre, F_Nouvel_Element, false);
   end insererSousArbreGauche;

   -- R0 : Renvoie l'élément de l'arbre courant
   function getElement(F_Arbre : in T_Arbre_Bin) return T_Element is
   begin
      -- R1 : On vérifie si l'arbre est null
      if F_Arbre = null then
         -- R2 : S'il est null, on lève une exception car un arbre vide n'a pas d'élément à renvoyer
         raise arbre_null with "Impossible d'obtenir l'élément d'un arbre vide !";
      else
         -- R2 : Sinon, on renvoie l'élément du noeud courant
         return F_Arbre.all.Element;
      end if;
   end getElement;

   -- R0 : Modifie l'élément de l'arbre courant
   procedure setElement(F_Arbre : in out T_Arbre_Bin ; F_Element : in T_Element) is
   begin
      -- R1 : On vérifie si l'arbre est null
      if F_Arbre = null then
         -- R2 : S'il est null, on lève une exception car un arbre vide n'a pas d'élément à modifier
         raise arbre_null with "Impossible de modifier l'élément d'un arbre vide !";
      else
         -- R2 : Sinon, on modifie l'élément du noeud courant
         F_Arbre.all.Element := F_Element;
      end if;
   end setElement;


   -- R0 : Recherche d'un element dans l'arbre
   function recherche(F_Arbre : T_Arbre_Bin; F_Element : in T_Element; F_Retourner_Precedent : in Boolean) return T_Arbre_Bin is
      noeud : T_Arbre_Bin; -- Un noeud de type T_Arbre_Bin que l'on utilisera en tant qu'intermédiaire
   begin
      -- R1 : On stocke la valeur courante de F_Arbre dans noeud
      noeud := F_Arbre;
      -- R1 : Si le noeud n'est pas vide et que son élément est bien l'élément recherché
      if not estVide(noeud) and then egaux(noeud.all.Element, F_Element) then
         -- R2 : Si le paramètre F_Retourner_Precedent est à true, alors cela veut dire que l'on se situe à la racine et il n'existe pas d'élément précedent
         if F_Retourner_Precedent then
            -- R2 : On lève donc l'exception element_absent pour dire que le noeud est à la base de l'arbre binaire
            raise element_absent with "Le noeud demandé est à la base de l'arbre binaire. Il n'a donc pas de précédent !";
         else
            -- R2 : Sinon on renvoie le noeud car c'est le noeud recherché
            return noeud;
         end if;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : Tant que le noeud n'est pas vide et que l'élément recherché n'est pas celui de l'élément courant
      while (not estVide(noeud)) and then (not egaux(noeud.all.Element, F_Element)) loop
         -- R2 : Si on recherche l'élément précedent (le sur-arbre)
         if F_Retourner_Precedent then
            -- R3 : Si le sous-arbre gauche n'est pas null et qu'il a la bonne valeur recherchée
            if noeud.all.Sous_Arbre_Gauche /= null and then egaux(noeud.all.Sous_Arbre_Gauche.all.Element, F_Element) then
               -- R3 : On renvoie le noeud courant (le sur-arbre du sous-arbre gauche)
               return noeud;
               -- R3 : Si le sous-arbre droit n'est pas null et qu'il a la bonne valeur recherchée
            elsif noeud.all.Sous_Arbre_Droit /= null and then egaux(noeud.all.Sous_Arbre_Droit.all.Element, F_Element) then
               -- R3 : On renvoie le noeud courant (le sur-arbre du sous-arbre droit)
               return noeud;
            else
               -- R3 : Sinon, on ne fait rien
               null;
            end if;
         else
            -- R2 : Sinon, on ne fait rien
            null;
         end if;
         -- R2 : Si nous n'avons rien trouvé, on rappelle la procedure recherche par récursivité sur le sous-arbre gauche
         noeud := recherche(F_Arbre.all.Sous_Arbre_Gauche, F_Element, F_Retourner_Precedent);
         -- R2 : Si le sous-arbre gauche est null
         if noeud = null then
            -- R3 : Alors on rappelle la procedure recherche par récursivité sur le sous-arbre gauche
            noeud := recherche(F_Arbre.all.Sous_Arbre_Droit, F_Element, F_Retourner_Precedent);
         else
            -- R3 : Sinon, on ne fait rien
            null;
         end if;
      end loop;
      -- R1 : On a fini la recherche et on est sur le bon élément, on renvoie donc le noeud courant
      return noeud;
   end recherche;

   -- R0 : Indique si un élément existe dans l'arbre
   function existe(F_Arbre : T_Arbre_Bin; F_Element : in T_Element) return Boolean is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, on renvoie faux pour dire que l'arbre n'existe pas
         return False;
      else
         -- R2 : Sinon, on recherche l'élément demandé dans l'arbre courant et si on obient un résultat non null
         if recherche(F_Arbre, F_Element, false) /= null then
            -- R3 : Alors on renvoie vrai pour dire que le noeud avec F_Element existe dans l'arbre
            return True;
         else
            -- R3 : Sinon on renvoie faux pour dire que le noeud avec F_Element n'existe pas dans l'arbre
            return False;
         end if;
      end if;
   end existe;

   -- R0 : Modifie l'element dans l'arbre
   procedure modifier(F_Arbre : in out T_Arbre_Bin ; F_Src_Element : in T_Element; F_Tar_Element : in T_Element) is
      noeud : T_Arbre_Bin; -- Un noeud de type T_Arbre_Bin que l'on utilisera en tant qu'intermédiaire
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide on renvoie arbre_null car on ne peut pas modifier un arbre vide
         raise arbre_null with "Modification d'un arbre vide impossible !";
      else
         -- R2 : Sinon on recherche dans l'arbre l'élément que l'on souhaite modifier et on le stocke dans noeud
         noeud := recherche(F_Arbre, F_Src_Element, false);
         -- R2 : Si ce noeud est vide
         if estVide(noeud) then
            -- R3 : Alors on lève une exception pour dire que l'élément à modifier n'existe pas dans l'arbre
            raise element_absent with "Impossible de modifier un element absent !";
         else
            -- R3 : Sinon on modifie l'élément
            noeud.all.element := F_Tar_Element;
         end if;
      end if;
   end modifier;

   -- R0 : Supprime le noeud et tous les sous-arbres qui en résultent
   procedure supprimer(F_Arbre : in out T_Arbre_Bin ; F_Element : in T_Element) is
      noeud : T_Arbre_Bin; -- Un noeud de type T_Arbre_Bin que l'on utilisera en tant qu'intermédiaire
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, on lève une exception car on ne peut pas supprimer un arbre null
         raise arbre_null with "Impossible de supprimer une valeur dans un arbre vide !";
      else
         -- R2 : Sinon, on recherche le noeud à supprimer et on le stocke dans noeud
         noeud := recherche(F_Arbre, F_Element, False);
         -- R2 : On vérifie si ce noeud est vide
         if noeud = null then
            -- R3 : S'il est vide, alors on lève une exception car on ne peut pas supprimer un noeud null
            raise element_absent with "Suppression d'une valeur absente de l'arbre impossible !";
         -- R3 : Sinon si l'arbre courant donné en entré est l'arbre recherché
         elsif egaux(F_Arbre.all.Element, F_Element) then
            -- R4 : Alors on le supprime en le mettant à null
            F_Arbre := null;
         else
            -- R3 : Sinon, on a trouvé le noeud, donc on recherche son sur-arbre pour savoir si on doit supprimer le sous-arbre gauche ou droit
            noeud := recherche(F_Arbre, F_Element, True);
            -- R3 : Si le sous-arbre gauche du noeud n'est pas nul et possède le bon élément recherché
            if noeud.all.Sous_Arbre_Gauche /= null and then egaux(noeud.all.Sous_Arbre_Gauche.all.Element, F_Element) then
               -- R4 : Alors on supprime le sous-arbre gauche en le mettant à null
               noeud.all.Sous_Arbre_Gauche := null;
            else
               -- R4 : Sinon c'est que cela concerne le sous-arbre droit, donc on supprime ce sous-arbre en le mettant à null
               noeud.all.Sous_Arbre_Droit := null;
            end if;
         end if;
      end if;
   end supprimer;

   -- Cette procedure n'est pas utile ici comme expliqué dans "p_arbre_bin.ads"
   -- R0 : Affiche l'arbre dans l'ordre préfixé
   --procedure afficher(F_Arbre : in T_Arbre_Bin) is
   --begin
   --   -- R1 : On vérifie si l'arbre est vide
   --   if estVide(F_Arbre) then
   --   -- R2 : S'il est vide, on n'affiche rien
   --      null;
   --   else
   --     R2 : Sinon, on afficher récursivement l'élément affichant l'élément courant, le sous-arbre gauche puis le sous-arbre droit
   --     afficherElement(F_Arbre.all.Element);
   --     afficher(F_Arbre.all.Sous_Arbre_Gauche);
   --      afficher(F_Arbre.all.Sous_Arbre_Droit);
   --  end if;
   -- end afficher;

   -- R0 : Renvoie le sous-arbre gauche
   function getSousArbreGauche(F_Arbre : in T_Arbre_Bin) return T_Arbre_Bin is
   begin
      -- R1 : On vérifie si l'arbre est null
      if F_Arbre = null then
         -- R2 : S'il est null, alors on lève l'exception arbre_null car on ne peut pas renvoyer un élement qui n'existe pas
         raise arbre_null with "Impossible de renvoyer le sous-arbre gauche d'un arbre null !";
      else
         -- R2 : Sinon, on renvoie le sous-arbre gauche
         return F_arbre.all.Sous_Arbre_Gauche;
      end if;
   end getSousArbreGauche;

   -- R0 : Modifie le sous-arbre gauche
   procedure setSousArbreGauche(F_Arbre : in out T_Arbre_Bin ; F_SousArbreGauche : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est null
      if F_Arbre = null then
         -- R2 : S'il est null, alors on lève l'exception arbre_null car on ne peut pas modifier un élement qui n'existe pas
         raise arbre_null with "Impossible de modifier le sous-arbre gauche d'un arbre null !";
      else
         -- R2 : Sinon, on modifie le sous-arbre gauche
         F_Arbre.all.Sous_Arbre_Gauche := F_SousArbreGauche;
      end if;
   end setSousArbreGauche;

   -- R0 : Renvoie le sous-arbre droit
   function getSousArbreDroit(F_Arbre : in T_Arbre_Bin) return T_Arbre_Bin is
   begin
      -- R1 : On vérifie si l'arbre est null
      if F_Arbre = null then
         -- R2 : S'il est null, alors on lève l'exception arbre_null car on ne peut pas renvoyer un élement qui n'existe pas
         raise arbre_null with "Impossible de renvoyer le sous-arbre droit d'un arbre null !";
      else
          -- R2 : Sinon, on renvoie le sous-arbre droit
         return F_arbre.all.Sous_Arbre_Droit;
      end if;
   end getSousArbreDroit;

   -- R0 : Modifie le sous-arbre droit
   procedure setSousArbreDroit(F_Arbre : in out T_Arbre_Bin ; F_SousArbreDroit : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est null
      if F_Arbre = null then
         -- R2 : S'il est null, alors on lève l'exception arbre_null car on ne peut pas modifier un élement qui n'existe pas
         raise arbre_null with "Impossible de modifier le sous-arbre droit d'un arbre null !";
      else
         -- R2 : Sinon, on modifie le sous-arbre droit
         F_Arbre.all.Sous_Arbre_Droit := F_SousArbreDroit;
      end if;
   end setSousArbreDroit;

end P_Arbre_Bin;
