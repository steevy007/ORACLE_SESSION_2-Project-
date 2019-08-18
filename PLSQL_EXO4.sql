create or replace procedure inscrire_examen(idI inscription.I_id%type,idE inscription.E_id%type,typeI inscription.I_type%type,dateI inscription.I_date_insc%type,dateE inscription.I_date_examen%type,resultat inscription.I_resultat%type,num inscription.I_num%type,dateE1 inscription.I_date_examen%type) is
ELEVE_INCONNU exception;
PB_AGE exception;
PB_CONDITION exception;
DATE_DEJA_PRISE exception;
v_long number(1);
v_id VARCHAR(20);
v_test1 number(1);
v_age  number(2);
n_ldure lecon.L_duree%type;
n_nbkm trajet.t_nb_km%type;
v_dateE inscription.I_date_insc%type;
v_type inscription.I_type%type;
BEGIN
select coltype into v_id  from col where tname='INSCRIPTION' and cname='I_ID' ;
select count(*) into v_test1 from inscription where I_id=idI ;
select length(idI) into v_long from dual;
select trunc(months_between (sysdate,E_date_naiss)/12) into v_age from eleve where E_id=idE;
select sum(L_duree) into n_ldure from lecon where E_ID=idE;
select sum(t_nb_km) into n_nbkm from trajet where E_ID=idE;
select max(I_date_examen) into v_dateE from inscription where E_id=idE;
select distinct(I_type)  into v_type from inscription where E_id=idE;
if v_id != 'NUMBER' or v_long > 4 or v_test1=1 or idI is null THEN
raise ELEVE_INCONNU;
elsif v_age < 18 then 
raise PB_AGE;
elsif n_ldure <20 or n_ldure is null  and n_nbkm <=1000 or n_nbkm is null and v_type='Supervise'   THEN
Raise PB_CONDITION;
if v_dateE is null THEN
update inscription set I_date_Examen=dateE1 where E_id=idE;
else
raise DATE_DEJA_PRISE;
end if;
else
INSERT into inscription values(idI,idE,typeI,dateI,dateE,resultat,num);
dbms_output.put_line(' Inscription reussi ');
end if;
exception 
when ELEVE_INCONNU THEN
dbms_output.put_line(' identifiant incorrect ');
when PB_AGE THEN
dbms_output.put_line(' age incorrect ');
when PB_CONDITION THEN
dbms_output.put_line(' Condition non respectee ');
when DATE_DEJA_PRISE THEN
dbms_output.put_line(' date examen deja prise ');
end;
/
execute inscrire_examen(6789,9095,'Anticipe','2010-10-10','2011-11-11',67,2,'');
--creation de la table archive
create table Archive(
    E_id number(4),
    E_prenom VARCHAR(30),
    E_date_dossier date,
    E_date_code date,
    E_nb_km number(3,1),
    E_nbh_lecon number(3),
    a_nb_passagers number(4),
    a_date_prem_exam date,
    a_date_obtention date
);
