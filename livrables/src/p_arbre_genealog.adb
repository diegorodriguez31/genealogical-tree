with Ada.Text_IO; use Ada.Text_IO;
with P_Individu;

package body P_Arbre_Genealog is

   -- R0 : Cette procédure permet d'afficher l'identifiant d'un individu avec l'id de type Int
   -- Car j'ai choisi d'implémenter individu_Integer et non individu_String
   -- Cette procedure n'a pas d'instanciation dans l'ads car elle est utilisée directement dans l'instanciation de l'affichage générique
   procedure afficherId_Integer(F_individu : in individu_Integer.T_Individu) is
   begin
      -- R1 : On affiche l'identifiant d'un individu sous la forme d'un Integer
      Put(Integer'Image(F_individu.id));
   end afficherId_Integer;
   
   -- Instanciation générique de la méthode afficherIndividu qui va afficher l'individu d'un arbre généalogique
   -- Cela provient de la procedure "afficherindividuComplet" du package p_individu qui utilise de manière générique la méthode "afficherIndiv"
   -- Qui est ici remplacée par "afficherId_Integer" juste au dessus
   procedure afficherIndividu is new afficherIndividuComplet(afficherIndiv => afficherId_Integer);
   
   -- R0 : Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   procedure creer(F_Arbre : out T_Arbre_Bin ; F_Individu : in T_Individu) is
   begin
      -- R1 : Appel de la méthode creerArbre de l'arbre binaire qui instancie directement un noeud sans avoir besoin de l'initialiser à null dans notre cas
      -- J'ai tout de même laisser la fonction initialiser dans le cas d'un besoin supplémentaire de l'utilisateur final qui voudrait
      -- Pouvoir instancier un arbre vide
      creerArbre(F_Arbre, F_Individu);
   end creer;
   
   -- R0 : Ajoute un parent à un noeud donné
   procedure ajouterParent(F_Arbre : in out T_Arbre_Bin ; F_Parent : in T_Individu ; F_PereOuMere : in Boolean) is
   begin
      -- R1 : On vérifie la valeur du paramètre F_PereOuMere
      if(F_PereOuMere) then
         -- R2 : Si le paramètre F_PereOuMere vaut true alors on souhaite insérer le père, c'est-à-dire le sous-arbre gauche
         insererSousArbreGauche(F_Arbre, F_Parent);
      else
         -- R2 : Sinon, on insère la mère, c'est-à-dire le sous-arbre droit
         insererSousArbreDroit(F_Arbre, F_Parent);
      end if;
   end ajouterParent;

   -- R0 : Ajoute un père à un noeud donné
   procedure ajouterPere(F_Arbre : in out T_Arbre_Bin ; F_Pere : in T_Individu) is
   begin
      -- R1 : On souhaite ici ajouter le père, donc on appelle la fonction ajouterParent avec le dernier paramètre à true
      ajouterParent(F_Arbre, F_Pere, true);
   end ajouterPere;

   -- R0 : Ajoute un mère à un noeud donné
   procedure ajouterMere(F_Arbre : in out T_Arbre_Bin ; F_Mere : in T_Individu) is
   begin
      -- R1 : On souhaite ici ajouter la mère, donc on appelle la fonction ajouterParent avec le dernier paramètre à false
      ajouterParent(F_Arbre, F_Mere, false);
   end ajouterMere;


   -- R0 : Obtient le nombre d'ancêtres connus d'un individu donné (lui compris)
   function nombreAncetres(F_Arbre : in T_Arbre_Bin ; F_Individu : in T_Individu) return Integer is
      arbre : T_Arbre_Bin; -- Un arbre de type T_Arbre_Bin que l'on utilisera en tant qu'intermédiaire
   begin
      -- R1 : On recherche l'arbre à partir duquel on souhaite chercher le nombre d'ancêtres puis on le stocke dans arbre
      arbre := recherche(F_Arbre, F_Individu, false);
      -- R1 : On appelle la fonction "taille" d'un arbre binaire afin de calculer sa taille à partir de l'arbre trouvé
      return taille(arbre);
   end nombreAncetres;
   
   -- R0 : Identifie les ancêtres d'une génération donnée pour un noeud donné
   procedure identifierAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier les ancêtres d'un arbre null
         raise arbre_null;
      else
         -- R2 : Sinon si la génération relative donnée est 0
         if F_Generation = 0 then
            -- R3 : Alors on lève l'exception pas_ancetre pour indiquer que cela correspond à l'individu
            -- lui-même et qu'il ne peut pas avoir d'ancêtre pour cette génération
            raise pas_ancetre;
         else
            -- R3 : Sinon on vérifie si le compteur (que je fais démarrer de 0 dans le menu appelant cette procedure) est égal à la génération recherchée
            if F_Compteur = F_Generation then
               -- R4 : Si oui, alors on est dans la bonne lignée d'ancêtres, on affiche donc l'individu
               afficherIndividu(getElement(F_Arbre));
               New_Line;
            else
               -- R4 : Sinon, on continue d'appeler récursivement "identifierAncetres" pour chercher la bonne lignée
               -- En incrémentant le compteur de 1 jusqu'à trouver la bonne génération
               begin
                  identifierAncetres(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
               exception when arbre_null =>
                     -- R4 : Il n'y a pas de sous-arbre gauche, donc on continue le traitement
                     null;
               end;
               -- R4 : On appelle récursivement l'arbre gauche puis l'arbre droit pour parcourir tout l'arbre
               begin
                  identifierAncetres(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
               exception when arbre_null =>
                     -- R4 : Il n'y a pas de sous-arbre droit, donc on continue le traitement
                     null;
               end;
            end if;
         end if;
      end if;
   end identifierAncetres;

   -- R0 : Obtient l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   procedure ensembleAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, on ne fait rien car l'arbre vide n'a pas d'ancêtre
         null;
      else
         -- R2 : Sinon on vérifie si la génération est de 0
         if F_Generation = 0 then
            -- R3 : Si elle est de 0, on lève l'exception pas_ancetre car pour sa propre lignée, l'individu n'a pas d'ancêtre
            raise pas_ancetre;
         else
            -- R3 : Sinon si le compteur est à 0 (première occurence de l'appel de cette procedure récursive) (pas besoin de renvoyer lui-même)
            -- et que le compteur n'est pas égal à la génération relative recherchée
            if(F_Compteur = 0 and F_Compteur /= F_Generation) then
               -- R4 : Alors on appelle récursivement la procedure "ensembleAncetres" pour le sous-arbre gauche
               ensembleAncetres(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
               -- R4 : Puis pour le sous-arbre droit afin de parcourir tout l'arbre
               ensembleAncetres(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
            else
               -- R4 : Sinon, c'est qu'on a commencé à avancer dans les générations et comme on souhaite afficher tous le monde
               -- alors on affiche l'individu courant qui est un des ancêtres afin de pouvoir récursivement afficher tout le monde jusqu'à la bonne génération
               afficherIndividu(getElement(F_Arbre));
               New_Line;
               -- R4 : Tant que le compteur n'est toujours pas égal à la génération (modélisé par un if mais grâce à la récursivité ça agit comme une boucle)
               -- Cela signifie que l'on a pas atteint la génération voulue afin d'afficher tous les ancêtres jusqu'à la génération recherchée
               if F_Compteur /= F_Generation then
                  -- R5 : Alors on appelle récursivement la procedure "ensembleAncetres" pour le sous-arbre gauche
                  ensembleAncetres(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
                  -- R5 : Puis pour le sous-arbre droit afin de parcourir tout l'arbre
                  ensembleAncetres(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
               else
                  -- R5 : On ne fait rien
                  null;
               end if;
            end if;
         end if;
      end if;
   end ensembleAncetres;

   -- R0 : Identifie les descendants d'une génération donnée pour un noeud donné
   procedure identifierDescendant(F_Arbre : in T_Arbre_Bin ; F_Arbre_Precedent : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre_Precedent) then
         -- R2 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier le descendant d'un arbre null
         raise arbre_null;
      else
         -- R2 : Sinon si la génération relative donnée est 0
         if F_Generation = 0 then
            -- R3 : Alors on lève l'exception pas_adescendant pour indiquer que cela correspond à l'individu
            -- lui-même et qu'il ne peut pas avoir de descendant pour cette génération
            raise pas_descendant;
         else
            -- R3 : Sinon on vérifie si le compteur (que je fais démarrer de 0 dans le menu appelant cette procedure) est égal à la génération recherchée
            if F_Compteur = F_Generation then
               -- R4 : Si oui, alors on est dans la bonne lignée du descendant, on affiche donc l'individu
               afficherIndividu(getElement(F_Arbre_Precedent));
               New_Line;
            else
               -- R4 : Sinon, on continue d'appeler récursivement "identifierDescendant" pour chercher la bonne lignée
               -- En incrémentant le compteur de 1 jusqu'à trouver la bonne génération
               -- Il n'y a pas de soucis de sous-arbre gauche ou droit ici car on manipule seulement les sur-arbres
               -- En mettant le dernier paramètre de la procedure "recherche" à true
               identifierDescendant(F_Arbre, recherche(F_Arbre, getElement(F_Arbre_Precedent), true), F_Generation, F_Compteur + 1);
            end if;
         end if;
      end if;
   end identifierDescendant;

   -- R0 : Obtient la succession de descendants d'une génération donnée pour un noeud donné
   procedure ensembleDescendants(F_Arbre : in T_Arbre_Bin ; F_Arbre_Precedent : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre_Precedent) then
         -- R2 : S'il est vide, on ne fait rien car l'arbre vide n'a pas de descendants
         null;
      else
         -- R2 : Sinon on vérifie si la génération est de 0
         if F_Generation = 0 then
            -- R3 : Si elle est de 0, on lève l'exception pas_descendant car pour sa propre lignée, l'individu n'a pas de descendant
            raise pas_descendant;
         else
            -- R3 : Sinon si le compteur est à 0 (première occurence de l'appel de cette procedure récursive) (pas besoin de renvoyer lui-même)
            -- et que le compteur n'est pas égal à la génération relative recherchée
            if(F_Compteur = 0 and F_Compteur /= F_Generation) then
               -- R4 : Alors on appelle récursivement la procedure "ensembleDescendants"
               -- Il n'y a pas de soucis de sous-arbre gauche ou droit ici car on manipule seulement les sur-arbres
               -- En mettant le dernier paramètre de la procedure "recherche" à true
               ensembleDescendants(F_Arbre, recherche(F_Arbre, getElement(F_Arbre_Precedent), true), F_Generation, F_Compteur + 1);
            else
               -- R4 : Sinon, c'est qu'on a commencé à avancer dans les générations et comme on souhaite afficher tous le monde
               -- alors on affiche l'individu courant qui est un des descendants afin de pouvoir récursivement afficher tout le monde jusqu'à la bonne génération
               afficherIndividu(getElement(F_Arbre_Precedent));
               New_Line;
               -- R4 : Tant que le compteur n'est toujours pas égal à la génération (modélisé par un if mais grâce à la récursivité ça agit comme une boucle)
               -- Cela signifie que l'on a pas atteint la génération voulue afin d'afficher tous les descendants jusqu'à la génération recherchée
               if F_Compteur /= F_Generation then
                  -- R5 : Alors on appelle récursivement la procedure "ensembleDescendants"
                  -- Il n'y a pas de soucis de sous-arbre gauche ou droit ici car on manipule seulement les sur-arbres
                  -- En mettant le dernier paramètre de la procedure "recherche" à true
                  ensembleDescendants(F_Arbre, recherche(F_Arbre, getElement(F_Arbre_Precedent), true), F_Generation, F_Compteur + 1);
               else
                  -- R5 : On ne fait rien
                  null;
               end if;
            end if;
         end if;
      end if;
      
   -- Je gère ici le cas où l'exception "element_absent" est levée lors de l'appel de la procedure "recherche"
   exception
      when element_absent =>
         -- Si cette exception est levée, je ne fais rien car je gère déjà cela dans le menu
         -- J'ai juste voulu faire ceci afin de vous montrer que je sais comment appeler l'exception de l'arbre binarie depuis
         -- L'arbre généalogique et vous montrer ainsi que je maîtrise le concept
         null;
   end ensembleDescendants;

   -- R0 : Affiche l'arbre généalogique à partir d'un noeud donné
   procedure afficherArbreGen(F_Arbre : in T_Arbre_Bin ; F_Compteur : in Integer) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, on n'affiche rien
         null;
      else
         -- R2 : Sinon, on affiche l'individu courant
         afficherIndividu(getElement(F_Arbre));
         -- R2 : On vérifie si le sous-arbre gauche est vide
         if estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : S'il est vide, on ne fait rien
            null;
         else
            -- R3 : Sinon, on boucle jusqu'à atteindre le compteur actuel qui s'incrémente à chaque appel récursif de la procédure
            New_Line;
            for i in 0..F_Compteur loop
               -- R4 : On ajoute une tabulation pour chaque compteur, cela permet de décaler d'une tabulation l'affichage pour chaque génération
               -- relativement au compteur appelé en paramètre
               Put("    ");
            end loop;
            -- R3 : Une fois la bonne distance de tabulations atteinte, on affiche le père visuellement
            Put("-- Pere : ");
            -- R3 : On affiche ensuite l'individu avec toutes ses informations
            afficherArbreGen(getSousArbreGauche(F_Arbre), F_Compteur+1);
         end if;
         -- R2 : On vérifie si le sous-arbre droit est vide
         if estVide(getSousArbreDroit(F_Arbre)) then
            -- R3 : S'il est vide, on ne fait rien
            null;
         else
            -- R3 : Sinon, on boucle jusqu'à atteindre le compteur actuel qui s'incrémente à chaque appel récursif de la procédure
            New_Line;
            for i in 0..F_Compteur loop
               -- R4 : On ajoute une tabulation pour chaque compteur, cela permet de décaler d'une tabulation l'affichage pour chaque génération
               -- relativement au compteur appelé en paramètre
               Put("    ");
            end loop;
             -- R3 : Une fois la bonne distance de tabulations atteinte, on affiche la mère visuellement
            Put("-- Mere : ");
            -- R3 : On affiche ensuite l'individu avec toutes ses informations
            afficherArbreGen(getSousArbreDroit(F_Arbre), F_Compteur+1);
         end if;
      end if;
   end afficherArbreGen;

   -- R0 : Supprime, pour un arbre, un noeud et ses ancêtres
   procedure supprimerNoeudEtAncetres(F_Arbre : in out T_Arbre_Bin ; F_Individu : in T_Individu) is
   begin
      -- R1 : On appelle la méthode "supprimer" de l'arbre binaire qui va supprimer automatiquement le noeud donnée et donc l'individu
      supprimer(F_Arbre, F_Individu);
   end supprimerNoeudEtAncetres;
   
   -- R0 : Modifie les valeurs d'un individu
   procedure modifierIndividu(F_Arbre : in out T_Arbre_Bin ; F_Individu_Source : in T_Individu ; F_Individu_Cible : in T_Individu) is
   begin
      -- R1 : On appelle la méthode "modifier" de l'arbre binaire qui va modifier automatiquement le noeud donné et donc l'individu
      modifier(F_Arbre, F_Individu_Source, F_Individu_Cible);
   end modifierIndividu;

   -- R0 : Obtient l'ensemble des individus dont les deux parents sont inconnus
   procedure listeAucunParent(F_Arbre : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_arbre) then
         -- R2 : On affiche que que si l'arbre est vide, il n'y a aucun individu, donc aucun parent connu
         Put_Line("Aucun individu n'a aucun parent connu !");
      else
         -- R2 : si le sous-arbre droit et vide et que le sous-arbre gauche aussi
         if estVide(getSousArbreDroit(F_Arbre)) and estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : alors on affiche l'individu courant car il n'a aucun parent connu
            afficherIndividu(getElement(F_Arbre));
            New_Line;
         else
            -- R3 : sinon on ne fait rien car le noeud à au moins un parent, ce qui n'est pas intéressant à afficher
            null;
         end if;
         -- R2 : si le sous-arbre gauche n'est pas vide alors
         if not estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : on appelle récursivement la fonction "listeAucunParent" à gauche afin de parcourir tout l'arbre
            listeAucunParent(getSousArbreGauche(F_Arbre));
         else
            -- R3 : Sinon on ne fait rien
            null;
         end if;
         -- R2 : si le sous-arbre droit n'est pas vide alors
         if not estVide(getSousArbreDroit(F_Arbre)) then
            -- R3 : on appelle récursivement la fonction "listeAucunParent" à droite afin de parcourir tout l'arbre
            listeAucunParent(getSousArbreDroit(F_Arbre));
         else
            -- R3 Sinon on ne fait rien
            null;
         end if;
      end if;
   end listeAucunParent;

   -- R0 : Obtient l'ensemble des individus qui n'ont qu'un parent connu
   procedure listeUnSeulParent(F_Arbre : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : On affiche que que si l'arbre est vide, il n'y a aucun individu, donc personne qui n'a qu'un seul parent connu
         Put_Line("Aucun individu n'a qu'un seul parent connu !");
      else
         -- R2 : si le sous-arbre droit et vide ou exclusif que le sous-arbre gauche aussi
         if estVide(getSousArbreDroit(F_Arbre)) xor estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : alors on affiche l'individu courant car il n'a qu'un seul parent connu
            afficherIndividu(getElement(F_Arbre));
            New_Line;
         else
            -- R3 : sinon on ne fait rien car le noeud ne respecte pas la condition, ce qui n'est pas intéressant à afficher
            null;
         end if;
         -- R2 : si le sous-arbre gauche n'est pas vide alors
         if not estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : on appelle récursivement la fonction "listeUnSeulParent" à gauche afin de parcourir tout l'arbre
            listeUnSeulParent(getSousArbreGauche(F_Arbre));
         else
            -- R3 : Sinon on ne fait rien
            null;
         end if;
         -- R2 : si le sous-arbre droit n'est pas vide alors
         if not estVide(getSousArbreDroit(F_Arbre)) then
            -- R3 : on appelle récursivement la fonction "listeUnSeulParent" à droite afin de parcourir tout l'arbre
            listeUnSeulParent(getSousArbreDroit(F_Arbre));
         else
            -- R3 Sinon on ne fait rien
            null;
         end if;
      end if;
   end listeUnSeulParent;

   -- R0 : Obtient l'ensemble des individus dont les deux parents sont connus
   procedure listeDeuxParents(F_Arbre : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : On affiche que que si l'arbre est vide, il n'y a aucun individu, donc personne dont les deux parents sont connus
         Put_Line("Aucun individu n'a les deux parents connus !");
      else
         -- R2 : si le sous-arbre droit et vide et que le sous-arbre gauche aussi
         if not estVide(getSousArbreDroit(F_Arbre)) and not estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : alors on affiche l'individu courant car il a les deux parents de connus
            afficherIndividu(getElement(F_Arbre));
            New_Line;
         else
            -- R3 : sinon on ne fait rien car le noeud ne respecte pas la condition, ce qui n'est pas intéressant à afficher
            null;
         end if;
         -- R2 : si le sous-arbre gauche n'est pas vide alors
         if not estVide(getSousArbreGauche(F_Arbre)) then
            -- R3 : on appelle récursivement la fonction "listeDeuxParents" à gauche afin de parcourir tout l'arbre
            listeDeuxParents(getSousArbreGauche(F_Arbre));
         else
            -- R3 : Sinon on ne fait rien
            null;
         end if;
         -- R2 : si le sous-arbre droit n'est pas vide alors
         if not estVide(getSousArbreDroit(F_Arbre)) then
            -- R3 : on appelle récursivement la fonction "listeDeuxParents" à droite afin de parcourir tout l'arbre
            listeDeuxParents(getSousArbreDroit(F_Arbre));
         else
            -- R3 Sinon on ne fait rien
            null;
         end if;        
      end if;
   end listeDeuxParents;

   -- R0 : Obtient les ancêtres paternels d'une génération donnée
   procedure identifierAncetrePaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer ; F_Compteur : in Integer) is
      sous_arbre_gauche : T_Arbre_Bin; -- Un arbre de type T_Arbre_Bin que l'on utilisera en tant que sous-arbre gauche intermédiaire
   begin
      -- R1 : on vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier les ancêtres paternels d'un arbre null
         raise arbre_null;
      else
         -- R2 : Sinon si la génération relative donnée est 0
         if F_Generation = 0 then
            -- R3 : Alors on lève l'exception pas_ancetre pour indiquer que cela correspond à l'individu
            -- lui-même et qu'il ne peut pas avoir d'ancêtre paternel pour cette génération
            raise pas_ancetre;
         else
            -- R3 : On recherche le sous-arbre gauche du noeud courant et on le stocke dans la variable sous_arbre_gauche
            sous_arbre_gauche := getSousArbreGauche(F_Arbre);
            -- R3 : On vérifie si ce sous-arbre gauche n'est pas vide et qu'on se situe juste avant la génération cherchée
            if (not estVide(sous_arbre_gauche) and F_Compteur =  F_Generation - 1) then
               -- R4 : Si les conditions sont validées, alors on affiche l'individu car c'est un ancêtre paternel situé à la bonne génération
               afficherIndividu(getElement(sous_arbre_gauche));
               New_Line;
            else
               -- R4 : On ne fait rien
               null;
            end if;
            -- R3 : Si on ne se situe pas un cran avant la bonne génération, alors on continue d'appeler récursivement
            -- la procedure "identifierAncetrePaternel" pour chercher la bonne lignée
            if F_Compteur /= F_Generation - 1 then
               -- R4 : Si la condition est vérifiée, alors on appelle récursivement l'arbre gauche pour parcourir tout l'arbre
               begin
                  identifierAncetrePaternel(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
               exception when arbre_null =>
                     -- R4 : Il n'y a pas de sous-arbre gauche, donc on continue le traitement
                     null;
               end;
               -- R4 : Puis on appelle récursivement l'arbre droit pour parcourir tout l'arbre
               begin
                  identifierAncetrePaternel(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
               exception when arbre_null =>
                     -- R4 : Il n'y a pas de sous-arbre droit, donc on continue le traitement
                     null;
               end;
            else
               -- R4 : On ne fait rien
               null;
            end if;
         end if;
      end if;
   end identifierAncetrePaternel;

   -- R0 : Obtient les ancêtres maternels d'une génération donnée
   procedure identifierAncetreMaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer ; F_Compteur : in Integer) is
      sous_arbre_droit : T_Arbre_Bin;
   begin
      -- R1 : on vérifie si l'arbre est vide
      if estVide(F_Arbre) then
         -- R2 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier les ancêtres maternels d'un arbre null
         raise arbre_null;
      else
         -- R2 : Sinon si la génération relative donnée est 0
         if F_Generation = 0 then
            -- R3 : Alors on lève l'exception pas_ancetre pour indiquer que cela correspond à l'individu
            -- lui-même et qu'il ne peut pas avoir d'ancêtre maternel pour cette génération
            raise pas_ancetre;
         else
            -- R3 : On recherche le sous-arbre droit du noeud courant et on le stocke dans la variable sous_arbre_droit
            sous_arbre_droit := getSousArbreDroit(F_Arbre);
            -- R3 : On vérifie si ce sous-arbre droit n'est pas vide et qu'on se situe juste avant la génération cherchée
            if (not estVide(sous_arbre_droit) and F_Compteur =  F_Generation - 1) then
               -- R4 : Si les conditions sont validées, alors on affiche l'individu car c'est un ancêtre maternel situé à la bonne génération
               afficherIndividu(getElement(sous_arbre_droit));
               New_Line;
            else
               -- R4 : On ne fait rien
               null;
            end if;
            -- R3 : Si on ne se situe pas un cran avant la bonne génération, alors on continue d'appeler récursivement
            -- la procedure "identifierAncetreMaternel" pour chercher la bonne lignée
            if F_Compteur /= F_Generation - 1 then
               -- R4 : Si la condition est vérifiée, alors on appelle récursivement l'arbre gauche pour parcourir tout l'arbre
               begin
                  identifierAncetreMaternel(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
               exception when arbre_null =>
                     -- R4 : Il n'y a pas de sous-arbre gauche, donc on continue le traitement
                     null;
               end;
               -- R4 : Puis on appelle récursivement l'arbre droit pour parcourir tout l'arbre
               begin
                  identifierAncetreMaternel(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
               exception when arbre_null =>
                     -- R4 : Il n'y a pas de sous-arbre droit, donc on continue le traitement
                     null;
               end;
            else
               -- R4 : On ne fait rien
               null;
            end if;
         end if;
      end if;
   end identifierAncetreMaternel;

   -- R0 : Vérifie si les deux arbres sont égaux
   function equivalent(F_Individu1, F_Individu2 : in T_Individu) return Boolean is
   begin
      -- R1 : On vérifie si l'identifiant du premier individu est le même que celui du second individu
      -- J'ai défini que l'identifiant était obligatoirement unique dans un arbre généalogique afin de facilement faire une recherche
      -- Par rapport à l'identifiant et de pouvoir comparer deux individus comme ci-dessous
      -- J'appelle pour ceci le getter situé dans le package p_individu
      return get_id(F_Individu1) = get_id(F_Individu2);
   end equivalent;

end P_Arbre_Genealog;
