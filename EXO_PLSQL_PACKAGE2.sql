--specification du package
create or replace package package_conduite is
procedure inscrire_conduite(id_eleve eleve.E_ID%type,la_date_inscr inscription.I_date_insc%type:=sysdate,le_type inscription.I_type%type);
procedure inscrire_examen(id_eleve eleve.E_ID%type,la_date_examen  inscription.I_date_examen%type);
procedure resultat_examen(id_eleve eleve.E_ID%type,le_resultat inscription.I_resultat%type);
end package_conduite;
/

--corp du package

create or replace package body package_conduite IS

end package_conduite;
/

create or replace procedure inscrire_conduite1(id_ins inscription.I_id%type,id_eleve eleve.E_ID%type,la_date_inscr inscription.I_date_insc%type,le_type inscription.I_type%type) is 
ELEVE_INCONNU exception;
pragma exception_init(ELEVE_INCONNU,-20001);
PAS_DE_CODE exception;
pragma exception_init(PAS_DE_CODE,-20002);
PB_AGE exception;
pragma exception_init(PB_AGE,-20101);
PB_CONDITION exception;
pragma exception_init(PB_CONDITION,-20003);
DATE_DEJA_PRISE exception;
pragma exception_init(DATE_DEJA_PRISE,-20004);
message varchar(255):=null;
v_test number(1);
v_age number(1);
v_type inscription.I_type%type;
begin
select count(*) into v_test from eleve where E_ID=id_eleve;
if v_test=0 THEN
message:='desole eleve inconnu';
raise ELEVE_INCONNU;
end if;
select count(E_DATE_CODE) into v_test from eleve where E_ID=id_eleve;
if v_test=0 THEN
message:='desole cet eleve n as pas de date';
raise PAS_DE_CODE;
end if;
select trunc(months_between (sysdate,E_DATE_NAISS)/12) into v_age from eleve where E_id=id_eleve;
select I_type into v_type from inscription where E_ID=id_eleve and I_DATE_INSC=(select max(I_DATE_INSC) from inscription where E_id=id_eleve);
if v_age > 18 and v_type='Anticipe' or v_age < 18 and v_type='supervise' THEN
message:='desole age incorrect';
raise PB_AGE;
end if;/*
if v_age > 18 and v_type!='Supervise' or v_age < 18 and v_type='anticipe' THEN
message:='desole condition non respecte';
raise PB_CONDITION;
end if;
select count(I_date_insc) into v_test from inscription where E_ID=id_eleve and I_DATE_insc=(select max(I_DATE_INSC) from inscription where E_ID=id_eleve and I_resultat is null) and i_resultat is null;
if v_test >0 THEN
message:='desole date deja prise ';
raise DATE_DEJA_PRISE;
end if;*/
exception
when ELEVE_INCONNU THEN
RAISE_APPLICATION_ERROR(-20001,message);
when PAS_DE_CODE THEN
RAISE_APPLICATION_ERROR(-20002,message);
when PB_AGE THEN
RAISE_APPLICATION_ERROR(-20101,message);
when PB_CONDITION THEN
RAISE_APPLICATION_ERROR(-20004,message);
when DATE_DEJA_PRISE THEN
RAISE_APPLICATION_ERROR(-20003,message);
end inscrire_conduite1;
/