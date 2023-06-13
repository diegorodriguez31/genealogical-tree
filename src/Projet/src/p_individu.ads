with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

generic
   type T_Identifiant is private;

package P_Individu is

   -- J'ai décidé de ne pas mettre ces informations en privé car je suis le seul à manipuler l'arbre généalogique et le menu et à ainsi appeler
   -- Ces structures de données
   -- Je maîtrise totalement ces structures de données et je peux me permettre de les laisser en publique afin de les manipuler plus facilement
   
   -- L'enregistrement d'informations qui caractérise les informations d'un individu
   type T_Informations is record
      Nom : Unbounded_String; -- Nom
      Prenom : Unbounded_String; -- Prénom
      Sexe : Unbounded_String; -- Sexe (j'ai laissé le libre choix de mettre ce que l'on veut et pas seulement "M" ou "F"
      Date_Naissance : Unbounded_String; -- Date de naissance
      Date_Deces : Unbounded_String; -- Date de décès
      Adresse : Unbounded_String; -- Dernière adresse connue
   end record;
   
   -- Je choisis de pointer sur l'enregistrement des informations pour pouvoir mettre le pointeur à null s'il n'y a pas d'information
   type PT_Informations is access T_Informations;

   -- L'enregistrement d'un individu qui est caracérisé par son identifiant unique et par le pointeur vers l'enregistrement d'informations
   type T_Individu is record
      Id : T_Identifiant;
      Informations : PT_informations;
   end record;
   
   -- Getters / Setters
   
   -- PROCEDURE : set_id
   -- Sémantique : Met à jour l'identifiant d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer l'id
   --   F_Id : IN T_Identifiant, le nouvel id
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Id := F_Id
   -- Exceptions : Néant
   procedure set_id(F_Individu : in out T_Individu ; F_Id : in T_Identifiant);
   
   -------------------------
   
   -- FONCTION : get_id
   -- Sémantique : Récupère l'identifiant d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer l'id
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Id
   -- Retourne : T_Identifiant, l'identifiant
   -- Exceptions : Néant
   function get_id(F_Individu : in T_Individu) return T_Identifiant;
   
   -------------------------
   
   -- PROCEDURE : set_nom
   -- Sémantique : Met à jour le nom d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer le nom
   --   F_Nom : IN Unbounded_String, le nouveau nom
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Nom := F_Nom
   -- Exceptions : Néant
   procedure set_nom(F_Individu : in out T_Individu ; F_Nom : in Unbounded_String);
   
   -------------------------
   
   -- FONCTION : get_nom
   -- Sémantique : Récupère le nom d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer le nom
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations.all.Nom
   -- Retourne : Unbounded_String, le nom
   -- Exceptions : Néant
   function get_nom(F_Individu : in T_Individu) return Unbounded_String;

   -------------------------
   
   -- PROCEDURE : set_prenom
   -- Sémantique : Met à jour le prénom d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer le prénom
   --   F_Prenom : IN Unbounded_String, le nouveau prénom
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Informations.all.Prenom := F_Prenom
   -- Exceptions : Néant
   procedure set_prenom(F_Individu : in out T_Individu ; F_Prenom : in Unbounded_String);
   
   -------------------------
   
   -- FONCTION : get_prenom
   -- Sémantique : Récupère le prénom d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer le prénom
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations.all.Prenom
   -- Retourne : Unbounded_String, le prénom
   -- Exceptions : Néant
   function get_prenom(F_Individu : in T_Individu) return Unbounded_String;

   -------------------------
   
   -- PROCEDURE : set_sexe
   -- Sémantique : Met à jour le sexe d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer le sexe
   --   F_Sexe : IN Unbounded_String, le nouveau Sexe
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Informations.all.sexe := F_Sexe
   -- Exceptions : Néant
   procedure set_sexe(F_Individu : in out T_Individu ; F_Sexe : in Unbounded_String);
   
   -------------------------
   
   -- FONCTION : get_sexe
   -- Sémantique : Récupère le sexe d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer le sexe
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations.all.Sexe
   -- Retourne : Unbounded_String, le sexe
   -- Exceptions : Néant
   function get_sexe(F_Individu : in T_Individu) return Unbounded_String;

   -------------------------
   
   -- PROCEDURE : set_date_naissance
   -- Sémantique : Met à jour la date de naissance d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer la date de naissance
   --   F_Date_Naissance : IN Unbounded_String, la date de naissance
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Informations.all.Date_Naissance := F_Date_Naissance
   -- Exceptions : Néant
   procedure set_date_naissance(F_Individu : in out T_Individu ; F_Date_Naissance : in Unbounded_String);
   
   -------------------------
   
   -- FONCTION : get_date_naissance
   -- Sémantique : Récupère la date de naissance d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer la date de naissance
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations.all.Date_Naissance
   -- Retourne : Unbounded_String, la date de naissance
   -- Exceptions : Néant
   function get_date_naissance(F_Individu : in T_Individu) return Unbounded_String;

   -------------------------
   
   -- PROCEDURE : set_date_deces
   -- Sémantique : Met à jour la date de décès d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer la date de décès
   --   F_Date_Deces : IN Unbounded_String, la nouvelle date de décès
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Informations.all.Date_Naissance := F_Date_Deces
   -- Exceptions : Néant
   procedure set_date_deces(F_Individu : in out T_Individu ; F_Date_Deces : in Unbounded_String);
   
   -------------------------
   
   -- FONCTION : get_date_deces
   -- Sémantique : Récupère la date de décès d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer la date de décès
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations.all.Date_Deces
   -- Retourne : Unbounded_String, la date de décès
   -- Exceptions : Néant
   function get_date_deces(F_Individu : in T_Individu) return Unbounded_String;
   
   -------------------------
   
   -- PROCEDURE : set_adresse
   -- Sémantique : Met à jour l'adresse d'un individu
   -- Paramètres :
   --   F_Individu : IN OUT T_Individu, l'individu duquel on veut changer l'adresse
   --   F_Adresse : IN Unbounded_String, la nouvelle adresse
   -- Pré-conditions : Néant
   -- Post-conditions : F_Individu.Informations.all.Adresse := F_Adresse
   -- Exceptions : Néant
   procedure set_adresse(F_Individu : in out T_Individu ; F_Adresse : in Unbounded_String);
   
   -------------------------
   
   -- FONCTION : get_adresse
   -- Sémantique : Récupère l'adresse d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer l'adresse
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations.all.Adresse
   -- Retourne : Unbounded_String, l'adresse
   -- Exceptions : Néant
   function get_adresse(F_Individu : in T_Individu) return Unbounded_String;
   
   -------------------------
   -- Je n'ai pas mis de setter d'informations car je n'en ai pas eu besoin dans ma conception
   
   -- FONCTION : get_informations
   -- Sémantique : Récupère le pointeur d'informations d'un individu
   -- Paramètres :
   --   F_Individu : IN T_Individu, l'individu duquel on veut récupérer les informations
   -- Pré-conditions : Néant
   -- Post-conditions : renvoie F_Individu.Informations
   -- Retourne : Unbounded_String, l'adresse
   -- Exceptions : Néant
   function get_informations(F_Individu : in T_Individu) return PT_Informations;

   -------------------------
   
   -- FONCTION : creerIndividu
   -- Sémantique : Renvoie un Individu avec son Id et un enregistrement d'informations
   -- Paramètres :
   --   F_Id : IN T_Identifiant, l'identifiant de l'individu a créer
   --   F_Informations : T_Informations, l'enregistrement d'informations de l'individu
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est créé
   -- Retourne : T_Individu, l'individu
   -- Exceptions : Néant
   function creerIndividu(F_Id : in T_Identifiant ; F_Informations : in PT_Informations) return T_Individu;
    
   -------------------------
   
   -- FONCTION : creerIndividu
   -- Sémantique : Renvoie un Individu avec son Id puis demande l'enregistrement d'informations à l'utilisateur
   -- Paramètres :
   --   F_Id : IN T_Identifiant, l'identifiant de l'individu a créer
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est créé
   -- Retourne : T_Individu, l'individu
   -- Exceptions : Néant
   function creerIndividu(F_Id : in T_Identifiant) return T_Individu;
      
   -------------------------
   
   -- FONCTION : creerIndividu_Id
   -- Sémantique : Renvoie un Individu avec seulement son Id de connu, les informations sont mises à null
   -- Paramètres :
   --   F_Id : IN T_Identifiant, l'identifiant de l'individu a créer
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est créé
   -- Retourne : T_Individu, l'individu
   -- Exceptions : Néant
   function creerIndividu_Id(F_Id : in T_Identifiant) return T_Individu;
   
   -- FONCTION : creerInformations
   -- Sémantique : Crée un enregistrement d'informations avec ses 5 champs qui sont les paramètres d'entrée
   -- Paramètres :
   --   F_Nom : IN Unbounded_String, le nom de l'individu
   --   F_Prenom : IN Unbounded_String, le prénom de l'individu
   --   F_Sexe : IN Unbounded_String, le sexe de l'individu
   --   F_Date_Naissance : IN Unbounded_String, la date de naissance de l'individu
   --   F_Date_Deces : IN Unbounded_String, la date de décès de l'individu
   --   F_Adresse : IN Unbounded_String, l'adresse de l'individu
   -- Pré-conditions : Néant
   -- Post-conditions : Resultat.Nom = F_Nom, Resultat.Prenom = F_Prenom, Resultat.Sexe = F_Sexe,
   --                   Resultat.Date_Naissance = F_Date_Naissance, Resultat.Date_Deces = F_Date_Deces, Resultat.Adresse = F_Adresse
   -- Retourne : T_Informations, l'enregistrement d'informations
   -- Exceptions : Néant
   function creerInformations(F_Nom : in Unbounded_String;
                              F_Prenom : in Unbounded_String;
                              F_Sexe : in Unbounded_String;
                              F_Date_Naissance : in Unbounded_String;
                              F_Date_Deces : in Unbounded_String;
                              F_Adresse : in Unbounded_String) return PT_Informations;

   -------------------------
   
   -- PROCEDURE : afficherIndividuComplet
   -- Sémantique : Procedure générique qui affiche un individu (son identifiant et ses informations)
   -- Paramètres :
   --   F_Informations : IN T_Individu, l'individu à afficher
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   generic
      -- procedure générique pour afficher l'identifiant de l'individu (définie dans p_arbre_genealog.adb)
      with procedure afficherIndiv(F_Individu : in T_Individu);
   procedure afficherIndividuComplet(F_Individu : in T_Individu);

   -------------------------
   
   -- PROCEDURE : afficherInformations
   -- Sémantique : Affiche les informations d'un individu (nom, prenom, sexe, date de naisance, de décès, adresse)
   -- Paramètres :
   --   F_Individu : IN T_Identifiant, l'individu duquel on affiche les informations
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure afficherInformations(F_Individu : in T_Individu);
   
   -------------------------
   
   -- PROCEDURE : creerInformationsVides
   -- Sémantique : Crée un enregistrement d'informations vides avec la chaîne "n/a" pour chaque champ (nom, prenom, sexe, date de naisance, de décès, adresse)
   -- Paramètres :
   --   F_Informations : OUT PT_Informations, le pointeur vers l'enregistrement d'informations
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure creerInformationsVides(F_Informations : out PT_Informations);
   
   -------------------------
   
   -- FONCTION : estEgal
   -- Sémantique : Vérifie si deux individus sont égaux en comparant leur identifiant
   -- Paramètres :
   --   F_Id1 : IN T_Identifiant, le premier identifiant
   --   F_Id1 : IN T_Identifiant, le deuxième identifiant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Boolean, vrai si égalité, faux si non égalité
   -- Exceptions : Néant
   function estEgal(F_Id1 : in T_Identifiant ; F_Id2 : in T_Identifiant) return Boolean;
   
   -------------------------
   
   -- FONCTION : estNul
   -- Sémantique : Vérifie si le pointeur d'informations est nul
   -- Paramètres :
   --   F_Informations : IN PT_Informations, le pointeur d'informations
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Boolean, vrai si égalalité, faux si non égalité
   -- Exceptions : Néant
   function estNul(F_Informations : in PT_Informations) return Boolean;

end P_Individu;
