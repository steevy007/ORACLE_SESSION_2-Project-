--specification package
create  package gestion_inscription1 is 
procedure affich_inscription;
function lister_inscription  return number;
PROCEDURE lister_inscr_id(id inscription.I_id%type);
procedure insert_inscr(id inscription.I_ID%type,idE inscription.E_id%type,typeI inscription.I_TYPE%type,dateI inscription.I_DATE_INSC%type,dateE inscription.I_DATE_EXAMEN%type,resultat inscription.I_resultat%type,num inscription.I_num%type);
PROCEDURE supp_inscr_id(id inscription.I_id%type);
procedure mod_inscr(id1 inscription.I_ID%type,id inscription.I_ID%type,idE inscription.E_id%type,typeI inscription.I_TYPE%type,dateI inscription.I_DATE_INSC%type,dateE inscription.I_DATE_EXAMEN%type,resultat inscription.I_resultat%type,num inscription.I_num%type);
end gestion_inscription1;
/

--package body
create or replace package body gestion_inscription1 IS

procedure affich_inscription IS
cursor affich is select * from inscription;
begin
for v_data in affich
loop
dbms_output.put_line(' numero inscription => '||v_data.E_id||' numero Etudiant=> '||v_data.E_ID||' type inscription => '||v_data.I_TYPE||' date inscription => '||v_data.I_DATE_INSC||' date examen => '||v_data.I_DATE_EXAMEN||' resulta => '||v_data.I_resultat||' numero => '||v_data.I_num);
end loop;
end affich_inscription;

function  lister_inscription return number is
nb number(2);
BEGIN
select count(*) into nb from inscription;
return nb;
end lister_inscription;

procedure lister_inscr_id(id inscription.I_id%type) IS
v_data inscription%rowtype;
begin
select * into v_data from inscription where I_id=id;
dbms_output.put_line(' numero inscription => '||v_data.I_ID||' numero eleve => '||v_data.E_ID||' type inscription => '||v_data.I_TYPE||' date inscription => '||v_data.I_DATE_INSC||' date examen => '||v_data.I_DATE_EXAMEN||' resultat => '||v_data.I_resultat||' numero => '||v_data.I_NUM);
exception 
when no_data_found THEN
dbms_output.put_line(' aucune donnee trouve ');
end lister_inscr_id;

procedure insert_inscr(id inscription.I_ID%type,idE inscription.E_id%type,typeI inscription.I_TYPE%type,dateI inscription.I_DATE_INSC%type,dateE inscription.I_DATE_EXAMEN%type,resultat inscription.I_resultat%type,num inscription.I_num%type) is 
begin 
insert into inscription values(id,idE,typeI,dateI,dateE,resultat,num);
if SQL%ROWCOUNT >0 THEN
dbms_output.put_line(' insertion reussi ');
ELSE
dbms_output.put_line(' echec d''insertion ');
end if;
exception
when DUP_VAL_ON_INDEX THEN
dbms_output.put_line(' duplication de la cle primaire ');
end insert_inscr;

PROCEDURE supp_inscr_id(id inscription.I_id%type) is 
BEGIN
delete from inscription where I_ID=id;
if SQL%ROWCOUNT >0 THEN
dbms_output.put_line(' suppression reussi ');
else
dbms_output.put_line(' echec de suppression ');
end if;
end supp_inscr_id;


procedure mod_inscr(id1 inscription.I_ID%type,id inscription.I_ID%type,idE inscription.E_id%type,typeI inscription.I_TYPE%type,dateI inscription.I_DATE_INSC%type,dateE inscription.I_DATE_EXAMEN%type,resultat inscription.I_resultat%type,num inscription.I_num%type) is 
v_test number(1);
BEGIN
select count(*) into v_test from inscription where I_id=id1;
if v_test = 0 THEN
dbms_output.put_line('id incorrect');
ELSE
IF id is not null THEN
dbms_output.put_line('desole champ non modifiable');
else
if typeI is not null THEN
update inscription set I_type=typeI where I_id=id1;
dbms_output.put_line(' type inscription modifier avec succes');
end if;
if dateI is not null THEN
update inscription set I_DATE_INSC=dateI where I_id=id1;
dbms_output.put_line('date inscription modifier avec succes');
end if;
if dateE is not null THEN
update inscription set I_DATE_EXAMEN=dateE where I_id=id1;
dbms_output.put_line(' date examen modifier avec succes');
end if;
if resultat is not null THEN
update inscription set I_resultat=resultat where I_id=id1;
dbms_output.put_line('resulat modifier avec succes');
end if;
if num is not null THEN
update inscription set I_num=num where I_id=id1;
dbms_output.put_line('numero modifier avec succes');
end if;
end if;
end if;
end mod_inscr;
end gestion_inscription1;
/

 