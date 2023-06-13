with Ada.Text_IO; use Ada.Text_IO;
with P_Arbre_Bin;

procedure test_p_arbre_binaire is

   -- Cette classe de test ne represente pas à proprement parler les tests untitaires
   -- Mais elle represente les tests que nous avons fait lors du TP16 pour tester l'arbre binaire !
   -- JE N'AI PAS BEAUCOUP COMMENTE CETTE CLASSE CAR IL Y A PEU DE COMPLEXITE DANS LES TESTS ET LES AFFICHAGES
   -- SONT SUFFISANTS POUR TOUT COMPRENDRE. PAR CONTRE, LES AUTRES CLASSES SONT BIEN RAFFINNEES ET COMMENTEES

   -- Instanciation d'un arbre binaire
   package Arbre_Binaire is new P_Arbre_Bin(T_Element => Integer, egaux => "=");
   use Arbre_Binaire;

   -- Procedure pour afficher un arbre, je ne gère pas l'affichage pour voir si on est dans un sous-arbre gauche ou doirt
   procedure afficher(arbre : in T_Arbre_Bin)is
   begin
      if not estVide(arbre) then
         -- On appelle recursivement de manière prefixe le noeud, le sous-arbre gauche puis le sous-arbre droit
         Put(Integer'Image(getElement(arbre)));
         afficher(getSousArbreGauche(arbre));
         afficher(getSousArbreDroit(arbre));
      else
         null;
      end if;
   end;

   a, b : T_Arbre_Bin; -- Deux arbres binaries
begin
   New_Line;
   initialiser(a);
   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST ARBRE VIDE");
   if estVide(a) then
      Put("Taille de l'arbre : ");
      Put(Integer'Image(taille(a))); New_Line;
      Put("Taille attendue : ");
      Put_Line("0");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST AJOUTER 0 DANS L'ARBRE A DROITE");
   inserer(a, 0, true);
   if not estVide(a) then
      Put("Arbre attendu : 0"); New_Line;
      Put("Affichage de l'arbre : ");
      afficher(a); New_Line; New_Line;
      Put("Taille de l'arbre : ");
      Put(Integer'Image(taille(a))); New_Line;
      Put("Taille attendue : ");
      Put_Line("1");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST AJOUTER 4 DANS L'ARBRE A GAUCHE");
   inserer(a, 4, false);
   if not estVide(a) then
      Put("Arbre attendu : 0 4"); New_Line;
      Put("Affichage de l'arbre : ");
      afficher(a); New_Line;
      Put("Taille de l'arbre : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put("Taille attendue : ");
      Put_Line("2");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST AJOUTER 5 DANS L'ARBRE A DROITE");
   inserer(a, 5, true);
   if not estVide(a) then
      Put("Arbre attendu : 0 4 5"); New_Line;
      Put("Affichage de l'arbre : ");
      afficher(a); New_Line;
      Put("Taille de l'arbre : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put("Taille attendue : ");
      Put_Line("3");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST RECHERCHE NOEUD DANS SOUS-ARBRE GAUCHE");
   b := recherche(a, 4, false);
   if not estVide(b) then
      Put("Arbre attendu pour b : 4"); New_Line;
      Put("Affichage de l'arbre b : ");
      afficher(b); New_Line;
      Put("Taille de l'arbre b: ");
      Put(Integer'Image(taille(b)));New_Line;
      Put("Taille attendue pour b : ");
      Put_Line("1");
      Put("Arbre attendu pour a: 0 4 5"); New_Line;
      Put("Affichage de l'arbre a : ");
      afficher(a); New_Line;
      Put("Taille de l'arbre a : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put_Line("Taille attendue pour a : 3");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST RECHERCHE SUR-NOEUD DANS SOUS-ARBRE GAUCHE");
   b := recherche(a, 4, true);
   if not estVide(b) then
      Put("Arbre attendu pour b : 0 4 5"); New_Line;
      Put("Affichage de l'arbre b : ");
      afficher(b); New_Line;
      Put("Taille de l'arbre b : ");
      Put(Integer'Image(taille(b)));New_Line;
      Put("Taille attendue pour b : 3");New_Line;
      Put("Arbre attendu pour a : 0 4 5"); New_Line;
      Put("Affichage de l'arbre a : ");
      afficher(a); New_Line;
      Put("Taille de l'arbre a : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put_Line("Taille attendue pour a : 3");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST RECHERCHE NOEUD DANS SOUS-ARBRE DROIT");
   b := recherche(a, 5, false);
   if not estVide(b) then
      Put("Arbre attendu pour b : 5"); New_Line;
      Put("Affichage de l'arbre b : ");
      afficher(b); New_Line;
      Put("Taille de l'arbre b : ");
      Put(Integer'Image(taille(b)));New_Line;
      Put("Taille attendue pour b : 1");New_Line;
      Put("Arbre attendu pour a : 0 4 5"); New_Line;
      Put("Affichage de l'arbre a : ");
      afficher(a); New_Line;
      Put("Taille de l'arbre a : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put_Line("Taille attendue pour a : 3");
   else
      Put_Line("Valeur non trouvee");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST EXCEPTION ELEMENT ABSENT QUAND ON RECHERCHE LE SUR-NOEUD DE LA RACINE");
   begin
      b := recherche(a, 0, true);
   exception
      when element_absent => Put_Line("Ok");
   end;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST RENVOIE NULL QUAND ON RECHERCHE UN ELEMENT QUI N'EXISTE PAS");
   b := recherche(a, 8, false);
   if estVide(b) then
      Put_Line("Ok");
   end if;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST MODIFICATION ELEMENT 4 PAR 8");
   modifier(a, 4, 8);
   if not estVide(a) then
      Put("Arbre attendu : 0 8 5"); New_Line;
      Put("Affichage de l'arbre : ");
      afficher(a); New_Line;
      Put("Taille de l'arbre : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put("Taille attendue : 3");
   end if;New_Line;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST EXCEPTION EMPLACEMENT_INVALIDE QUAND ON ESSAIE D'AJOUTER A DROITE DE LA RACINE (IL EXISTE DEJA UN ELEMENT)");
   begin
      inserer(a, 8, true);
   exception
      when emplacement_invalide => Put_Line("Ok");
   end;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST EXCEPTION EMPLACEMENT_INVALIDE QUAND ON ESSAIE D'AJOUTER A GAUCHE DE LA RACINE (IL EXISTE DEJA UN ELEMENT)");
   begin
      inserer(a, 7, false);
   exception
      when emplacement_invalide => Put_Line("Ok");
   end;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST SUPPRIMER LE 8 DE L'ARBRE");
   supprimer(a, 8);
   Put("Arbre attendu : 0 5"); New_Line;
   Put("Affichage de l'arbre : ");
   afficher(a); New_Line; New_Line;
   Put("Taille de l'arbre : ");
   Put_Line(Integer'Image(taille(a)));
   Put("Taille attendue : 2 ");
   New_Line;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST EXCEPTION ELEMENT_ABSENT QUAND ON VEUT SUPPRIMER UN ELEMENT QUI N'EXISTE PAS");
   begin
      supprimer(a, 10);
   exception
      when element_absent => Put_Line("Ok");
   end;New_Line;

   Put_Line("//////////////////////////////////////////////////////////");
   Put_Line("TEST SUPPRESSION DU NOEUD RACINE");
   supprimer(a, 0);
   if estVide(a) then
      Put_Line("Arbre correctement supprime");
      Put("Taille de l'arbre : ");
      Put(Integer'Image(taille(a)));New_Line;
      Put("Taille attendue : 0");
   end if;New_Line;New_Line;

end test_p_arbre_binaire;
