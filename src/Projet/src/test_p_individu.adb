with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with P_Individu;

procedure test_p_individu is

   -- Instanciation d'un individu avec l'identifiant de type Integer
   package individu_Integer is new P_Individu(T_Identifiant => Integer);
   use individu_Integer;

   -- Cette procédure permet d'afficher l'identifiant d'un individu avec l'id de type Int
   -- Car j'ai choisi d'implémenter individu_Integer et non individu_String
   procedure afficherId_Integer(F_individu : in individu_Integer.T_Individu) is
   begin
      Put(Integer'Image(F_individu.id));
   end afficherId_Integer;

   -- Instanciation générique de la méthode afficherIndividu qui va afficher l'individu d'un arbre généalogique
   -- Cela provient de la procedure "afficherindividuComplet" du package p_individu qui utilise de manière générique la méthode "afficherIndiv"
   -- Qui est ici remplacée par "afficherId_Integer" juste au dessus
   procedure afficherIndividu is new afficherIndividuComplet(afficherIndiv => afficherId_Integer);


   individu1, individu2 : T_Individu;
   informations1, informations2 : PT_Informations;
   id1, id2 : Integer;
   nom1, prenom1, nom2, prenom2, sexe1, sexe2, date_de_naissance1, date_de_naissance2 : Unbounded_String;
   date_de_deces1, date_de_deces2, adresse1, adresse2 : Unbounded_String;
   identifiant : Integer;

begin
   Put_Line("            DEMARRAGE DU TEST DU PACKAGE P_INDIVIDU");
   New_Line;

   -- Bien que je n'utilise pas beaucoup les setter et getter comme indiqué dans le rapport, je les teste quand même

   -- Test de procedure set_id(F_Individu : in out T_Individu ; F_Id : in T_Identifiant);
   individu1 := creerIndividu_Id(1);
   set_id(individu1, 2);
   pragma Assert(individu1.Id = 2);
   Put_Line("SET_ID OK");

   -- Test de function get_id(F_Individu : in T_Individu) return T_Identifiant
   identifiant := get_id(individu1);
   pragma Assert(identifiant = 2);
   Put_Line("GET_ID OK");

   -- Test de procedure set_nom(F_Individu : in out T_Individu ; F_Nom : in Unbounded_String);
   individu1 := creerIndividu_Id(1);
   set_nom(individu1, To_Unbounded_String("TestNOM"));
   pragma Assert(individu1.Informations.all.Nom =To_Unbounded_String("TestNOM"));
   Put_Line("SET_NOM OK");

   -- Test de function get_nom(F_Individu : in T_Individu) return Unbounded_String;
   nom1 := get_nom(individu1);
   pragma Assert(nom1 = To_Unbounded_String("TestNOM"));
   Put_Line("GET_NOM OK");

   -- Test de procedure set_prenom(F_Individu : in out T_Individu ; F_Prenom : in Unbounded_String);
   individu1 := creerIndividu_Id(1);
   set_prenom(individu1, To_Unbounded_String("TestPRENOM"));
   pragma Assert(individu1.Informations.all.Prenom =To_Unbounded_String("TestPRENOM"));
   Put_Line("SET_PRENOM OK");

   -- Test de function get_prenom(F_Individu : in T_Individu) return Unbounded_String;
   prenom1 := get_prenom(individu1);
   pragma Assert(prenom1 = To_Unbounded_String("TestPRENOM"));
   Put_Line("GET_PRENOM OK");

   -- Test de procedure set_sexe(F_Individu : in out T_Individu ; F_Sexe : in Unbounded_String);
   individu1 := creerIndividu_Id(1);
   set_sexe(individu1, To_Unbounded_String("TestSEXE"));
   pragma Assert(individu1.Informations.all.Sexe =To_Unbounded_String("TestSEXE"));
   Put_Line("SET_SEXE OK");

   -- Test de function get_sexe(F_Individu : in T_Individu) return Unbounded_String;
   sexe1 := get_sexe(individu1);
   pragma Assert(sexe1 = To_Unbounded_String("TestSEXE"));
   Put_Line("GET_SEXE OK");

   -- Test de procedure set_date_naissance(F_Individu : in out T_Individu ; F_Date_Naissance : in Unbounded_String);
   individu1 := creerIndividu_Id(1);
   set_date_naissance(individu1, To_Unbounded_String("TestDATE_NAISSANCE"));
   pragma Assert(individu1.Informations.all.Date_Naissance =To_Unbounded_String("TestDATE_NAISSANCE"));
   Put_Line("SET_DATE_NAISSANCE OK");

   -- Test de function get_date_naissance(F_Individu : in T_Individu) return Unbounded_String;
   date_de_naissance1 := get_date_naissance(individu1);
   pragma Assert(date_de_naissance1 = To_Unbounded_String("TestDATE_NAISSANCE"));
   Put_Line("GET_DATE_NAISSANCE OK");

   -- Test de procedure set_date_deces(F_Individu : in out T_Individu ; F_Date_Deces : in Unbounded_String);
   individu1 := creerIndividu_Id(1);
   set_date_deces(individu1, To_Unbounded_String("TestDATE_DECES"));
   pragma Assert(individu1.Informations.all.Date_Deces =To_Unbounded_String("TestDATE_DECES"));
   Put_Line("SET_DATE_DECES OK");

   -- Test de function get_date_deces(F_Individu : in T_Individu) return Unbounded_String;
   date_de_deces1 := get_date_deces(individu1);
   pragma Assert(date_de_deces1 = To_Unbounded_String("TestDATE_DECES"));
   Put_Line("GET_DATE_DECES OK");

   -- Test de procedure set_adresse(F_Individu : in out T_Individu ; F_Adresse : in Unbounded_String);
   individu1 := creerIndividu_Id(1);
   set_adresse(individu1, To_Unbounded_String("Test_ADRESSE"));
   pragma Assert(individu1.Informations.all.Adresse =To_Unbounded_String("Test_ADRESSE"));
   Put_Line("SET_ADRESSE OK");

   -- Test de function get_adresse(F_Individu : in T_Individu) return Unbounded_String;
   adresse1 := get_adresse(individu1);
   pragma Assert(adresse1 = To_Unbounded_String("Test_ADRESSE"));
   Put_Line("GET_ADRESSE OK");

   -- Test de function get_informations(F_Individu : in T_Individu) return PT_Informations;
   creerInformationsVides(individu1.Informations);
   informations1 := get_informations(individu1);
   pragma Assert(informations1 = individu1.Informations);
   Put_Line("GET_INFORMATIONS OK");

   --Test de function creerInformations(F_Nom : in Unbounded_String;
                            -- F_Prenom : in Unbounded_String;
                            --  F_Sexe : in Unbounded_String;
                            --  F_Date_Naissance : in Unbounded_String;
                            -- F_Date_Deces : in Unbounded_String;
                            --  F_Adresse : in Unbounded_String) return PT_Informations;
   nom1 := To_Unbounded_String("Rodriguez");
   prenom1 := To_Unbounded_String("Diego");
   sexe1 := To_Unbounded_String("M");
   date_de_naissance1 := To_Unbounded_String("08/11/1999");
   date_de_deces1 := To_Unbounded_String("");
   adresse1 := To_Unbounded_String("11 rue André Mercadier");

   informations1 := creerInformations(nom1, prenom1, sexe1, date_de_naissance1, date_de_deces1, adresse1);
   individu1.Informations := informations1;
   pragma Assert(To_Unbounded_String("Rodriguez") = get_nom(individu1));
   pragma Assert(To_Unbounded_String("Diego") = get_prenom(individu1));
   pragma Assert(To_Unbounded_String("M") = get_sexe(individu1));
   pragma Assert(To_Unbounded_String("08/11/1999") = get_date_naissance(individu1));
   pragma Assert(To_Unbounded_String("") = get_date_deces(individu1));
   pragma Assert(To_Unbounded_String("11 rue André Mercadier") = get_adresse(individu1));
   Put_Line("CREER INFORMATIONS PLEINES OK");

   nom2 := To_Unbounded_String("");
   prenom2 := To_Unbounded_String("");
   sexe2 := To_Unbounded_String("");
   date_de_naissance2 := To_Unbounded_String("");
   date_de_deces2 := To_Unbounded_String("");
   adresse2 := To_Unbounded_String("");

   informations2 := creerInformations(nom2, prenom2, sexe2, date_de_naissance2, date_de_deces2, adresse2);
   individu2.Informations := informations2;
   pragma Assert(To_Unbounded_String("") = get_nom(individu2));
   pragma Assert(To_Unbounded_String("") = get_prenom(individu2));
   pragma Assert(To_Unbounded_String("") = get_sexe(individu2));
   pragma Assert(To_Unbounded_String("") = get_date_naissance(individu2));
   pragma Assert(To_Unbounded_String("") = get_date_deces(individu2));
   pragma Assert(To_Unbounded_String("") = get_adresse(individu2));
   Put_Line("CREER INFORMATIONS VIDES OK");


   -- Test de function creerIndividu(F_Id : in T_Identifiant ; F_Informations : in PT_Informations) return T_Individu;
   individu1 := creerIndividu(1, informations1);
   pragma Assert(get_id(individu1) = 1);
   pragma Assert(get_informations(individu1) = informations1);
   Put_Line("CREER INDIVIDU AVEC ID ET INFORMATIONS OK");

   individu2 := creerIndividu(-10, informations2);
   pragma Assert(get_id(individu2) = -10);
   pragma Assert(get_informations(individu2) = informations2);
   Put_Line("CREER INDIVIDU AVEC ID NEGATIF ET INFORMATIONS OK");

   -- Test de function creerIndividu_Id(F_Id : in T_Identifiant) return T_Individu;
   individu1 := creerIndividu_Id(100);
   pragma Assert(get_id(individu1) = 100);
   Put_Line("CREER INDIVIDU AVEC ID SEULEMENT OK");


   -- Test de procedure afficherIndividuComplet(F_Individu : in T_Individu);
   -- Test de procedure afficherIndiv(F_Individu : in T_Individu);
   -- Test de procedure afficherInformations(F_Individu : in T_Individu);
   -- Ici, je test les trois procedures d'affichage en même temps car c'est trois procedures assez
   -- Simple qui peuvent se tester d'un coup avec les mêmes valeurs
   -- "afficherIndividuComplet" permet d'afficher les informations du pointeur d'informations de l'individu
   -- "afficherIndiv" permet d'afficher l'identifiant de l'individu
   -- Et "afficherIndividuComplet" utilise "afficherInformations" pour afficher les informations
   -- Je ne récupère pas les affichages dans un string, donc il faut vérifier manuellement si l'affichage est correct
   individu1 := creerIndividu(10, informations1);
   New_Line;
   Put_Line("TEST DE L'AFFICHAGE D'UN INDIVIDU : ");
   Put_Line("Resultat attendu : 10 (Rodriguez, Diego, M, 08/11/1999, n/a, 11 rue André Mercadier)");
   Put("Resultat obtenu : ");
   afficherIndividu(individu1);
   New_Line;
   Put_Line("TEST DE METTRE n/a POUR LES INFORMATIONS INCONNUES OK");
   Put_Line("AFFICHER INFORMATIONS OK");
   Put_Line("AFFICHER L'ID DE L'INDIVIDU OK");
   Put_Line("AFFICHER COMPLETEMENT L'INDIVIDU OK");
   Put_Line("TEST DE L'AFFICHAGE D'UN INDIVIDU OK");
   New_Line;

   -- Test de procedure creerInformationsVides(F_Informations : out PT_Informations);
   creerInformationsVides(informations1);
   individu1.Informations := informations1;
   pragma Assert(get_informations(individu1) = informations1);
   Put_Line("CREER INFORMATIONS VIDES OK");

   -- Test de function function estEgal(F_Id1 : in T_Identifiant ; F_Id2 : in T_Identifiant) return Boolean;
   individu1 := creerIndividu_Id(1);
   individu2 := creerIndividu_Id(1);
   id1 := get_id(individu1);
   id2 := get_id(individu2);
   pragma Assert(estEgal(id1, id2));
   pragma Assert(estEgal(id2, id1));
   individu2.Id := 10;
   id2 := get_id(individu2);
   pragma Assert(not estEgal(id1, id2));
   pragma Assert(not estEgal(id2, id1));
   Put_Line("EST EGAL OK (COMPARAISON DE DEUX ID)");

   -- Test de function estNul(F_Informations : in PT_Informations) return Boolean;
   informations1 := null;
   pragma Assert(estNul(informations1));
   pragma Assert(not estNul(informations2));
   Put_Line("EST NUL OK (VERIFIER SI LE POINTEUR D'INFORMATIONS EST NUL)");


   -- Tests divers d'affichage
   individu1 := creerIndividu(40, informations2);
   New_Line;
   Put_Line("TEST DE L'AFFICHAGE D'UN INDIVIDU SANS INFORMATIONS : ");
   Put_Line("Resultat attendu : 40 (n/a, n/a, n/a, n/a, n/a, n/a)");
   Put("Resultat obtenu : ");
   afficherIndividu(individu1);
   New_Line;
   Put_Line("TEST DE L'AFFICHAGE D'UN INDIVIDU SANS INFORMATIONS OK");
   New_Line;
   Put_Line("            FIN DU TEST DE P_INDIVIDU");
end test_p_individu;
