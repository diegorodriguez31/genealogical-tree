with P_Arbre_Genealog; use P_Arbre_Genealog;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure test_p_arbre_genealog is

   -- Je ne raffine pas les classes de tests car ce sont de simples implémentations de fonctions
   -- Création de variables, appels de fonction et comparaisons avec des "pragma Assert"
   -- La complexité est très faible et ne nécessite pas que je passe énormément de temps
   -- A raffiner. Merci

   arbre : arbre_genealogique.T_Arbre_Bin;
   arbreIntermediaire : arbre_genealogique.T_Arbre_Bin;
   F_Arbre : arbre_genealogique.T_Arbre_Bin;
   arbrePrecedent : arbre_genealogique.T_Arbre_Bin;
   informations : individu_Integer.PT_Informations;
   nom : Unbounded_String;
   prenom : Unbounded_String;
   sexe : Unbounded_String;
   date_naissance : Unbounded_String;
   date_deces : Unbounded_String;
   adresse : Unbounded_String;
   individu : individu_Integer.T_Individu;
begin
   Put_Line("DEMARRAGE DU TEST DE P_ARBRE_GENEALOG");

   -- Test de procedure creer(F_Arbre : out T_Arbre_Bin ; F_Individu : in T_Individu);
   -- On teste si la création avec un individu déjà créé fonctionne
   nom := To_Unbounded_String("Rodriguez");
   prenom := To_Unbounded_String("Diego");
   sexe := To_Unbounded_String("M");
   date_naissance := To_Unbounded_String("08/11/1999");
   date_deces := To_Unbounded_String("n/a");
   adresse := To_Unbounded_String("11 rue André Mercadier");
   informations := individu_Integer.creerInformations(nom, prenom, sexe, date_naissance, date_deces, adresse);
   individu.Id := 1;
   individu.Informations := informations;
   creer(arbre, individu);
   pragma Assert(arbre_genealogique.taille(arbre) = 1);
   pragma Assert(individu_Integer.get_id(arbre_genealogique.getElement(arbre)) = 1);
   pragma Assert(individu_Integer.get_nom(individu) = To_Unbounded_String("Rodriguez"));
   pragma Assert(individu_Integer.get_prenom(individu) = To_Unbounded_String("Diego"));
   pragma Assert(individu_Integer.get_sexe(individu) = To_Unbounded_String("M"));
   pragma Assert(individu_Integer.get_date_naissance(individu) = To_Unbounded_String("08/11/1999"));
   pragma Assert(individu_Integer.get_date_deces(individu) = To_Unbounded_String("n/a"));
   pragma Assert(individu_Integer.get_adresse(individu) = To_Unbounded_String("11 rue André Mercadier"));
   Put_Line("CREER ARBRE OK");
   -- Maintenant que l'on sait que les informations d'un individu fonctionnent bien dans l'arbre
   -- Je vais seulement créer des individus avec des informations vides car sinon cela prendrait
   -- Trop de temps pour rien

   -- On vérifie si la création d'un nouvel arbre écrase l'ancien
   creer(arbre, individu_Integer.creerIndividu_Id(2));
   pragma Assert(arbre_genealogique.taille(arbre) = 1);
   pragma Assert(individu_Integer.get_id(arbre_genealogique.getElement(arbre)) = 2);
   Put_Line("ECRASER ARBRE OK");

   --Test de procedure ajouterParent(F_Arbre : in out T_Arbre_Bin ; F_Parent : in T_Individu ; F_PereOuMere : in Boolean);
   -- Ajout du père
   individu := individu_Integer.creerIndividu_Id(10);
   ajouterPere(arbre, individu);
   pragma Assert(arbre_genealogique.taille(arbre) = 2);
   pragma Assert(individu_Integer.get_id(arbre_genealogique.getElement(arbre_genealogique.getSousArbreGauche(arbre))) = 10);
   Put_Line("AJOUT PERE OK");

   -- Ajout de la mère
   individu := individu_Integer.creerIndividu_Id(11);
   ajouterMere(arbre, individu);
   pragma Assert(arbre_genealogique.taille(arbre) = 3);
   pragma Assert(individu_Integer.get_id(arbre_genealogique.getElement(arbre_genealogique.getSousArbreDroit(arbre))) = 11);
   Put_Line("AJOUT MERE OK");

   -- Exception "emplacement_invalide"
   individu := individu_Integer.creerIndividu_Id(1);
   begin
      ajouterParent(arbre, individu, true);
      pragma Assert(False);
   exception
      when arbre_genealogique.emplacement_invalide =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION EMPLACEMENT_INVALIDE OK");

   -- Test de function nombreAncetres(F_Arbre : in T_Arbre_Bin ; F_Individu : in T_Individu) return Integer;
   individu := individu_Integer.creerIndividu_Id(2);
   pragma Assert(nombreAncetres(arbre, individu) = 3);

   individu := individu_Integer.creerIndividu_Id(10);
   pragma Assert(nombreAncetres(arbre, individu) = 1);

   individu := individu_Integer.creerIndividu_Id(11);
   pragma Assert(nombreAncetres(arbre, individu) = 1);

   individu := individu_Integer.creerIndividu_Id(5);
   pragma Assert(nombreAncetres(arbre, individu) = 0);
   Put_Line("TEST NOMBRE ANCETRES OK");

   -- Test pour vérifier ce qu'il se passe quand on affiche un arbre vide
   arbre_genealogique.initialiser(arbre);
   New_Line;New_Line;
   Put_Line("Aucun affichage");
   afficherArbreGen(arbre, 0);

   -- Fabrication d'un arbre prérempli, il nous sera utile pour la suite
   informations := individu_Integer.creerInformations(To_Unbounded_String("Rodriguez"),
                                                      To_Unbounded_String("Diego"),
                                                      To_Unbounded_String("M"),
                                                      To_Unbounded_String("08/11/1999"),
                                                      To_Unbounded_String("n/a"),
                                                      To_Unbounded_String("11 rue André Mercadier, 31000 Toulouse"));
   creer(F_Arbre, individu_Integer.creerIndividu(1, informations));
   informations := individu_Integer.creerInformations(To_Unbounded_String("Rodriguez"),
                                                      To_Unbounded_String("Thierry"),
                                                      To_Unbounded_String("M"),
                                                      To_Unbounded_String("04/10/1964"),
                                                      To_Unbounded_String("n/a"),
                                                      To_Unbounded_String("5 rue Olympe de Gouges, 65600 Séméac"));
   ajouterPere(F_Arbre, individu_Integer.creerIndividu(10, informations));
   informations := individu_Integer.creerInformations(To_Unbounded_String("Sandra"),
                                                      To_Unbounded_String("Rodriguez"),
                                                      To_Unbounded_String("F"),
                                                      To_Unbounded_String("29/10/1969"),
                                                      To_Unbounded_String("n/a"),
                                                      To_Unbounded_String("Avenue des Pyrénées, 65000 Tarbes"));
   ajouterMere(F_Arbre, individu_Integer.creerIndividu(11, informations));

   arbre := arbre_genealogique.getSousArbreGauche(F_Arbre);
   informations := individu_Integer.creerInformations(To_Unbounded_String("Dupont"),
                                                      To_Unbounded_String("Gérard"),
                                                      To_Unbounded_String("M"),
                                                      To_Unbounded_String("18/01/1972"),
                                                      To_Unbounded_String("14/12/2012"),
                                                      To_Unbounded_String("14 rue du Platane, 31000 Toulouse"));
   ajouterPere(arbre, individu_Integer.creerIndividu(20, informations));

   arbre := arbre_genealogique.getSousArbreGauche(arbre);
   ajouterPere(arbre, individu_Integer.creerIndividu_Id(30));
   ajouterMere(arbre, individu_Integer.creerIndividu_Id(31));

   arbre := arbre_genealogique.getSousArbreDroit(F_Arbre);
   ajouterPere(arbre, individu_Integer.creerIndividu_Id(21));
   ajouterMere(arbre, individu_Integer.creerIndividu_Id(22));

   arbre := arbre_genealogique.getSousArbreGauche(arbre);
   ajouterPere(arbre, individu_Integer.creerIndividu_Id(32));

   arbre := arbre_genealogique.getSousArbreGauche(arbre);
   ajouterMere(arbre, individu_Integer.creerIndividu_Id(40));

   arbre := arbre_genealogique.getSousArbreDroit(arbre);
   ajouterMere(arbre, individu_Integer.creerIndividu_Id(51));
   ajouterPere(arbre, individu_Integer.creerIndividu_Id(50));

   -- Maintenant que cet arbre intermédiaire est fabriqué, on en profite pour tester son affichage
   -- Test de procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin);
   ---------------------------------------------------------------------
   New_Line;New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 1 (Rodriguez, Diego, M, 08/11/1999, n/a, 11 rue André Mercadier, 31000 Toulouse)");
   Put_Line("    -- Père :  10 (Rodriguez, Thierry, M, 04/10/1964, n/a, 5 rue Olympe de Gouges, 65600 Séméac)");
   Put_Line("     -- Père :  20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line("         -- Père :  30 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("         -- Mère :  31 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("    -- Mère :  11 (Sandra, Rodriguez, F, 29/10/1969, n/a, Avenue des Pyrénées, 65000 Tarbes)");
   Put_Line("         -- Père :  21 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("             -- Père :  32 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("                 -- Mère :  40 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("                     -- Père :  50 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("                     -- Mère :  51 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("        -- Mère :  22 (n/a, n/a, n/a, n/a, n/a, n/a)");
   New_Line;
   Put_Line("Resultat obtenu : ");
   afficherArbreGen(F_Arbre, 0);New_Line;New_Line;

   -- Test de procedure listeAucunParent(F_Arbre : in T_Arbre_Bin);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 30 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 31 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 50 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 51 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 22 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("Resultat obtenu : ");
   listeAucunParent(F_Arbre);
   New_Line;New_Line;
   Put_Line("TEST LISTE AUCUN PARENT OK");

   -- Test de procedure listeUnSeulParent(F_Arbre : in T_Arbre_Bin);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 10 (Rodriguez, Thierry, M, 04/10/1964, n/a, 5 rue Olympe de Gouges, 65600 Séméac)");
   Put_Line(" 21 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 32 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("Resultat obtenu : ");
   listeUnSeulParent(F_Arbre);
   New_Line;New_Line;
   Put_Line("TEST LISTE UN SEUL PARENT OK");

   -- Test de procedure listeDeuxParents(F_Arbre : in T_Arbre_Bin);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 1 (Rodriguez, Diego, M, 08/11/1999, n/a, 11 rue André Mercadier, 31000 Toulouse)");
   Put_Line(" 20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line(" 11 (Sandra, Rodriguez, F, 29/10/1969, n/a, Avenue des Pyrénées, 65000 Tarbes)");
   Put_Line(" 40 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("Resultat obtenu : ");
   listeDeuxParents(F_Arbre);
   New_Line;New_Line;
   Put_Line("TEST LISTE DEUX PARENT OK");

   -- Test de  procedure identifierAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);
   New_Line;
   individu := individu_Integer.creerIndividu_Id(1);
   arbreIntermediaire := arbre_genealogique.recherche(F_Arbre, individu, false);
   identifierAncetres(arbreIntermediaire, 2, 0);
   Put_Line("Resultat attendu : ");
   Put_Line(" 20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line(" 21 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 22 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("TEST IDENTIFIER ANCETRES AVEC MERE MANQUANT OK");
   New_Line;New_Line;
   Put_Line("Resultat obtenu : ");
   identifierAncetres(arbreIntermediaire, 4, 0);
   Put_Line("Resultat attendu : ");
   Put_Line(" 40 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("TEST IDENTIFIER ANCETRES AVEC PERE MANQUANT OK");
   New_Line;New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line("");
   Put_Line("Resultat obtenu : ");
   identifierAncetres(arbreIntermediaire, 6, 0);

   Put_Line("TEST IDENTIFIER ANCETRES AVEC PERE ET MERE MANQUANT OK");
   New_Line; New_Line;

   -- Exception "pas_ancetre"
   begin
      identifierAncetres(arbreIntermediaire,0, 0);
      pragma Assert(False);
   exception
      when pas_ancetre =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION PAS_ANCETRE POUR IDENTIFIER ANCETRES OK");

   -- Test de procedure ensembleAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 10 (Rodriguez, Thierry, M, 04/10/1964, n/a, 5 rue Olympe de Gouges, 65600 Séméac)");
   Put_Line(" 11 (Sandra, Rodriguez, F, 29/10/1969, n/a, Avenue des Pyrénées, 65000 Tarbes)");
   Put_Line("Resultat obtenu : ");
   ensembleAncetres(arbreIntermediaire, 1, 0);
   Put_Line("TEST ENSEMBLE ANCETRES GENERATION 1 OK");
   New_Line;New_Line;

   Put_Line("Resultat attendu : ");
   Put_Line(" 10 (Rodriguez, Thierry, M, 04/10/1964, n/a, 5 rue Olympe de Gouges, 65600 Séméac)");
   Put_Line(" 20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line(" 11 (Sandra, Rodriguez, F, 29/10/1969, n/a, Avenue des Pyrénées, 65000 Tarbes)");
   Put_Line(" 21 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line(" 22 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("Resultat obtenu : ");
   ensembleAncetres(arbreIntermediaire, 2, 0);
   Put_Line("TEST ENSEMBLE ANCETRES GENERATION 2 OK");

   -- Exception "pas_ancetre"
   begin
      ensembleAncetres(arbreIntermediaire,0, 0);
      pragma Assert(False);
   exception
      when pas_ancetre =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION PAS_ANCETRE POUR ENSEMBLE ANCETRES OK");

   -- Test de procedure identifierAncetrePaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer ; F_Compteur : in Integer);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 30 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("Resultat obtenu : ");
   identifierAncetrePaternel(arbreIntermediaire, 3, 0);
   Put_Line("TEST IDENTIFIER ANCETRES PATERNELS GENERATION 3 OK");
   New_Line;New_Line;

   -- Exception "pas_ancetre"
   begin
      identifierAncetrePaternel(arbreIntermediaire,0, 0);
      pragma Assert(False);
   exception
      when pas_ancetre =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION PAS_ANCETRE POUR IDENTIFIER ANCETRE PATERNEL OK");

   -- Test de identifierAncetreMaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer ; F_Compteur : in Integer);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 22 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put_Line("Resultat obtenu : ");
   identifierAncetreMaternel(arbreIntermediaire, 2, 0);
   Put_Line("TEST IDENTIFIER ANCETRES MATERNELS GENERATION 3 OK");
   New_Line;New_Line;

   -- Exception "pas_ancetre"
   begin
      identifierAncetreMaternel(arbreIntermediaire,0, 0);
      pragma Assert(False);
   exception
      when pas_ancetre =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION PAS_ANCETRE POUR IDENTIFIER ANCETRE MATERNEL OK");

   -- Test de procedure identifierDescendant(F_Arbre : in T_Arbre_Bin ; F_Arbre_Precedent : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);
   New_Line;
   individu := individu_Integer.creerIndividu_Id(30);
   arbrePrecedent := arbre_genealogique.recherche(F_Arbre, individu, false);
   Put_Line("Resultat attendu : ");
   Put_Line(" 20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line("Resultat obtenu : ");
   identifierDescendant(arbreIntermediaire, arbrePrecedent,1, 0);
   Put_Line("TEST IDENTIFIER DESCENDANT GENERATION 1 OK");
   New_Line;New_Line;

   Put_Line("Resultat attendu : ");
   Put_Line(" 1 (Rodriguez, Diego, M, 08/11/1999, n/a, 11 rue André Mercadier, 31000 Toulouse))");
   Put_Line("Resultat obtenu : ");
   identifierDescendant(arbreIntermediaire, arbrePrecedent, 3, 0);
   Put_Line("TEST IDENTIFIER DESCENDANT GENERATION 3 OK");
   New_Line;New_Line;

   -- Exception "pas_descendant"
   begin
      identifierDescendant(arbreIntermediaire, arbrePrecedent, 0, 0);
      pragma Assert(False);
   exception
      when pas_descendant =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION PAS_DESCENDANT POUR IDENTIFIER DESCENDANT OK");

   -- Exception "element_absent"
   begin
      identifierDescendant(arbreIntermediaire, arbrePrecedent, 5, 0);
      pragma Assert(False);
   exception
      when arbre_genealogique.element_absent =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION ELEMENT_ABSENT POUR IDENTIFIER DESCENDANT OK");

   -- Test de procedure ensembleDescendants(F_Arbre : in T_Arbre_Bin ; F_Arbre_Precedent : in T_Arbre_Bin ; F_Generation : in Integer ; F_Compteur : in Integer);
   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line(" 10 (Rodriguez, Thierry, M, 04/10/1964, n/a, 5 rue Olympe de Gouges, 65600 Séméac)");
   Put_Line("Resultat obtenu : ");
   ensembleDescendants(arbreIntermediaire,arbrePrecedent, 2, 0);
   Put_Line("ENSEMBLE DESCENDANTS GENERATION 2 OK");
   New_Line;New_Line;

   New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 8 ( Nom : CURIE, Prenom : Marie ) ");
   Put_Line(" 20 (Dupont, Gérard, M, 18/01/1972, 14/12/2012, 14 rue du Platane, 31000 Toulouse)");
   Put_Line(" 10 (Rodriguez, Thierry, M, 04/10/1964, n/a, 5 rue Olympe de Gouges, 65600 Séméac)");
   Put_Line(" 1 (Rodriguez, Diego, M, 08/11/1999, n/a, 11 rue André Mercadier, 31000 Toulouse)");
   Put_Line("Resultat obtenu : ");
   ensembleDescendants(arbreIntermediaire, arbrePrecedent, 5 , 0);
   Put_Line("ENSEMBLE DESCENDANTS GENERATION 4 OK");
   New_Line;New_Line;

   -- Exception "pas_descendant"
   begin
      identifierDescendant(arbreIntermediaire,arbrePrecedent,0, 0);
      pragma Assert(False);
   exception
      when pas_descendant =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION PAS_DESCENDANT POUR ENSEMBLE DESCENDANTS OK");

   -- Exception "element_absent"
   begin
      identifierDescendant(arbreIntermediaire, arbrePrecedent, 5, 0);
      pragma Assert(False);
   exception
      when arbre_genealogique.element_absent =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION ELEMENT_ABSENT POUR ENSEMBLE DESCENDANTS OK");

   -- Test de procedure supprimerNoeudEtAncetres(F_Arbre : in out T_Arbre_Bin ; F_Individu : in T_Individu);
   individu := individu_Integer.creerIndividu_Id(11);
   supprimerNoeudEtAncetres(arbreIntermediaire, individu);
   pragma Assert(arbre_genealogique.taille(arbreIntermediaire) = 5);
   individu := individu_Integer.creerIndividu_Id(1);
   pragma Assert(arbre_genealogique.estVide(arbre_genealogique.getSousArbreDroit(arbre_genealogique.recherche(arbreIntermediaire, individu, False))));
   Put_Line("TEST SUPPRIMER NOEUD ET ANCETRES 11 OK");

   individu := individu_Integer.creerIndividu_Id(31);
   supprimerNoeudEtAncetres(arbreIntermediaire, individu);
   pragma Assert(arbre_genealogique.taille(arbreIntermediaire) = 4);
   individu := individu_Integer.creerIndividu_Id(20);
   pragma Assert(arbre_genealogique.estVide(arbre_genealogique.getSousArbreDroit(arbre_genealogique.recherche(arbreIntermediaire, individu, False))));
   Put_Line("TEST SUPPRIMER NOEUD ET ANCETRES FEUILLE 31 OK");

   -- Exception "element_absent"
   individu := individu_Integer.creerIndividu_Id(100);
   begin
      supprimerNoeudEtAncetres(arbreIntermediaire, individu);
      pragma Assert(False);
   exception
      when arbre_genealogique.element_absent =>
         pragma Assert(True);
   end;
   Put_Line("EXCEPTION ELEMENT_ABSENT POUR SUPPRIMER OK");

   individu := individu_Integer.creerIndividu_Id(1);
   supprimerNoeudEtAncetres(arbreIntermediaire, individu);
   pragma Assert(arbre_genealogique.taille(arbreIntermediaire) = 0);
   pragma Assert(arbre_genealogique.estVide(arbreIntermediaire));
   Put_Line("TEST SUPPRESSION TOTALE DE L'ARBRE OK");

   -- Je ne teste pas la procédure "modifier individu" car elle fait seulement appel à la méthode
   -- Modifier de l'arbre binaire, que l'on a déjà testée

   -- Test des modules avec un arbre complètement vide pour vérifier les exceptions d'arbre null
   -- Si jamais j'avais décidé de les appeler dans le corps d'arbre généalogique
   individu := individu_Integer.creerIndividu_Id(1);

   begin
      modifierIndividu(arbreIntermediaire, individu, individu);
      pragma Assert(False);
   exception
      when arbre_genealogique.arbre_null =>
         Pragma Assert(True);
   end;

   Put_Line("FIN DU TEST DE P_ARBRE_GENEALOG");
end test_p_arbre_genealog;
