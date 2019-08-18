create  procedure resultat_examen(idE inscription.E_id%type) IS
v_test inscription.I_resultat%type;
E_data eleve%rowtype;
v_nbh lecon.l_duree%type;
v_nbkm trajet.T_nb_km%type;
v_nbpass number(4);
v_dateprem inscription.I_date_examen%type;
v_dateobt inscription.I_date_examen%type;
v_nb_incrp number(1);
BEGIN
select count(*) into v_nb_incrp from inscription where E_id=idE;
select max(I_resultat) into v_test from inscription where  E_id=idE and I_date_examen=(select max(I_date_examen) from inscription where E_id=idE);
select * into E_data from eleve where E_id=idE;
select count(distinct(m_id)) into v_nbpass  from lecon where E_id=0;
select sum(l_duree) into v_nbh from lecon where E_id=idE;
select sum(T_nb_km) into v_nbkm from trajet where E_id=idE;
select min(I_date_examen) into v_dateprem from inscription where E_id=idE and I_resultat <65;
select max(I_date_examen) into v_dateobt from inscription where E_id=idE;
dbms_output.put_line('resultat '||v_test);
if v_test >=65 THEN
insert into archive values(E_data.E_id,E_data.E_prenom,E_data.E_date_dossier,E_data.E_date_code,v_nbkm,v_nbh,v_nbpass,v_dateprem,v_dateobt,E_data.E_nom);
delete from trajet where E_id=idE;
delete from inscription where E_id=idE;
delete from lecon where E_id=idE;
dbms_output.put_line(' donnee archive avec succes ');
elsif v_test < 65 and v_nb_incrp > 5 THEN
update eleve set E_date_code='' where E_id=idE;
dbms_output.put_line(' Eleve non reussi renitialisation de la date code ');
ELSE
update inscription set I_resultat='' where E_id=idE;
dbms_output.put_line(' eleve echoue renitialisation du resulat ');
end if;
end;
/