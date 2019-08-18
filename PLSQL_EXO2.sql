accept numero prompt 'Veuillez saisir l ''identifiant de l eleve a modifier :';
accept num prompt 'Veuillez saisir le nouvel identifiant de l eleve :';
accept nom prompt 'Veuillez saisir le nouveau nom de l eleve :';
accept prenom prompt 'Veuillez saisir le nouveau prenom de l eleve :';
accept dateN prompt 'Veuillez saisir la nouvelle date de naissance de l eleve :';
accept tel prompt 'Veuillez saisir le nouveau numero de l eleve :';
accept dateD prompt 'Veuillez saisir le nouveau date dossier de l eleve :';
accept dateC prompt 'Veuillez saisir la nouvelle date code de l eleve:';
DECLARE
v_numero eleve.E_id%type:=&numero;
v_num varchar(255):='&num';
v_nom eleve.E_nom%type:='&nom';
v_prenom eleve.E_prenom%type:='&prenom';
v_dateN eleve.E_date_naiss%type:='&dateN';
v_tel eleve.E_tel%type:='&tel';
v_dateD eleve.E_date_dossier%type:='&dateD';
v_dateC eleve.E_date_code%type:='&dateC';
 v_testNum number(1);
v_data eleve%rowtype;
BEGIN
select count(*) into v_testNum from eleve where E_id=v_numero;
if v_testNum=1 THEN
select * into v_data.E_id,v_data.E_nom,v_data.E_date_naiss,v_data.E_tel,v_data.E_date_dossier,v_data.E_date_code,v_data.E_prenom from eleve where E_id=v_numero;
if v_num is not null then
dbms_output.put_line(chr(10)||'Desole ce champ est non modifiable'||chr(10));
end if;
if v_nom is not null THEN
update Eleve set E_nom=v_nom where E_id=v_numero;
dbms_output.put_line('la propriete Nom est passe de : '||v_data.E_nom||' a '||v_nom);
end if;
if v_dateN is not null THEN
update Eleve set E_prenom=v_prenom where E_id=v_numero;
dbms_output.put_line('la propriete prenom est passe de : '||v_data.E_prenom||' a '||v_prenom);
end if;
if v_dateN is not null THEN
update Eleve set E_date_naiss=v_dateN where E_id=v_numero;
dbms_output.put_line('la propriete date naissance est passe de : '||v_data.E_date_naiss||' a '||v_dateN);
end if;
if v_tel is not null THEN
update eleve set E_tel=v_tel where E_id=v_numero;
dbms_output.put_line('la propriete telephone est passe de : '||v_data.E_tel||' a '||v_tel);
end if;
if v_dateD is not null THEN
update eleve set E_date_dossier=v_dateD where E_id=v_numero;
dbms_output.put_line('la propriete date dossier est passe de : '||v_data.E_date_dossier||' a '||v_dateD);
end if;
if v_dateC is not null THEN
update eleve set E_date_code=v_dateC where E_id=v_numero;
dbms_output.put_line('la propriete date Code est passe de : '||v_data.E_date_code||' a '||v_dateC);
end if;
else
dbms_output.put_line(chr(10)||'Desole numero Inexsistant'||chr(10));
end if;
END;
/