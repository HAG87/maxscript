-- A faire sur les personnages 

-- RIG

-- creer un  custom attribute pour controler la bascule du pieds du robot

-- ANIM
-- finir l'animation grossi�re de la s�quence, jusqu'a ce que le robot soit assom�.


----------------------------------------------------------------------
----------------------------------------------------------------------

--SCRIPT
-- serie SmartRig

-- SmartRIG_the_twistor_up v0.1
--- def: � partir d'un bones selectionn� et d'un controleur d'orientation sur une ik trois petit os orient� comme pau neale le montre.

-- SmartRIG_the_twistor_dw v0.1
--- def: � partir d'un bones selectionn� et d'un controleur d'orientation sur une ik trois petit os orient� comme pau neale le montre.

-- SmartRIG_ik_stretch v0.1
---- def : reprendre le ik_stretch en remplaceant la contrainte au controleur spline par un link et en reliant les bones par une parent�e et un scale

-- SmartRIG_stretch_spine v0.1
---- def : comme le strecht_spine2 mais avec un systeme d'orientation des os plus leger et un controle de la spline bas� sur un skin

-- SmartRIG_stretch_spine_add_controler v0.1
---- def : ajoute un controleur supl�mentaire sur une spline en rentrant dans le skin
---- amelioration : ne peut rajouter qu'un controleur de spline. reprendre les classement des knots pour ajouter des points indefiniment

-- SmartRIG_ik_strech_nbones v0.1
---- def : cr�er un ik stretch avec twist sur plus de trois bones

-- RIG

-- RIG_ik_stretch_var2
---- def: reprendre rigger_un_ik_stretch avec des contrainte script pour linker des controleur spline

-- RIG_twist_bone_var2
---- def: reprendre  creer twist bone en remplan�nt le systelme des look at par des controleur orientation. mettre un controleur look at sur le controleur up.

-- RIG_stretch_spine_var2
---- def: � partir du stretch_spine2 remplacer les controleur de la spline par un skin. linker avec les controleur spline par des controller script

-- RIG_finger_var2
---- def: � partir de rigger un doigt remplacer le link aux controleur spline par  des controller script.

-- RIG_bones_tunes_var2



-- stretch_spine_relink_copy v0.1
---- def:
------ en cas de copie d'une ik spline les controleur script des knot des splines ne sont pas redirig�es correctement.
------ appliquer ce script � la selection avant et apr�s la copie � la selection r�gle le probl�me.
---- am�lioration:
------ pr�voir le cas de plusieurs splines
------ remplacer les controlleurs de la spline par un skin
------ remplacer les contraintes position et rotation par des contraintes script�es.

-- Tunage de bones v.0.1
---- def: 
------ � partir d'une chaine bones, contrindre chaque bone � un helper en position et en rotation. les bones deviennent etirable. 
------ cr�e un spy_rot sur chaque bone pour en collecter la rotation sans erreurs 
---- am�lioration : remplacer les contrainte position et rotation par des controleurs scripts

-- rigger_un_ik_stretch v0.1
---- am�lioration : 
------- remplacer les contrainte position et rotation par des controleurs scripts

-- rigger_ikfk_stretch_with_free_elbow v0

-- creer twist bone v0.1
---- def: � partir d'une cjaine de bones, cr�er une chaine etirable et torsionnable entre deux helpers
---- am�lioration : remplacer les contrainte position et rotation par des controleurs scripts

-- go_fast_controller! v0.1
---- def : remplace des controlleur spline lier en position et rotation contrainte par des controleurs lier par controller script
---- am�lioration : mettre � jour les controleurs script en fonction des derniers d�veloppement du script  pos_rot_script_contraint

-- destroy_rig v0.1 (cf clean bones)
---- ameliorer le script de netoyage de bones pour conserver les bones d'origine

-- clean_bone_var4 v0.1
---- def; supprime toutes les contraintes appliquer au bones tout en conservant leur emplacement
---- amelioration : trouver l'�quivalent du realugn (vecteur?) et du reset stretch en script.

-- creer_ctr_helper v0.1
---- def: cr�e un controlleur spline (cercle) sur un objet selectionner
---- am�lioration: 
------remplacer les contraintes position et rotation par des controleurs scripts
------ pr�parer donner la posibilit� de choisir entre plusieurs spline (voir recup_spline) 

-- recup_spline v0.1
---- def: recup�re les knot d'une apline afin de pouvoir la recr�er
---- am�lioration: stocker les spline r�cup�r�e afin de pourvoir les r�utilis�e (sous forme de fichier externe?)

-- pos_rot_script_contraint.mcr v1
----def: lier un objet a un autre en position et rotation

-- orient_control v1
---- amelioration : afficher des panneaux d'alerte plutot que du script

-- multi_parent v1
---- def: lie une selection d'objets au dernier objet de la selection

-- link_chaine v0.1
---- def: cr�e un hi�rachie sur une selection d'objet en suivant leur ordre de selection.

-- select_parent v1
---- amelioration : faire disparaitre l'ancien panneau d'alerte pour le remplacer par le nouveau

-- personnal_freezer v0
---- def : refaire le script pour freezer le mouvement afin qu'il fonctionne sur plus de deux controlleur sans effacer les clefs d'animation (le Pose_stajer regle au moins en partie la question)

-- rigger un doigt v0.1
---- def : cr�er des controller spline sur une selectionner de bones pour rigger un doigt

-- rigger_un_ik_stretch_with_free_elbow_general4 v0.1
---- def : cr�er un rig de bras ou de jambe avec un ik strech et un coude ajustable.
---- am�lioration : l'animation du coude est aujourd'hui inutilisable bien que pr�sente, elle alt�re le reste de l'animation du bras.

-- stretch_spine2
---- def : � partir d'une selection de bones, cr�e un ik_spline etirable.
---- amelioration; remplacer les controller de position et rotation par des controller script

-- ajout de controleur spline segment
---- def: ajoute un controlleur d'animation suppl�mentaire sur un segment selectionne d'un ik spine
---- am�lioration: remplacer les controller de position et rotation par des controller script 


--ANIM

-- custom_scale_modifier_perm_animable v0.1
---- def : 
------ cr�e un custom attribute sur un objet qui permet de rendre plus accessible l'animation du scale. 
------ r�siste � la fermeture de la session
------ si le modifier est d�truit l'animation est conserv� sur l'objet
---- am�lioration : lorsqu'un nouveau modifier est cr�� il faudrait qu'il r�cup�re les clefs d'animation de l'objet.

-- Multi_Constraint_in_the_air v0
---- def: 
------Script pour contrainte un objet � un autre � la vol�e (� partir du script de contrainte des mains de la fourmi au marteau : cust_attr_contrainte_a _plusieurs_objets_format.ms)
------ contrainte d'un objet � un autre � la vol�e (procedure) � partir d'un premier controleur non contraint
----synoptique ( a la premiere utilisation):
------ 1. creer le controlleur spline contraignant � la position du controleur d'origine, cr�er un controleur � la cible
------ 2 changer l'apparence du controleur spline
------ 3. transf�rer les clefs d'animaion de la source controleur au controleur d'origine(controlleur)
------ 4. effacer les clefs de la source
------ 5 cr�er un clef d'animation pour contraindre le controlleur spline � la cible et une cl� d'animation juste avant pour que l'animation qui pr�c�de reste li� � l'origine
------ 6. cr�er un custom attribute � l'obejt contraint qui permette de rajouter des contraintes, de les activer et de les enlever 

---- synoptique +
------ 1. creer des controller de position et de rotation sur l'objet (script contrainte) � la position courante (ajout de helper ou de controleur spline � l'objet cible)
------ 2. permet de controler la contrainte � un cible par un modifier en controlant les piste de poids des controller
------ 3. creer des clefs d'animation sur les pistes de poids

-- Custom attribute contrainte objet v0
---- def:
------ � afficher sur l'objet contraint et sur les cibles 
------ pr�voir de masquer les objets de contraintes non actif
------ en cas de delete d'un objet contrainte, supprimer les clefs de contraintes de l'objet source

-- Smart_anim_pose_lister v0
---- def: r�cup�re tous les stackers d'animation de la scene pour les administrer, changer les noms, en cr�� de nouveaux, en supprimer

-- Smart_anim_pose_creator.ms v0.1
---- def : cr�e un point sur lequel on peut enregistrer une selection d'objet

-- Smart_anim_pose_editor.ms v0.1
---- def: interface qui permet de g�rer la liste de node enregistr� sur un stacker_node
---- amelioration: cr�er une interface qui g�re la cr�ation des stackers dans la sc�ne et l'acc�s � leur donn�es. Utiliser les structures

-- Pose_Stacker_Creator v0.1
---- tout a l'air de fonctionner

-- Pose_Stacker_Editor v0.1
-- debug : verifier quand on a supprimer toutes les pose et qu'on rappuie sur delete que �a ne provoque pas une erreur.
---- la fonction copy fonctionne
---- la fonction paste � moiti�
---- la fonction delete est tr�s incomplete
---- les donn�es sont conserv�es dans la scene mais � la coll�e le ref selectionner n'est pas celui qui correspond � l'enregistrement
-- amelioration : 
---- faire fonctionner le script sur des plage d'image
---- cr�er un superviseur d'editor
---- supprimer le crash au demarrage en definissant la variable qui pose probl�me. ou en cr�eant un macroscript qui appelle un script, ou en posant une condition if (semeble foireux), creer un menu superviseur, creer un pouton pick
---- creer une preview pose avec un toggle


--copy_paste_pose_iu2 v.0.1 (obsolete cf Pose_Stacker_Editor)
---- def: 
------ cr�e une interface pour le copi colle de position relatif � un objet de reference.
------ creer un outil pour copier les clefs d'un track d'un objet, les stock�s et les coller sur un autre objets sur la plage d'image d�fini en bas. pouvoir param�trer position/ rotation/ scale. 
---- Ameliorations : 
------ stockers les poses pour les retrouver � la session suivante (avec fonction Format sur des custom attribute ou des fichiers externes? avec des variables globales?)
------ s'en servir pour stocker des set de conttrainte a des objets?

--copy_paste_pose_modifier v.0.1 (obsolete cf Pose_Stacker_Editor)
---- def: fait la m�me chose que copy_paste_pose_iu2 mais sous la forme d'un modifier

-- memo_nodeTab_rollout.ms v0.1
---- def: cr�er un objet avec un modificateur qui stocke une selection d'objet. La gestion des selection se fait par une boite de dialogie. Donn�es propres � la sc�ne et persistantes.
---- am�lioration:
------ fixer le nom des boite de dialogue (format?)
------ stocker les donn�es sur l'objets cr�� plutot que sur le modificateur
------ placer un  bouton sur l'objet de stockage qui g�n�re un modificateur, � instancier sur d'autre objet. format?
------ aller vers le controle de pose
----- debug: pourquoi ce bordel demande un plugin?
------ faire un script qui appelle un script, restester la fonstion. Pourquoi la fonstion en se lassant au demarrage ne fonctionne pas?

-- Create loc Key v.0.1
----def:
------ cr�e des clefs sur un objet  copies des clefs de rotation et de position pr�c�dentes

-- +- 360 v0
---- def: sur une ou plusieurs cl�s de rotation s�lectionn�es, ajouter ou soutraire 360� en x y ou z.

-- multi auto key v0
---- def : appliquer la meme transformation a plusieurs clefs selectionnees.

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- CONSIGNE : 
-- ne jamais scaler aucun element d'un rig ni faire ne symetrie dessus
-- ne jamais lier un hlper de fin de rig � un controller spline avec les contrainte position et rotation de max. Utiliser le lien de parent� ou un controller script. Cela fait freezer les selection de clefs d'animation.

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

-- PROBLEMATIQUE
-- comment conserver des donn�es sur une sc�ne apr�s la fermeture de la session (array, valeur, selection...). Par l'�criture sur des fichiers externes? par l'�criture dans des custom attributes? par les variables globales? par les attributes dans les customattributes?
---- pour le moment je m'oriente vers les custom attribute qui permettent de stocker et de rappeler des donn�es dans une sc�ne. Il y a aussi la solution des setappdata mais �a ne fonctionne qu'avec les string
---- pour le pose_staker j'ai utilser les custom attributes
-- de mani�re g�n�rale privil�gier des controller script au controller max. voir comment les remplacer dans les scripts existant, notament dans les cr�ation par script de liaison entre les helpers de fin de rig et les controleurs d'animation.
-- probl�me de nomenclature, confusion entre controller et controleur et entre les dif�rents usages des spline.
-- aller voir du c�t� des matrices s'il y a quelque chose � faire
-- comment faire pour lancer un script par un macroscript. Voir dans les soulburn script. cela pour eviter le crach du pose_staker_editor
-- les modifier et la demande de plugin pour conserver des variables
-- je doit trouver un moyen de cr�er des rig plus rapides. Remplacer les script de vertex de la spline par un skin. linker les controleur spline aux helpers avec des contraintes scripter (plus rapide � la selection des controleurs et � la selection des clefs)
-- tester si le rig est plus rapide lorsque toutes les contraintes positions et rotations sont remplac�es par des contraintes script�es.
-- creer un contrainte lookat script�es avec les vecteurs.

