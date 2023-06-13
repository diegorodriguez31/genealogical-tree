with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package body P_Menu is

   -- Pour les prochaines procedures, l'arbre en entree est l'arbre racine principal qui sera utilise a chaque appel de procedure
   -- Pour l'entierete de ce corps "p_menu.adb", je ne vais pas preciser en raffinage les affichages "Put_Line" car l'affichage suffit a comprendre ce que j'ai voulu faire
   
   -- R0 : Affiche le menu des choix a l'utilisateur
   procedure afficherMenu is
   begin
      -- R1 : On affiche successivement du texte pour fabriquer le menu que verra l'utilisateur
      New_Line;
      New_Line;
      Put("##############################################");
      New_Line;
      Put_Line("                           MANIPULATION D'UN ARBRE GENEALOGIQUE              ");
      Put_Line("Que voulez-vous faire ?");
      New_Line;
      Put_Line("    1) Creer un arbre minimal coutenant le seul noeud racine, sans pere ni mere");
      Put_Line("    2) Ajouter un pere a un individu donne");
      Put_Line("    3) Ajouter une mere a un individu donne");
      Put_Line("    4) Obtenir le nombre d'ancetres connus d'un individu donne (lui compris)");
      Put_Line("    5) Identifier les ancetres d'une generation donnee pour un individu donne");
      Put_Line("    6) Obtenir l'ensemble des ancetres situes a une certaine generation d'un individu donne");
      Put_Line("    7) Identifier le descendant d'une generation donnee pour un individu donne");
      Put_Line("    8) Obtenir la succession de descendants d'une generation donnee pour un individu donne");
      Put_Line("    9) Afficher l'arbre genealogique a partir d'un individu donne");
      Put_Line("    10) Supprimer, pour un arbre, un individu et ses ancetres");
      Put_Line("    11) Modifier partiellement un individu");
      Put_Line("    12) Modifier totalement un individu");
      Put_Line("    13) Obtenir l'ensemble des individus dont les deux parents sont inconnus");
      Put_Line("    14) Obtenir l'ensemble des individus qui n'ont qu'un parent connu");
      Put_Line("    15) Obtenir l'ensemble des individus dont les deux parents sont connus");
      Put_Line("    16) Obtenir l'ancetre paternel d'une generation donnee pour un individu donne");
      Put_Line("    17) Obtenir l'ancetre maternel d'une generation donnee pour un individu donne");
      New_Line;
      Put_Line("                                  COMMANDES UTILES                            ");
      New_Line;
      Put_Line("    18) Afficher l'arbre genealogique entierement");
      Put_Line("    19) Creer un arbre prerempli");
      Put_Line("    0) Quitter");
      New_Line;
      Put("##############################################");
      New_Line;
      New_Line;
   end afficherMenu;
   
   -- R0 : Cree un arbre avec une donnee initiale
   procedure commande_1_creer_arbre(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      valider : Integer; -- Un Integer pour recuperer le choix de l'utilisateur
   begin
      -- R1 : Si l'arbre n'est pas vide
      if not arbre_genealogique.estVide(F_Arbre) then
         loop
            -- R2 : On indique a l'utilisateur qu'un arbre existe deja et on verifie s'il veut ecrive par dessus l'ancien arbre ou non
            Put_Line("Un arbre existe deja. Souhaitez-vous tout de meme en initialiser un nouveau en ecrivant par dessus l'arbre existant ?");
            Put_Line("  OUI => Tapez 1");
            Put_Line("  NON => Tapez 2");
            New_Line;
            Get(valider);
            -- R2 : Si "valider" n'est pas egal a 1 ou 2
            if valider < 1 or valider > 2 then
               -- R3 : On demande de saisir une valeur correcte
               New_Line;
               Put_Line("Veuillez saisir '1' ou '2' pour confirmer votre decision");
               New_Line;
            else
               -- R3 : On ne fait rien
               null;
            end if;
            exit when valider = 1 or valider = 2;
         end loop;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : Si l'arbre n'est pas vide et que l'utilisateur souhaite tout de meme l'ecraser ou si l'arbre est vide
      if (not arbre_genealogique.estVide(F_Arbre) and valider = 1) or arbre_genealogique.estVide(F_Arbre) then
         -- R2 : On demande l'identifiant du nouveau noeud et on le recupere
         Put_Line("=> Saisissez un identifiant : ");
         Get(id);
         -- R2 : On cree ce nouvel arbre racine et appelle "creerIndividu" pour creer l'individu avec l'id donne
         creer(F_Arbre, individu_Integer.creerIndividu(id));
         -- R2 : On affiche entierement cet arbre
         commande_18_afficher_entierement(F_Arbre);
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
   end commande_1_creer_arbre;
   
   -- R0 : Ajoute un pere a l'arbre passe en entree
   procedure commande_2_ajouter_pere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
   begin
      loop
         -- R1 : On demande a l'utilisateur a quel noeud il veut ajouter le pere et on recupere l'id
         Put_Line("=> A qui ajouter le pere ?");
         Get(id);
         -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         -- R1 : Si l'arbre est vide
         if arbre_genealogique.estVide(arbre) then
            -- R2 : On leve l'exception "element_absent"
            raise arbre_genealogique.element_absent;
         else
            -- R2 : Sinon, on ne fait rien
            null;
         end if;
         -- R1 : On sort quand on a le noeud voulu
         exit  when not arbre_genealogique.estVide(arbre);
      end loop;
      loop
         -- R1 : On demande l'identifiant pour ce nouveau noeud et on recupere l'id
         Put_Line("=> Quel identifiant pour ce pere ?");
         Get(id);
         -- R1 : Si cet id existe deja
         if arbre_genealogique.existe(F_Arbre, individu_Integer.creerIndividu_Id(id)) then
            -- R2 : On affiche un message d'erreur
            New_Line;
            Put_Line("/!\ Individu deja existant /!\");
            New_Line;
         else
            -- R2 : Sinon on ne fait rien
            null;
         end if;
         -- R1 : On sort quand l'utilisateur saisi un id non existant
         exit when not arbre_genealogique.existe(F_Arbre, individu_Integer.creerIndividu_Id(id));
      end loop;
      -- R1 : On appelle la procedure "ajouterPere" pour ajouter le pere au noeud choisi
      ajouterPere(arbre, individu_Integer.creerIndividu(id));
      New_Line;
      Put_Line("=> PERE AJOUTE AVEC SUCCES !");
      New_Line;
   end commande_2_ajouter_pere;
   
   -- R0 : Ajoute une mere a l'arbre passe en entree
   procedure commande_3_ajouter_mere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
   begin
      loop
         -- R1 : On demande a l'utilisateur a quel noeud il veut ajouter la mere et on recupere l'id
         Put_Line("=> A qui ajouter la mere ?");
         Get(id);
         -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         -- R1 : Si l'arbre est vide
         if arbre_genealogique.estVide(arbre) then
            -- R2 : On leve l'exception "element_absent"
            raise arbre_genealogique.element_absent;
         else
            -- R2 : Sinon, on ne fait rien
            null;
         end if;
         -- R1 : On sort quand on a le noeud voulu
         exit  when not arbre_genealogique.estVide(arbre);
      end loop;
      loop
         -- R1 : On demande l'identifiant pour ce nouveau noeud et on recupere l'id
         Put_Line("=> Quel identifiant pour cette mere ?");
         Get(id);
         -- R1 : Si cet id existe deja
         if arbre_genealogique.existe(F_Arbre, individu_Integer.creerIndividu_Id(id)) then
            -- R2 : On affiche un message d'erreur
            New_Line;
            Put_Line("/!\ Individu deja existant /!\");
            New_Line;
         else
            -- R2 : Sinon on ne fait rien
            null;
         end if;
         -- R1 : On sort quand l'utilisateur saisi un id non existant
         exit when not arbre_genealogique.existe(F_Arbre, individu_Integer.creerIndividu_Id(id));
      end loop;
      -- R1 : On appelle la procedure "ajouterMere" pour ajouter le pere au noeud choisi
      ajouterMere(arbre, individu_Integer.creerIndividu(id));
      New_Line;
      Put_Line("=> MERE AJOUTE AVEC SUCCES !");
      New_Line;
   end commande_3_ajouter_mere;
   
   -- R0 : Affiche le nombre d'ancetres que possede l'arbre passe en entree
   procedure commande_4_nombre_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      nb_ancetres : Integer; -- Un Integer qui va stocker le nombre d'ancetres
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
   begin
      -- R1 : On demande a l'utilisateur de quel individu il veut le nombre d'ancetres et on recupere l'id
      Put_Line("=> De quel individu voulez-vous le nombre d'ancetres ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si cet arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : S'il est vide, on leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On appelle la procedure "nombreAncetres" et on stocke le resultat dans la variable "nb_ancetres"
      nb_ancetres := nombreAncetres(F_Arbre, individu_Integer.creerIndividu_Id(id));
      -- R1 : On affiche le nombre d'ancetres
      Put("=> L'individu" & Integer'Image(id) & " a" & Integer'Image(nb_ancetres) & " ancetres, lui compris.");
   end commande_4_nombre_ancetres;
   
   -- R0 : Affiche les ancetres de generation demande pour l'arbre passe en entree
   procedure commande_5_identifier_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      id : Integer; -- Un identifiant de type Integer
      generation : Integer; -- Un Integer pour identifier la generation demandee
      compteur : constant Integer := 0; -- Un compteur qui s'incremente jusqu'a atteindre la generation demandee
   begin
      -- R1 : On demande de quel individu on recherche les ancetres et on demande l'id
      Put_Line("=> De quel individu recherchez-vous les ancetres ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : S'il est vide, on leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On demande la generation souhaitee et on la recupere
      Put_Line("=> A quelle generation par rapport a cet individu voulez-vous rechercher ses ancetres ?");
      Get(generation);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On affiche les ancetres en appelant la methode "identifierAncetres"
      Put_Line("=> Voici les ancetres de l'individu"  & Integer'Image(id) & ":");
      identifierAncetres(arbre, generation, compteur);
      
      -- R1 : Si l'exception arbre_null est levee, on affiche un message
   exception
      when arbre_genealogique.arbre_null =>
            Put_Line("Un des deux parents ou les deux parents ne sont pas connus !");
   end commande_5_identifier_ancetres;
   
   -- R0 : 
   procedure commande_6_ensemble_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      id : Integer; -- Un identifiant de type Integer
      generation : Integer; -- Un Integer pour identifier la generation demandee
      compteur : constant Integer := 0; -- Un compteur qui s'incremente jusqu'a atteindre la generation demandee
   begin
      Put_Line("=> De quel individu recherchez-vous les ancetres ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : On leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      Put_Line("=> A quelle generation par rapport a cet individu voulez-vous rechercher l'ensemble de ses ancetres ?");
      Get(generation);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On affiche l'ensemble des ancetres en appelant la methode "ensembleAncetres"
      Put_Line("=> Voici l'ensemble des ancetres de l'individu" & Integer'Image(id) & ":");
      ensembleAncetres(arbre, generation, compteur);
   end commande_6_ensemble_ancetres;     
   
   -- R0 : Affiche les descendants de generation demande pour l'arbre passe en entree
   procedure commande_7_identifier_descendant(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      id : Integer; -- Un identifiant de type Integer
      generation : Integer; -- Un Integer pour identifier la generation demandee
      compteur : constant Integer := 0; -- Un compteur qui s'incremente jusqu'a atteindre la generation demandee
   begin
      -- R1 : On demande de quel individu on recherche le descendant et on recupere son id
      Put_Line("=> De quel individu recherchez-vous le descendant ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : On leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On demande la generation souhaitee et on la recupere
      Put_Line("=> A quelle generation par rapport a cet individu voulez-vous rechercher son descendant ?");
      Get(generation);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On affiche les descendants en appelant la methode "identifierDescendant"
      Put_Line("=> Voici le descendant de l'individu"  & Integer'Image(id) & " :");
      identifierDescendant(F_Arbre, arbre, generation, compteur);
      
      -- R1 : Si l'exception arbre_null ou element_absent est levee, on affiche un message
   exception
      when arbre_genealogique.arbre_null =>
         Put_Line("Aucun descendant connu pour la generation donnee !");
      when arbre_genealogique.element_absent =>
         Put_Line("Aucun descendant connu pour la generation donnee !");
   end commande_7_identifier_descendant;
   
   -- R0 : 
   procedure commande_8_ensemble_descendants(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      id : Integer; -- Un identifiant de type Integer
      generation : Integer; -- Un Integer pour identifier la generation demandee
      compteur : constant Integer := 0; -- Un compteur qui s'incremente jusqu'a atteindre la generation demandee
   begin
      -- R1 : On demande de quel individu l'utilisateur souhaite connaître les descendants et on recupere son id
      Put_Line("=> De quel individu recherchez-vous les descendants ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : On leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On demande la generation souhaitee et on la recupere
      Put_Line("=> A quelle generation par rapport a cet individu voulez-vous rechercher l'ensemble de ses descendants ?");
      Get(generation);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On affiche l'ensemble des descendants en appelant la methode "ensembleDescendants"
      Put_Line("=> Voici les descendants de l'individu" & Integer'Image(id) & " :");
      ensembleDescendants(F_Arbre, arbre, generation, compteur);
   end commande_8_ensemble_descendants;
   
   -- R0 : Affiche l'arbre genealogique
   procedure commande_9_afficher(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
   begin
      -- R1 : On demande a partir de quel individu on souhaite afficher l'arbre puis on recupere son id
      Put_Line("=> Quel est l'individu racine de l'arbre ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : On leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      New_Line;
      -- R1 : On affiche l'arbre a partir de ce nouvel arbre en appelant la procedure "afficherArbreGen" 
      Put_Line("***********************************************");
      afficherArbreGen(arbre, 0);
      New_Line;
      Put_Line("***********************************************");
   end commande_9_afficher;
   
   -- R0 : Supprime une branche de l'arbre
   procedure commande_10_supprimer_branche(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
   begin
      -- R1 : On demande quel individu l'utilisateur souhaite supprimer et on recupere son id
      Put_Line("=> Quel individu voulez-vous supprimer ? Attention, cela supprimera aussi ses ancetres");
      Get(id);
      -- R1 : On supprime cet individu par l'appel de la procedure "supprimerNoeudEtAncetres"
      supprimerNoeudEtAncetres(F_Arbre, individu_Integer.creerIndividu_Id(id)); 
      New_Line;
      Put_Line("=> INDIVIDU SUPPRIME AVEC SUCCES !");
      New_Line;
   end commande_10_supprimer_branche;
   
   -- R0 : Modifie une information d'un individu
   procedure commande_11_modifier_individu(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      informations : individu_Integer.PT_Informations; -- Un pointeur d'informations que l'on va utiliser pour remplir le champ d'informations du nouvel individu
      individu_source : individu_Integer.T_Individu; -- L'individu que l'on souhaite modifier
      individu_cible : individu_Integer.T_Individu; -- Le nouvel individu de remplacement de l'individu source 
      choix : Integer; -- Le choix que l'utilisateur va faire pour choisir quoi modifier
      nom : Unbounded_String; -- Une variable intermediaire pour recuperer le nouveau nom
      prenom : Unbounded_String; -- Une variable intermediaire pour recuperer le nouveau prenom
      sexe : Unbounded_String; -- Une variable intermediaire pour recuperer le nouveau sexe
      date_naissance : Unbounded_String; -- Une variable intermediaire pour recuperer la nouvelle date de naissance
      date_deces : Unbounded_String; -- Une variable intermediaire pour recuperer la nouvelle date de deces
      adresse : Unbounded_String; -- Une variable intermediaire pour recuperer la nouvelle adresse

   begin
      -- R1 : On demande quel individu l'utilisateur souhaite modifier
      Put_Line("=> Quel individu voulez-vous modifier ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On recupere l'individu actuel pour en faire l'individu source
      individu_source := arbre_genealogique.getElement(arbre);
      -- R1 : On affiche les informations de l'individu que l'on veut modifier pour une meilleure lisibilite
      individu_Integer.afficherInformations(individu_source);
      -- R1 : On met a jour les informations de l'individu cible pour qu'il est les memes que celles de l'individu source
      individu_cible.Informations := individu_source.Informations;
      -- R1 : on recupere les informations de l'individu source et on les stocke dans une variable intermediaire
      informations := individu_Integer.get_informations(individu_source);
      -- R1 : Si le pointeur "informations" n'est pas nul
      if not (individu_Integer.estNul(informations)) then
         -- R2 : On demande a l'utilisateur quelle information il veut modifier
         loop
            Put_Line("=> Quelles valeurs voulez-vous modifier ?");
            Put_Line("      NOM => Tapez 1");
            Put_Line("      PRENOM => Tapez 2");
            Put_Line("      SEXE => Tapez 3");
            Put_Line("      DATE DE NAISSANCE => Tapez 4");
            Put_Line("      DATE DE DECES => Tapez 5");
            Put_Line("      ADRESSE => Tapez 6");
            -- R2 : On demande son choix en boucle  tant qu'il n'a pas saisi une valeur entre 0 et 6
            Get(choix);
            if choix < 0 or choix > 6 then
               New_Line;
               Put_Line("              /!\ Il n'y a que 6 choix possibles /!\");
               New_Line;
            else
               null;
            end if;
            exit when choix > 0 and choix < 7;
         end loop;
         -- R2 : En fonction du choix, on change l'information que l'utilisateur souhaite
         case choix is
            -- R3 : Si c'est le nom
         when 1 =>
            -- R4 : On demande le nom puis on le recupere
            Put_Line("Veuillez indiquer le nouveau nom :");
            Skip_Line;
            Get_Line(nom);
            -- R4 : On change le champ "Nom" du pointeur "informations"
            informations.all.Nom := nom;
            -- R3 : Si c'est le prenom
         when 2 =>
            -- R4 : On demande le prenom puis on le recupere
            Put_Line("Veuillez indiquer le nouveau prenom :");
            Skip_Line;
            Get_Line(prenom);
            -- R4 : On change le champ "Prenom" du pointeur "informations"
            informations.all.Prenom := prenom;
            -- R3 : Si c'est le sexe
         when 3 =>
            -- R4 : On demande le sexe puis on le recupere
            Put_Line("Veuillez indiquer le nouveau sexe :");
            Skip_Line;
            Get_Line(sexe);
            -- R4 : On change le champ "Sexe" du pointeur "informations"
            informations.all.Sexe := sexe;
            -- R3 : Si c'est la date de naissance
         when 4 =>
            -- R4 : On demande la date de naissance puis on le recupere
            Put_Line("Veuillez indiquer la nouvelle date de naissance :");
            Skip_Line;
            Get_Line(date_naissance);
            -- R4 : On change le champ "Date_Naissance" du pointeur "informations"
            informations.all.Date_Naissance := date_naissance;
            -- R3 : Si c'est la date de deces
         when 5 =>
            -- R4 : On demande la date de deces puis on le recupere
            Put_Line("Veuillez indiquer la nouvelle date de deces :");
            Skip_Line;
            Get_Line(date_deces);
            -- R4 : On change le champ "Date_Deces" du pointeur "informations"
            informations.all.Date_Deces := date_deces;
            -- R3 : Si c'est l'adresse
         when 6 =>
            -- R4 : On demande l'adresse puis on le recupere
            Put_Line("Veuillez indiquer la nouvelle adresse :");
            Skip_Line;
            Get_Line(adresse);
            -- R4 : On change le champ "Adresse" du pointeur "informations"
            informations.all.Adresse := adresse;
         when others => null;
         end case;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On fabrique on nouvel individu "individu_cible" en recuperant l'id de l'individu source et le nouveau pointeur d'informations
      individu_cible := individu_Integer.creerIndividu(individu_Integer.get_id(individu_source), informations);
      -- R1 : On appelle la proceudre "modifierIndividu" pour bien mettre en place la modification
      modifierIndividu(F_Arbre, individu_source, individu_cible);
      -- R1 : On affiche les nouvelles informations pour que l'utilisateur verifie rapidement que la modification a bien ete faite
      individu_Integer.afficherInformations(individu_source);
      New_Line;
      Put_Line("=> INDIVIDU MODIFIE AVEC SUCCES !");
      New_Line;
   end commande_11_modifier_individu;
   
   -- R0 : Modifier toutes les informations d'un individu
   procedure commande_12_modifier_totalement_individu(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer; -- Un identifiant de type Integer
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      individu_source : individu_Integer.T_Individu; -- L'individu que l'on souhaite modifier
      individu_cible : individu_Integer.T_Individu; -- Le nouvel individu de remplacement de l'individu source 
   begin 
      -- R1 : On demande a l'utilisateur quel individu il veut modifier et on recupere son identifiant
      Put_Line("=> Quel individu voulez-vous modifier ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On recupere l'individu actuel pour en faire l'individu source
      individu_source := arbre_genealogique.getElement(arbre);
      -- R1 : On fabrique l'individu cible avec l'id de l'individu source
      individu_cible := individu_Integer.creerIndividu(id);
      -- R1 : on appelle la procedure "modifierIndividu" pour bien mettre en place la modification
      modifierIndividu(F_Arbre, individu_source, individu_cible);
      -- R1 : On affiche les nouvelles informations pour que l'utilisateur verifie rapidement que la modification a bien ete faite
      individu_Integer.afficherInformations(individu_cible);
      New_Line;
      Put_Line("=> INDIVIDU MODIFIE AVEC SUCCES !");
      New_Line;
   end commande_12_modifier_totalement_individu;
     
   -- R0 : Affiche le nombre d'individus qui n'ont aucun parent connu
   procedure commande_13_aucun_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      -- R1 : On affiche les individus qui n'ont aucun parent connu avec l'appel de la procedure "listeAucunParent"
      Put_Line("=> Les individus qui n'ont aucun parent connu sont : ");
      listeAucunParent(F_Arbre);
   end commande_13_aucun_parent_connu;
   
   -- R0 : Affiche le nombre d'individus qui n'ont qu'un seul parent connu
   procedure commande_14_un_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      -- R1 : On affiche les individus qui n'ont qu'un seul parent connu avec l'appel de la procedure "listeUnSeulParent"
      Put_Line("=> Les individus qui n'ont qu'un seul parent connu sont : ");
      listeUnSeulParent(F_Arbre);
   end commande_14_un_parent_connu;
   
   -- R0 : Affiche le nombre d'individus qui ont les deux parents connus
   procedure commande_15_deux_parents_connus(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      -- R1 : On affiche les individus qui ont les deux parents connus avec l'appel de la procedure "listeDeuxParents"
      Put_Line("=> Les individus qui ont les deux parents connus sont : ");
      listeDeuxParents(F_Arbre);
   end commande_15_deux_parents_connus;
   
   -- R0 : Affiche l'ancetre maternel de generation demande pour l'arbre passe en entree
   procedure commande_16_identifier_ancetre_paternel(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      id : Integer; -- Un identifiant de type Integer
      generation : Integer; -- Un Integer pour identifier la generation demandee
      compteur : constant Integer := 0; -- Un compteur qui s'incremente jusqu'a atteindre la generation demandee
   begin
      -- R1 : On demande a l'utilisateur de quel individu il recherche les ancetres paternels et on recupere son identifiant
      Put_Line("=> De quel individu recherchez-vous les ancetres paternels ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : On leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On demande a l'utilisateur la generation souhaitee et on la recupere
      Put_Line("=> A quelle generation par rapport a cet individu voulez-vous rechercher ses ancetres paternels ?");
      Get(generation);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On affiche les ancetres paternels de l'individu souhaite par l'appel de la procedure "identifierAncetrePaternel"
      Put_Line("=> Voici les ancetres paternels de l'individu" & Integer'Image(id) & ":");
      identifierAncetrePaternel(arbre, generation, compteur);
      
      -- R1 : Si l'exception arbre_null est levee, on affiche un message
   exception
      when arbre_genealogique.arbre_null =>
         Put_Line("Aucun ancetre paternel connu pour la generation donnee !");
   end commande_16_identifier_ancetre_paternel;
   
   -- R0 : Affiche l'ancetre maternel de generation demande pour l'arbre passe en entree
   procedure commande_17_identifier_ancetre_maternel(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      id : Integer; -- Un identifiant de type Integer
      generation : Integer; -- Un Integer pour identifier la generation demandee
      compteur : constant Integer := 0; -- Un compteur qui s'incremente jusqu'a atteindre la generation demandee
   begin
      -- R1 : On demande a l'utilisateur de quel individu il recherche les ancetres maternels et on recupere son identifiant
      Put_Line("=> De quel individu recherchez-vous les ancetres maternels ?");
      Get(id);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(arbre) then
         -- R2 : On leve l'exception "element_absent"
         raise arbre_genealogique.element_absent;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : On demande a l'utilisateur la generation souhaitee et on la recupere
      Put_Line("=> A quelle generation par rapport a cet individu voulez-vous rechercher ses ancetres maternels ?");
      Get(generation);
      -- R1 : On utilise l'arbre intermediaire pour rechercher ce noeud demande
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      -- R1 : On affiche les ancetres maternels de l'individu par l'appel de la fonction "identifierAncetreMaternel"
      Put_Line("=> Voici les ancetres maternels de l'individu" & Integer'Image(id) & ":");
      identifierAncetreMaternel(arbre, generation, compteur);

      -- R1 : Si l'exception arbre_null est levee, on affiche un message
   exception
      when arbre_genealogique.arbre_null =>
         Put_Line("Aucun ancetre maternel connu pour la generation donnee !");
   end commande_17_identifier_ancetre_maternel;
   
   -- R0 : Affiche l'arbre genealogique entierement depuis la racine
   procedure commande_18_afficher_entierement(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      -- R1 : On verifie si l'arbre est vide
      if arbre_genealogique.estVide(F_Arbre) then
         -- R2 : S'il est vide, on l'indique
         Put_Line("L'arbre est vide : rien a afficher");
      else
         -- R2 : Sinon, on affiche entierement l'arbre par l'appel de la procedure "afficherArbreGen"
         Put_Line("***********************************************");
         afficherArbreGen(F_Arbre, 0);
         New_Line;
         Put_Line("***********************************************");
      end if;
   end commande_18_afficher_entierement;
   
   -- R0 : Fabrique un arbre prerempli
   procedure commande_19_creer_arbre_prerempli(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin; -- Un arbre genealogique de type T_Arbre_Bin qui va nous servir d'intermediaire
      informations : individu_Integer.PT_Informations; -- Un pointeur vers les informations de l'individu qui va servir d'intermediaire
      valider : Integer; -- Un Integer qui permet de verifier la decision de l'utilisateur
   begin
      -- R1 : Si l'arbre n'est pas vide
      if not arbre_genealogique.estVide(F_Arbre) then
         loop
            -- R2 : On indique a l'utilisateur qu'un arbre existe deja et on verifie s'il veut ecrive par dessus l'ancien arbre ou non
            Put_Line("Un arbre existe deja. Souhaitez-vous tout de meme reecrire par dessus ?");
            Put_Line("  OUI => Tapez 1");
            Put_Line("  NON => Tapez 2");
            New_Line;
            Get(valider);
            -- R2 : Si "valider" n'est pas egal a 1 ou 2
            if valider < 1 or valider > 2 then
               New_Line;
               -- R3 : On demande de saisir une valeur correcte
               Put_Line("Veuillez saisir '1' ou '2' pour confirmer votre decision");
               New_Line;
            else
               -- R3 : On ne fait rien
               null;
            end if;
            exit when valider = 1 or valider = 2;
         end loop;
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
      -- R1 : Si l'arbre n'est pas vide et que l'utilisateur souhaite tout de meme l'ecraser ou si l'arbre est vide
      if (not arbre_genealogique.estVide(F_Arbre) and valider = 1) or arbre_genealogique.estVide(F_Arbre)  then
         -- R2 : On fabrique l'arbre que l'on va preremplir
         -- R3 : On fabrique un pointeur d'informations du premier individu
         informations := individu_Integer.creerInformations(To_Unbounded_String("Rodriguez"),
                                                            To_Unbounded_String("Diego"),
                                                            To_Unbounded_String("M"),
                                                            To_Unbounded_String("08/11/1999"),
                                                            To_Unbounded_String("n/a"),
                                                            To_Unbounded_String("11 rue Andre Mercadier, 31000 Toulouse"));
         -- R3 : On cree cet individu
         creer(F_Arbre, individu_Integer.creerIndividu(1, informations));
         -- R3 : On fabrique un pointeur d'informations du second individu
         informations := individu_Integer.creerInformations(To_Unbounded_String("Rodriguez"),
                                                            To_Unbounded_String("Thierry"),
                                                            To_Unbounded_String("M"),
                                                            To_Unbounded_String("04/10/1964"),
                                                            To_Unbounded_String("n/a"),
                                                            To_Unbounded_String("5 rue Olympe de Gouges, 65600 Semeac"));
         -- R3 : On cree cet individu
         ajouterPere(F_Arbre, individu_Integer.creerIndividu(10, informations));
         -- R3 : On fabrique un pointeur d'informations du troisieme individu
         informations := individu_Integer.creerInformations(To_Unbounded_String("Sandra"),
                                                            To_Unbounded_String("Rodriguez"),
                                                            To_Unbounded_String("F"),
                                                            To_Unbounded_String("29/10/1969"),
                                                            To_Unbounded_String("n/a"),
                                                            To_Unbounded_String("Avenue des Pyrenees, 65000 Tarbes"));
         -- R3 : On cree cet individu
         ajouterMere(F_Arbre, individu_Integer.creerIndividu(11, informations));

         -- R3 : On se deplace vers le sous-arbre gauche de l'arbre racine pour creer la suite des individus
         arbre := arbre_genealogique.getSousArbreGauche(F_Arbre);
         -- R3 : On fabrique un pointeur d'informations du quatrieme individu
         informations := individu_Integer.creerInformations(To_Unbounded_String("Dupont"),
                                                            To_Unbounded_String("Gerard"),
                                                            To_Unbounded_String("M"),
                                                            To_Unbounded_String("18/01/1972"),
                                                            To_Unbounded_String("14/12/2012"),
                                                            To_Unbounded_String("14 rue du Platane, 31000 Toulouse"));
         -- R3 : On cree cet individu
         ajouterPere(arbre, individu_Integer.creerIndividu(20, informations));

         -- A partir de la, j'ai decide de ne plus creer un enregistrement d'informations car ça me prendrait trop de lignes de code
         -- Et ce n'est pas la peine de remplir totalement l'arbre, l'utilisateur aura le plaisir de le faire lui-meme
         -- Les individus sans informations verront leurs informations sous la forme "(n/a,n/a,n/a,n/a,n/a,n/a)"
         
         -- R3 : On se deplace vers le sous-arbre gauche de l'individu cree puis on lui ajoute un pere puis une mere
         arbre := arbre_genealogique.getSousArbreGauche(arbre);
         ajouterPere(arbre, individu_Integer.creerIndividu_Id(30));
         ajouterMere(arbre, individu_Integer.creerIndividu_Id(31));

         -- R3 : On se deplace vers le sous-arbre droit de l'arbre racine puis on lui ajoute un pere puis une mere
         arbre := arbre_genealogique.getSousArbreDroit(F_Arbre);
         ajouterPere(arbre, individu_Integer.creerIndividu_Id(21));
         ajouterMere(arbre, individu_Integer.creerIndividu_Id(22));

         -- R3 : On se deplace vers le sous-arbre gauche du noeud cree precedemment et on lui ajoute un pere
         arbre := arbre_genealogique.getSousArbreGauche(arbre);
         ajouterPere(arbre, individu_Integer.creerIndividu_Id(32));

         -- R3 : On se deplace vers le sous-arbre gauche du noeud cree precedemment et on lui ajoute une mere
         arbre := arbre_genealogique.getSousArbreGauche(arbre);
         ajouterMere(arbre, individu_Integer.creerIndividu_Id(40));

         -- R3 : On se deplace vers le sous-arbre droit du noeud cree precedemment et on lui ajoute une mere puis un pere
         arbre := arbre_genealogique.getSousArbreDroit(arbre);
         ajouterMere(arbre, individu_Integer.creerIndividu_Id(51));
         ajouterPere(arbre, individu_Integer.creerIndividu_Id(50));

         -- R3 : On affiche entierement l'arbre par l'appel de la procedure "commande_18_afficher_entierement"
         Put_Line("Arbre prerempli cree ! Voici l'arbre :");
         New_Line;
         commande_18_afficher_entierement(F_Arbre);
      else
         -- R2 : Sinon, on ne fait rien
         null;
      end if;
   end commande_19_creer_arbre_prerempli;
   
   -- R0 : Traitement du choix de l'utilisateur par rapport au menu
   procedure traitement_choix(F_Choix : in Integer; F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
   begin
      -- R1 : En fonction de la valeur choix du parametre d'entree "F_Choix", on execute une des 19 methodes
      case F_Choix is
         when 1 => commande_1_creer_arbre(F_arbre);
         when 2 => commande_2_ajouter_pere(F_arbre);
         when 3 => commande_3_ajouter_mere(F_arbre);
         when 4 => commande_4_nombre_ancetres(F_arbre);
         when 5 => commande_5_identifier_ancetres(F_arbre);
         when 6 => commande_6_ensemble_ancetres(F_arbre);
         when 7 => commande_7_identifier_descendant(F_Arbre);
         when 8 => commande_8_ensemble_descendants(F_Arbre);
         when 9 => commande_9_afficher(F_Arbre);
         when 10 => commande_10_supprimer_branche(F_Arbre);
         when 11 => commande_11_modifier_individu(F_Arbre);
         when 12 => commande_12_modifier_totalement_individu(F_Arbre);
         when 13 => commande_13_aucun_parent_connu(F_Arbre);
         when 14 => commande_14_un_parent_connu(F_Arbre);
         when 15 => commande_15_deux_parents_connus(F_Arbre);
         when 16 => commande_16_identifier_ancetre_paternel(F_Arbre);
         when 17 => commande_17_identifier_ancetre_maternel(F_Arbre);
         when 18 => commande_18_afficher_entierement(F_Arbre);
         when 19 => commande_19_creer_arbre_prerempli(F_Arbre);
         when 0 => null;
            
         when others => Put_Line("/!\ Veuillez indiquer votre choix avec un nombre entre 0 et 19 inclus /!\");
      end case;
      -- R1 : Si l'exception arbre_null est levee, on affiche un message
   exception
      when arbre_genealogique.arbre_null =>
         New_Line;
         Put_Line("L'arbre recherche n'existe pas, il est null !");
         New_Line;
         -- R1 : Si l'exception element_absent est levee, on affiche un message
      when arbre_genealogique.element_absent =>
         New_Line;
         Put_Line("L'identifiant indique ne correspond a aucun individu !");
         New_Line;
         -- R1 : Si l'exception emplacement_invalide est levee, on affiche un message
      when arbre_genealogique.emplacement_invalide =>
         New_Line;
         Put_Line("L'arbre concerne possede deja le sous-arbre que vous voulez lui ajouter !");
         New_Line;
         -- R1 : Si l'exception pas_ancetre est levee, on affiche un message
      when pas_ancetre =>
         New_Line;
         Put_Line("Mettez une generation superieure a 0 pour trouver un ancetre ! (0 = lui-meme)");
         New_Line;
         -- R1 : Si l'exception pas_descendant est levee, on affiche un message
      when pas_descendant =>
         New_Line;
         Put_Line("Mettez une generation superieure a 0 pour trouver un descendant ! (0 = lui-meme)");
         New_Line;
   end traitement_choix;
   
   -- R0 : Traitement principal qui permet a l'utilisateur de manipuler l'arbre tant qu'il ne quitte pas le programme
   procedure manipulation_arbre_gen(F_arbre : in out arbre_genealogique.T_Arbre_Bin) is
      choix : Integer; -- Le choix que l'utilisateur devra faire de type Integer
      afficher_menu : Integer; -- Un Integer qui permettra de verifier si l'utilisateur veut ou pas afficher le menu
      -- J'ai fait le choix de ne pas afficher le menu a chaque fois pour permettre a l'utilisateur de bien voir le resultat
      -- De la procedure qu'il a appele
   begin
      loop
         loop
            -- R1 : On demande a l'utilisateur s'il veut ou pas afficher le menu
            New_Line;
            New_Line;
            Put_Line("------------------------------------------------------");
            Put_Line("Etes-vous d'accord pour afficher le menu ?");
            Put_Line("  OUI => Tapez 1");
            New_Line;
            -- R1 : On recupere son choix, et s'il vaut 1
            Get(afficher_menu);
            exit when afficher_menu = 1;
         end loop;
         if afficher_menu = 1 then
            -- R2 : Alors on affiche le menu
            afficherMenu;
         else
            -- R2 : Sinon, on ne fait rien
            null;
         end if;
         -- R1 : On recupere le choix du menu que l'utilisateur souhaite effectuer
         Get(choix);
         -- R1 : On verifie que ce choix se situe bien entre 0 et 19 inclus
         if choix < 0 or choix > 19 then
            -- R2 : Si ce n'est pas le cas, alors on redemande en boucle le choix de l'utilisateur
            New_Line;
            Put_Line("              /!\ Veuillez saisir un choix entre 0 et 19 inclus /!\");
            New_Line;
         else
            -- R2 : Sinon, on ne fait rien
            null;
         end if;
         exit when choix >= 0 and choix < 20;
      end loop;
      New_Line;
      -- R1 : On appelle la procedure "traitement_choix" afin de faire une action sur l'arbre genealogique en fonction du choix saisi par l'utilisateur
      traitement_choix(choix, F_arbre);
      -- R1 : Si le choix n'est pas 0
      if choix /= 0 then
         -- R2 : On appelle recursivement "manipulation_arbre_gen" pour que ça relance la procedure principale apres avoir effectue le traitement du choix
         manipulation_arbre_gen(F_arbre);
      else
         -- R2 : Le programme est termine, on affiche les credits
         New_Line;
         Put_Line("----------------------------------------------------------------------------------------------");
         Put_Line("          Ce programme a ete entierement realise par Diego Rodriguez");
         Put_Line("                        Methodologie de programmation");
         Put_Line("                           ENSEEIHT, Toulouse, 2021");
         New_Line;
         Put_Line("Fin du programme, Merci");
         New_Line;
      end if;
      -- R2 : S'il y a n'importe quelle exception que je n'englobe pas, comme par exemple la saisie d'un caractere a la place d'un nombre
      -- Alors on affiche qu'une erreur est survenue
   exception
      when others =>
         New_Line;
         Put_Line("Une erreur est survenue. Fermeture du programe !");
         New_Line;
   end manipulation_arbre_gen;

end P_Menu;
