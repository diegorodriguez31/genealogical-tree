with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package body P_Individu is
 
   
   -- Getters / Setters

   -- R0 : Met à jour l'identifiant de l'individu
   procedure set_id(F_Individu : in out T_Individu ; F_Id : in T_Identifiant) is
   begin
      -- R1 : On change la valeur de l'id de l'individu
      F_Individu.Id := F_Id;
   end set_id;
   
   -- R0 : Recupere l'identifiant de l'individu
   function get_id(F_Individu : in T_Individu) return T_Identifiant is
   begin
      -- R1 : On recupere l'id de l'individu
      return F_Individu.Id;
   end get_id;
   
   -- R0 : Met à jour le nom de l'individu
   procedure set_nom(F_Individu : in out T_Individu ; F_Nom : in Unbounded_String) is
   begin
      -- R1 : On change la valeur du nom de l'individu
      F_Individu.Informations.all.Nom := F_Nom;
   end set_nom;
   
   -- R0 : Recupere le nom de l'individu
   function get_nom(F_Individu : in T_Individu) return Unbounded_String is
   begin
      -- R1 : On recupere le nom de l'individu
      return F_Individu.Informations.all.Nom;
   end get_nom;

   -- R0 : Met à jour le prenom de l'individu
   procedure set_prenom(F_Individu : in out T_Individu ; F_Prenom : in Unbounded_String) is
   begin
      -- R1 : On change la valeur du prenom de l'individu
      F_Individu.Informations.all.Prenom := F_Prenom;
   end set_prenom;
   
   -- R0 : Recupere le prenom de l'individu
   function get_prenom(F_Individu : in T_Individu) return Unbounded_String is
   begin
      -- R1 : On recupere le prenom de l'individu
      return F_Individu.Informations.all.Prenom;
   end get_prenom;

   -- R0 : Met à jour le sexe d'un individu
   procedure set_sexe(F_Individu : in out T_Individu ; F_Sexe : in Unbounded_String) is
   begin
      -- R1 : On change la valeur du sexe de l'individu
      F_Individu.Informations.all.Sexe := F_Sexe;
   end set_sexe;
   
   -- R0 : Recupere le sexe de l'individu
   function get_sexe(F_Individu : in T_Individu) return Unbounded_String is
   begin
      -- R1 : On recupere le sexe de l'individu
      return F_Individu.Informations.all.Sexe;
   end get_sexe;

   -- R0 : Met à jour la date de naissance de l'individu
   procedure set_date_naissance(F_Individu : in out T_Individu ; F_Date_Naissance : in Unbounded_String) is
   begin
      -- R1 : On change la valeur de la data de naissance de l'individu
      F_Individu.Informations.all.Date_Naissance := F_Date_Naissance;
   end set_date_naissance;
   
   -- R0 : Recupere la date de naissance de l'individu
   function get_date_naissance(F_Individu : in T_Individu) return Unbounded_String is
   begin
      -- R1 : On recupere la date de naissance de l'individu
      return F_Individu.Informations.all.Date_Naissance;
   end get_date_naissance;

   -- R0 : Met à jour la date de deces de l'individu
   procedure set_date_deces(F_Individu : in out T_Individu ; F_Date_Deces : in Unbounded_String) is
   begin
      -- R1 : On change la valeur de la date de deces de l'individu
      F_Individu.Informations.all.Date_Deces := F_Date_Deces;
   end set_date_deces;
   
   -- R0 : Recupere la date de deces de l'individu
   function get_date_deces(F_Individu : in T_Individu) return Unbounded_String is
   begin
      -- R1 : On recupere la date de deces de l'individu
      return F_Individu.Informations.all.Date_Deces;
   end get_date_deces;
   
   -- R0 : Met à jour l'adresse d'un individu
   procedure set_adresse(F_Individu : in out T_Individu ; F_Adresse : in Unbounded_String) is
   begin
      -- R1 : On change la valeur de l'adresse de l'individu
      F_Individu.Informations.all.Adresse := F_Adresse;
   end set_adresse;
   
   -- R0 : Recupere l'adresse de l'individu
   function get_adresse(F_Individu : in T_Individu) return Unbounded_String is
   begin
      -- R1 : On recupere l'adresse de l'indivud
      return F_Individu.Informations.all.Adresse;
   end get_adresse;
   
   -- R0 : Recupere le pointeur d'informations d'un individu
   function get_informations(F_Individu : in T_Individu) return PT_Informations is
   begin
      -- R1 : On recupere le pointeur d'informations de l'individu
      return F_Individu.Informations;
   end get_informations;
   
   -- R0 : Renvoie un Individu avec son Id et un enregistrement d'informations
   function creerIndividu(F_Id : in T_Identifiant ; F_Informations : in PT_informations) return T_Individu is
      individu : T_Individu; -- Un individu de type T_Individu que l'on utilisera en tant qu'intermediaire
   begin
      -- R1 : On met l'identifiant donne en entree pour le nouvel individu
      individu.Id := F_Id;
      -- R1 : On met le pointeur d'information donne en entree pour le nouvel individu
      individu.Informations := F_Informations;
      -- R1 : On renvoie l'individu ainsi cree pour pouvoir l'utiliser ensuite
      return individu;
   end creerIndividu;
   
   -- R0 : Renvoie un Individu avec son Id puis demande l'enregistrement d'informations à l'utilisateur
   function creerIndividu(F_Id : in T_Identifiant) return T_Individu is
      individu : T_Individu; -- Un individu de type T_Individu que l'on utilisera en tant qu'intermediaire
      informations : T_Informations; -- Un pointeur d'informations de type T_Informations que l'on utilisera en tant qu'intermediaire
      -- Pour les autres variables, elles sont de type Unbounded_String car ça permet de pouvoir saisir ensuite une chaine de caracteres de taille non definir à l'avance
      nom : Unbounded_String; -- Le nom que l'on va demander à l'utilisateur
      prenom : Unbounded_String; -- Le prenom que l'on va demander à l'utilisateur
      sexe : Unbounded_String; -- Le sexe que l'on va demander à l'utilisateur
      date_naissance : Unbounded_String; -- La date de naissance que l'on va demander à l'utilisateur
      date_deces : Unbounded_String; -- La date de deces que l'on va demander à l'utilisateur
      adresse : Unbounded_String; -- L'adresse que l'on va demander à l'utilisateur
   begin
      -- R1 : On met l'identifiant donne en entree en valeur pour le nouvel individu
      individu.Id := F_Id;
      -- R1 : On demande le nom à l'utilisateur
      Put_Line("Quel est son nom ?");
      Skip_Line;
      -- R1 : On recupere la valeur du nom que l'utilisateur veut mettre
      Get_Line(nom);
      -- R1 : On demande le prenom à l'utilisateur
      Put_Line("Quel est son prenom ?");
      -- R1 : On recupere la valeur du prenom que l'utilisateur veut mettre
      Get_Line(prenom);
      -- R1 : On demande le sexe à l'utilisateur
      Put_Line("Quel est son sexe ?");
      -- R1 : On recupere la valeur du sexe que l'utilisateur veut mettre
      Get_Line(sexe);
      -- R1 : On demande la date de naissance à l'utilisateur
      Put_Line("Quel est sa date de naissance ?");
      -- R1 : On recupere la valeur de la date de naissance que l'utilisateur veut mettre
      Get_Line(date_naissance);
      -- R1 : On demande la date de deces à l'utilisateur
      Put_Line("Quel est sa date de deces ?");
      -- R1 : On recupere la valeur de la date de deces que l'utilisateur veut mettre
      Get_Line(date_deces);
      -- R1 : On demande l'adresse à l'utilisateur
      Put_Line("Quel est son adresse ?");
      -- R1 : On recupere la valeur de l'adresse que l'utilisateur veut mettre
      Get_Line(adresse);
      -- R1 : On appelle la function "creerInformations" qui va permettre de fabriquer le pointeur d'informations et ensuite de mettre
      -- Ce pointeur recupere en valeur pour le nouvel individu
      individu.Informations := creerInformations(nom, prenom, sexe, date_naissance, date_deces, adresse);
      -- R1 : On renvoie l'individu cree
      return individu;
   end creerIndividu;
   
   -- R0 : Renvoie un Individu avec seulement son Id de connu
   function creerIndividu_Id(F_Id : in T_Identifiant) return T_Individu is
      individu : T_Individu; -- Un individu de type T_Individu que l'on utilisera en tant qu'intermediaire
   begin
      -- R1 : On met l'identifiant donne en entree en valeur pour le nouvel individ
      individu.Id := F_Id;
      -- R1 : On appelle la procedure "creerInformationsVides" qui va creer un pointeur d'informations vide remplis de champs "n/a"
      -- Le parametre qui est le pointeur vers les informations est en mode OUT donc ça met à jour automatiquement le pointeur d'informations de l'individu
      creerInformationsVides(individu.Informations);
      -- R1 : On renvoie l'individu cree
      return individu;
   end creerIndividu_Id;
   
   -- R0 : Cree un enregistrement d'informations
   function creerInformations(F_Nom : in Unbounded_String;
                              F_Prenom : in Unbounded_String;
                              F_Sexe : in Unbounded_String;
                              F_Date_Naissance : in Unbounded_String;
                              F_Date_Deces : in Unbounded_String;
                              F_Adresse : in Unbounded_String) return PT_Informations is
      informations : PT_Informations; -- Un pointeur d'informations de type T_Informations que l'on utilisera en tant qu'intermediaire
   begin
      -- R1 : On fabrique un nouveau pointeur d'informations avec les donnees en entree
      informations := new T_Informations'(F_Nom, F_Prenom, F_Sexe, F_Date_Naissance, F_Date_Deces, F_Adresse);
      -- R1 : On renvoie ce pointeur d'informations
      return informations;
   end creerInformations;

   -- R0 : Procedure generique qui affiche un individu (son identifiant et ses informations)
   procedure afficherIndividuComplet(F_Individu : in T_Individu) is
   begin
      -- R1 : On appelle la methode "afficherIndiv", la procedure generique qui va afficher les donnees d'un individu, en l'ocurrence l'identifiant
      afficherIndiv(F_Individu);
      -- R1 : On appelle la methode "afficherInformations", la procedure qui va afficher les donnees d'un individu, en l'occurence les informations du pointeur d'informations
      afficherInformations(F_Individu);
   end afficherIndividuComplet;
   
   -- R0 : Affiche les informations d'un individu (nom, prenom, sexe, date de naisance, de deces, adresse)
   procedure afficherInformations(F_Individu : in T_Individu) is
      inconnu : Unbounded_String; -- Chaîne de caracteres de valeur ("n/a") afin d'indiquer qu'une information n'a pas de valeur
      informations : PT_Informations; -- Un pointeur d'informations de type T_Informations que l'on utilisera en tant qu'intermediaire
      individu : T_Individu; -- Un individu de type T_Individu que l'on utilisera en tant qu'intermediaire
   begin
      -- R1 : On met la valeur "n/a" à la chaîne de caracteres "inconnu"
      inconnu := To_Unbounded_String("n/a");
      -- R1 : Si le pointeur d'informations de l'individu n'est pas null
      if not (F_Individu.Informations = null) then
         -- R2 : Si l'utilisateur n'a rien saisi comme information pour le champ "Nom" (chaîne de caractere vide "")
         if F_Individu.Informations.all.Nom = "" then
            -- R3 : On met la valeur de la chaîne de caracteres "inconnu" dans ce champ
            F_Individu.Informations.all.Nom := inconnu;
         else
            -- R3 : On ne fait rien
            null;
         end if;
         -- R2 : Si l'utilisateur n'a rien saisi comme information pour le champ "Prenom" (chaîne de caractere vide "")
         if F_Individu.Informations.all.Prenom = "" then
            -- R3 : On met la valeur de la chaîne de caracteres "inconnu" dans ce champ
            F_Individu.Informations.all.Prenom := inconnu;
         else
            -- R3 : On ne fait rien
            null;
         end if;
         -- R2 : Si l'utilisateur n'a rien saisi comme information pour le champ "Sexe" (chaîne de caractere vide "")
         if F_Individu.Informations.all.Sexe = "" then
            -- R3 : On met la valeur de la chaîne de caracteres "inconnu" dans ce champ
            F_Individu.Informations.all.Sexe := inconnu;
         else
            -- R3 : On ne fait rien
            null;
         end if;
         -- R2 : Si l'utilisateur n'a rien saisi comme information pour le champ "Date_Naissance" (chaîne de caractere vide "")
         if F_Individu.Informations.all.Date_Naissance = "" then
            -- R3 : On met la valeur de la chaîne de caracteres "inconnu" dans ce champ
            F_Individu.Informations.all.Date_Naissance := inconnu;
         else
            -- R3 : On ne fait rien
            null;
         end if;
         -- R2 : Si l'utilisateur n'a rien saisi comme information pour le champ "Date_Deces" (chaîne de caractere vide "")
         if F_Individu.Informations.all.Date_Deces = "" then
            -- R3 : On met la valeur de la chaîne de caracteres "inconnu" dans ce champ
            F_Individu.Informations.all.Date_Deces := inconnu;
         else
            -- R3 : On ne fait rien
            null;
         end if;
         -- R2 : Si l'utilisateur n'a rien saisi comme information pour le champ "Adresse" (chaîne de caractere vide "")
         if F_Individu.Informations.all.Adresse = "" then
            -- R3 : On met la valeur de la chaîne de caracteres "inconnu" dans ce champ
            F_Individu.Informations.all.Adresse := inconnu;
         else
            -- R3 : On ne fait rien
            null;
         end if;
         -- R2 : Maintenant que tout à ete etabli avec la valeur souhaitee, on affiche toutes les informations à la suite les unes des autres
         Put(" (" & F_Individu.Informations.all.Nom & ", " &
               F_Individu.Informations.all.Prenom & ", " &
               F_individu.informations.all.Sexe & ", " &
               F_individu.informations.all.Date_Naissance & ", " &
               F_individu.informations.all.Date_Deces & ", " &
               F_individu.informations.all.Adresse & ")");
      else
         -- R2 : S'il est null, alors on cree un nouveau pointeur d'informations
         informations := new T_Informations'(inconnu, inconnu, inconnu, inconnu, inconnu, inconnu);
         -- R2 : On met l'identifiant donne en entree en valeur pour l'individu
         individu.Id := F_Individu.Id;
         -- R2 : On met le pointeur d'informations fabrique ci-dessus en valeur pour l'individu
         individu.Informations := informations;
         -- R2 : On appelle recursivement la procedure "afficherInformations" afin de mettre les valeurs à "n/a" du pointeur d'informations cree
         afficherInformations(individu);
      end if;
   end afficherInformations;
   
   -- R0 : Cree un enregistrement d'informations vides avec la chaîne "n/a" pour chaque champ (nom, prenom, sexe, date de naisance, de deces, adresse)
   procedure creerInformationsVides(F_Informations : out PT_Informations) is
      informations : PT_Informations; -- Un pointeur d'informations de type T_Informations que l'on utilisera en tant qu'intermediaire
      inconnu : Unbounded_String; -- Chaîne de caracteres de valeur ("n/a") afin d'indiquer qu'une information n'a pas de valeur
   begin
      -- R1 : On met la valeur "n/a" à la chaîne de caracteres "inconnu"
      inconnu := To_Unbounded_String("n/a");
      -- R1 : S'il est null, alors on cree un nouveau pointeur d'informations
      informations := new T_Informations'(inconnu, inconnu, inconnu, inconnu, inconnu, inconnu);
      -- R1 : On applique ce nouveau pointeur d'informations vides sur la valeur du parametre "F_Informations" qui va être renvoye car le parametre est en mode OUT
      F_Informations := informations;
  end creerInformationsVides;

   -- R0 : Verifie si deux individus sont egaux en comparant leur identifiant
   function estEgal(F_Id1 : in T_Identifiant ; F_Id2 : in T_Identifiant) return Boolean is
   begin
      return F_Id1 = F_Id2;
   end estEgal;
   
   -- R0 : Verifie si le pointeur d'informations est nul
   function estNul(F_Informations : in PT_Informations) return Boolean is
   begin
      -- R1 : On verifie si le pointeur d'informations est null
      -- On renvoie true s'il est null et false sinon
      return F_Informations = null;
   end estNul;

end P_Individu;
