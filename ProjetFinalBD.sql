--Partie 1: Modele Logique de donnees et creation table
--#2
--2.1
--creation de la table Eleve
create table Eleve (
    E_id number(4),
    E_nom varchar(30),
    E_prenom varchar(30),
    E_date_Naiss date,
    E_tel number(11),
    E_date_dossier date,
    E_date_code date
);

--creation de la table Inscription
create table Inscription(
    I_id number(4),
    E_id number(4),
    I_type varchar(30),
    I_date_insc date,
    I_date_Examen date,
    I_resultat number(3,1),
    I_num number(2)
);

--creation de la table Trajet
create table Trajet(
    T_id number(4),
     E_id number(4),
    T_date date,
    T_nb_km number(3),
    T_type varchar(30)
);

--creation de la table Lecon
create table Lecon(
    L_id number(4),
    E_id number(4),
    M_id number(4),
    L_date date,
    L_duree number(2)
);

--creation de la table Moniteur
create table Moniteur(
    M_id number(4),
    M_nom varchar(30),
    M_prenom varchar(30)
);

--2.1
--implantation des contrainte a partir des commandes alter table
--Ajout des contrainte cle primaire sur les tables a partir de Alter Table
alter table Eleve add CONSTRAINT pk_idE primary key(E_id);
alter table Trajet add CONSTRAINT pk_idT primary key(T_id);
alter table Inscription add CONSTRAINT pk_idI primary key(I_id);
alter table Lecon add CONSTRAINT pk_idL primary key(L_id);
alter table Moniteur add CONSTRAINT pk_idM primary key(M_id);

--Ajout des contrainte cle etrangeres sur les tables a partir de Alter Table
alter table Trajet add  constraint Fk_T_idE FOREIGN key(E_id) REFERENCES Eleve(E_id);
alter table Inscription add constraint Fk_I_idE FOREIGN key(E_id) REFERENCES Eleve(E_id);
alter table Lecon  add constraint Fk_L_idE FOREIGN key(E_id) REFERENCES Eleve(E_id);
alter table Lecon  add constraint Fk_L_idM FOREIGN key(E_id) REFERENCES Moniteur(M_id);

--2.2
--suppression des table 

drop table Lecon;
drop table Inscription;
drop table Trajet;
drop table Eleve;
drop table Moniteur

--creation des tables avec les contrainte nommee au niveau colonne quand c est possible
--creation de la table Eleve
create table Eleve (
    E_id number(4) constraint pk_idE primary key,
    E_nom varchar(30),
    E_prenom varchar(30),
    E_date_Naiss date,
    E_tel number(11),
    E_date_dossier date,
    E_date_code date,
    constraint chk_dateN check (E_date_Naiss < E_date_dossier),
    constraint chk_dateD check (E_date_dossier < E_date_code)
);
--creation de la table Inscription
create table Inscription(
    I_id number(4) constraint pk_idI primary key,
    E_id number(4) constraint fk_I_idE  REFERENCES Eleve(E_id),
    I_type varchar(30) constraint chk_typeI check (I_type in('Classique','Anticipe','Supervise')),
    I_date_insc date,
    I_date_Examen date,
    I_resultat number(3,1),
    I_num number(2),
    CONSTRAINT chk_dateI check (I_date_insc < I_date_Examen)
);
--creation de la table Trajet
create table Trajet(
    T_id number(4) constraint pk_idT primary key,
     E_id number(4) constraint fk_T_idE REFERENCES Eleve(E_id),
    T_date date,
    T_nb_km number(3),
    T_type varchar(30) CONSTRAINT chk_typeT check (T_type in('Classique','Accompagne'))
);

--creation de la table Moniteur
create table Moniteur(
    M_id number(4) constraint pk_idM primary key,
    M_nom varchar(30),
    M_prenom varchar(30)
);

--creation de la table Lecon
create table Lecon(
    L_id number(4) constraint pk_idL primary key,
    E_id number(4) constraint fk_L_idE REFERENCES Eleve(E_id),
    M_id number(4) constraint fk_L_idM REFERENCES Moniteur(M_id),
    L_date date,
    L_duree number(2)
);


--creation des tables avec les contrainte nommee au niveau Table
--suppression des table 

drop table Lecon;
drop table Inscription;
drop table Trajet;
drop table Eleve;
drop table Moniteur

--creation de la table Eleve
create table Eleve (
    E_id number(4),
    E_nom varchar(30),
    E_prenom varchar(30),
    E_date_Naiss date,
    E_tel number(11),
    E_date_dossier date,
    E_date_code date,
    CONSTRAINT pk_idE primary key(E_id),
    constraint chk_dateN check (E_date_Naiss < E_date_dossier),
    constraint chk_dateD check (E_date_dossier < E_date_code)
);

--creation de la table Inscription
create table Inscription(
    I_id number(4) ,
    E_id number(4) ,
    I_type varchar(30) ,
    I_date_insc date,
    I_date_Examen date,
    I_resultat number(3,1),
    I_num number(2),
    constraint pk_idI primary key(I_id),
    constraint fk_I_idE FOREIGN KEY(E_id) REFERENCES Eleve(E_id),
    constraint chk_typeI check (I_type in('Classique','Anticipe','Supervise')),
    CONSTRAINT chk_dateI check (I_date_insc < I_date_Examen)
);

--creation de la table Trajet
create table Trajet(
    T_id number(4) ,
     E_id number(4) ,
    T_date date,
    T_nb_km number(3),
    constraint pk_idT primary key(T_id),
    constraint fk_T_idE FOREIGN KEY(E_id) REFERENCES Eleve(E_id),
    T_type varchar(30) CONSTRAINT chk_typeT check (T_type in('Classique','Accompagne'))
);

--creation de la table Moniteur
create table Moniteur(
    M_id number(4) ,
    M_nom varchar(30),
    M_prenom varchar(30),
    constraint pk_idM primary key(M_id)
);

--creation de la table Lecon
create table Lecon(
    L_id number(4) ,
    E_id number(4) ,
    M_id number(4) ,
    L_date date,
    L_duree number(2),
    constraint pk_idL primary key(L_id),
    constraint fk_L_idE FOREIGN KEY(E_id) REFERENCES  Eleve(E_id),
    constraint fk_L_idM FOREIGN KEY(M_id) REFERENCES Moniteur(M_id)
);

--#3 requette permettant d'ajouter 3 nouvelle colonne
alter table Moniteur add M_salaire number(8,2);
alter table Moniteur add M_sexe VARCHAR(1) CONSTRAINT chk_sexe1 check (M_sexe in('M','F'));
alter table Moniteur add M_mail VARCHAR(50);

--#4 requette permettant de supprimer la colonne mail dans la table Moniteur
alter table Moniteur drop column M_mail;

--#5 requette permettant de creer un index sur la colonne E_id de la table eleve
create unique index ind_uni1 on  Eleve(E_id);
--On constate que cette colonne est deja indexe
--#6 requette permettant de desactiver la contrainte cle primaire de la colonne E_id de la table eleve
alter table Eleve  disable CONSTRAINT PK_IDE;
--impossible de desactiver la contrainte car la cle primaire est reference
--#7 requette permettant de commenter les table(Eleves,Inscription) ainsi que leur colonne

--Commentaire sur tables
comment on table Eleve is 'Je suis un commentaire sur la table Eleve';
comment on table Inscription is 'Je suis un commentaire sur la table Inscription';

--commentaire sur les colonne de la table Eleve
comment on column Eleve.E_ID is 'je suis le champ representant les identifiant des eleve';
comment on column Eleve.E_NOM is 'je suis le champ representant le nom des eleves';
comment on column Eleve.E_DATE_NAISS is 'je suis le champ representant la date de naissance des eleves';
comment on column Eleve.E_TEL is 'je suis le champ representant le numero cellulaire des eleve';
comment on column Eleve.E_DATE_DOSSIER is 'je suis le champ representant la date de creation de dossier pour les eleves';
comment on column Eleve.E_DATE_CODE is 'je suis le champ representant la date de livraison de code pour les eleve';

--commentaire sur les colonne de la table Inscription
comment on column Inscription.I_ID is 'je suis le champ representant les identifiant des Inscrits';
comment on column Inscription.E_ID is 'je suis la colonne references des eleve dans la table inscription';
comment on column Inscription.I_TYPE is 'je suis la colonne representant le type des inscription';
comment on column Inscription.I_DATE_INSC is 'je suis la colonne representant la date des inscription';
comment on column Inscription.I_DATE_EXAMEN is 'je suis la colonne representant la date des examens';
comment on column Inscription.I_RESULTAT is 'je suis la colonne representant les resultat des examen';
comment on column Inscription.I_NUM is 'je suis la colonne num';



---Partie 2 DML
--requette permettant d inserer 5 enregistrement dans chaque relation
--insertion dans la table Eleve
insert into eleve values(0000,'sanon','kwedek','1997-02-10',44111987,'2009-10-10','2012-11-11');
insert into eleve values(0001,'steevy','ploum','1996-02-10',44111987,'2008-10-10','2009-11-11');
insert into eleve values(0002,'kanou','plam','1995-02-10',44111987,'2006-10-10','2009-11-11');
insert into eleve values(0003,'babou','blam','1993-02-10',44111987,'2002-10-10','2006-11-11');
insert into eleve values(0004,'laurent','klam','1999-02-10',44111987,'2007-10-10','2010-10-11');

--insertion dans la table Inscription
insert into Inscription values(1000,0000,'Classique','2010-10-10','2011-11-11',64,1);
insert into Inscription values(1001,0001,'Anticipe','2008-10-10','2012-11-11',63,2);
insert into Inscription values(1002,0000,'Supervise','2010-12-12','2013-11-11',80,3);
insert into Inscription values(1003,0002,'Classique','2010-11-11','2011-12-12',70,4);
insert into Inscription values(1004,0001,'Classique','2010-08-06','2011-11-11',90,1);

--insertion dans la table Trajet
insert into trajet values(2020,0003,'2011-10-10',90,'Classique');
insert into trajet values(2019,0004,'2010-10-10',30,'Classique');
insert into trajet values(2018,0000,'2016-10-10',70,'Accompagne');
insert into trajet values(2017,0003,'2012-10-10',10,'Classique');
insert into trajet values(2016,0000,'2011-10-10',50,'Accompagne');

--insertion dans la table Moniteur
insert into moniteur values(3000,'monitor1','labo1',4000.5,'M');
insert into moniteur values(3001,'monitor2','labo2',5000,'F');
insert into moniteur values(3002,'monitor3','labo3',3000.5,'M');
insert into moniteur values(3003,'monitor4','labo4',6000.5,'F');
insert into moniteur values(3004,'monitor5','labo5',4100.700,'M');


--insertion dans la table Lecon
insert into Lecon values(4000,0000,3000,'2008-10-10',4);
insert into Lecon values(4001,0003,3001,'2009-10-10',3);
insert into Lecon values(4002,0000,3000,'2012-10-10',5);
insert into Lecon values(4003,0002,3003,'2019-10-10',2);
insert into Lecon values(4004,0004,3000,'2010-10-10',1);

--#2 Commandes permenttant d avoir des infos
--2.1 moniteur ayant plus d heure de lecon
select m_nom,L_duree from moniteur inner join lecon on moniteur.m_id=lecon.m_id where L_duree=(select max(l_duree) from lecon);
--2.2
select m_nom,L_duree from moniteur inner join lecon on moniteur.m_id=lecon.m_id;
--2.3
select m_nom,L_duree from moniteur inner join lecon on moniteur.m_id=lecon.m_id where L_duree=(select min(l_duree) from lecon);
--2.4
--2.5
select E_nom,I_resultat,I_DATE_EXAMEN from eleve inner join inscription on eleve.E_id=inscription.E_id where I_resultat>65 and trunc ((sysdate - I_date_examen) / (365)) = 1;
--2.6
select E_nom,I_resultat,I_DATE_EXAMEN from eleve inner join inscription on eleve.E_id=inscription.E_id where I_resultat is null and trunc ((sysdate - I_date_examen) / (365)) > 1;
--2.7
update moniteur set m_salaire=m_salaire+m_salaire*0.10;
--2.8
update moniteur set m_salaire=m_salaire-1500 where m_salaire=(select max(m_salaire) from moniteur); 
--2.9
delete from eleve where trunc((SYSDATE - E_date_Naiss) / (365)) > 50;
--Partie 3 Vue
--#1
--l
create view moniteur_et_lecons as select l.m_id,m.m_nom,m.m_prenom,sum(l.l_duree) as nombre_heure from moniteur m inner join lecon l on m.m_id=l.m_id group by l.m_id,m.m_nom,m.m_prenom;
--2
create or replace view  moniteur_min_heures as select l.m_id,m.m_nom,m.m_prenom from moniteur m inner join lecon l on m.m_id=l.m_id where l.l_duree=(select min(l_duree) from lecon); 
--3
 --select E.E_id,E.E_nom,sum(T.T_NB_KM) as nombre_total_km,count(t.T_NB_KM) as nb_route from Eleve E inner join Trajet T on E.E_id=E.E_id group by E.E_id,E.E_nom;--2.4
--4
create view Eleves_a_faire_repasser as select I.E_id,E.E_nom,E.E_prenom,I.I_date_Examen from eleve E inner join inscription I on E.E_id=I.E_id where I.I_resultat < 65 and trunc ((sysdate - E.E_date_Naiss)/(365)) = 1;
--5
create view Eleves_a_faire_passer as select I.E_id,E.E_nom,E.E_prenom from eleve E inner join inscription I on E.E_id=I.E_id where I.I_resultat is null and trunc ((sysdate - E.E_date_Naiss)/(365)) < 1;


--Partie 4:: Sequences
--1
create sequence seq_eleve1 increment by 1 start with 1;
--2
create sequence seq_eleve2 increment by 5 start with 2000 maxvalue 20000;
--3
--valeur courante
select seq_eleve1.currtval from dual;
--prochaine valeur
select seq_eleve1.nextval from dual;
--insertion avec la sequence seq_eleve2 dans la table eleve
insert into eleve values(seq_eleve2.nextval,'eleve1','1989-10-10',44111900,'2007-10-10','2010-10-10','kanoi');
insert into eleve values(seq_eleve2.nextval,'eleve2','1979-10-10',44101900,'2006-10-10','2009-10-10','vovovo');
insert into eleve values(seq_eleve2.nextval,'eleve3','1990-10-10',47111900,'2002-10-10','2006-10-10','alibi');
insert into eleve values(seq_eleve2.nextval,'eleve4','1989-11-11',48111900,'2003-10-10','2010-12-12','koi');
insert into eleve values(seq_eleve2.nextval,'eleve5','1989-10-10',49111900,'2004-10-10','2005-10-10','banoi');

--5
--il est impossible de modifier la valeur de depart de la sequence seq_eleve1 car cette valeur pourrait etre ddeja utilise
--6
alter sequence seq_eleve2 maxvalue 100000;


--partie 5:: SYnonnyme
--1
 create synonym syn_eleve for scott.eleve;
--2
--operatio de selection
select * from syn_eleve;
--operation de modification
update eleve set E_nom='bloum' where E_id=2000;
update eleve set E_nom='bloum1' where E_id=2005;
update eleve set E_nom='bloum2' where E_id=2010;
update eleve set E_nom='bloum3' where E_id=2015;

--operation d insertion
insert into  syn_eleve values(seq_eleve2.nextval,'eleve6','1989-10-10',49111900,'2004-10-10','2005-10-10','banoi');
insert into  syn_eleve values(seq_eleve2.nextval,'eleve7','1989-10-10',49111900,'2004-10-10','2005-10-10','banoi');
insert into  syn_eleve values(seq_eleve2.nextval,'eleve8','1989-10-10',49111900,'2004-10-10','2005-10-10','banoi');
--operation de suppression
delete from eleve where E_id=2010;
delete from eleve where E_id=2015;

--3
drop synonym syn_eleve;

--Partie 6: Dictionnaire de donnnees
--1
--commentaire sur la table eleve
select comment from user_tab_comments where table_name='ELEVE';

--commentaire sur la table inscri^ption
select comment from user_tab_comments where table_name='INSCRIPTION';

--2
--commentaire sur colonne de la table eleve
select comments from user_col_comments where table_name='ELEVE';
--commentaire sur colonne de la table inscription
select comments from user_col_comments where table_name='INSCRIPTION';

--3
select constraint_name,CONSTRAINT_type from user_constraints where table_name='ELEVE';
select constraint_name,CONSTRAINT_type from user_constraints where table_name='INSCRIPTION';
select constraint_name,CONSTRAINT_type from user_constraints where table_name='TRAJET';
select constraint_name,CONSTRAINT_type from user_constraints where table_name='LECON';
select constraint_name,CONSTRAINT_type from user_constraints where table_name='MONITEUR';

--4
select column_name,data_type,data_length from user_tab_columns where table_name='ELEVE';
select column_name,data_type,data_length from user_tab_columns where table_name='INSCRIPTION';
select column_name,data_type,data_length from user_tab_columns where table_name='TRAJET';
select column_name,data_type,data_length from user_tab_columns where table_name='lECON';
select column_name,data_type,data_length from user_tab_columns where table_name='MONITEUR';

--5
select view_name,text from user_views where view_name='MONITEUR_ET_LECONS';
select view_name,text from user_views where view_name='MONITEUR_MIN_HEURES';
select view_name,text from user_views where view_name='ELEVES_A_FAIRE_REPASSER';
select view_name,text from user_views where view_name='ELEVES_A_FAIRE_PASSER';

--6
 select table_name,updatable,insertable,deletable from user_updatable_columns where table_name='MONITEUR_ET_LECONS';
  select table_name,updatable,insertable,deletable from user_updatable_columns where table_name='MONITEUR_MIN_HEURES';
   select table_name,updatable,insertable,deletable from user_updatable_columns where table_name='ELEVES_A_FAIRE_REPASSER';
    select table_name,updatable,insertable,deletable from user_updatable_columns where table_name='ELEVES_A_FAIRE_PASSER';

--7
select min_value,max_value from user_sequences where sequence_name='SEQ_ELEVE1';
select min_value,max_value from user_sequences where sequence_name='SEQ_ELEVE2';

--8
select table_name from user_synonyms where synonym_name='SYN_ELEVE1';
--n afficheras rien car le synonym a ete supprime



