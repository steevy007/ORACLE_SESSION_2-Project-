create or replace trigger MAJ_ELEVE before insert or update on eleve for each row begin
:NEW.E_nom:=UPPER(:NEW.E_nom);
:NEW.E_prenom:=UPPER(:NEW.E_prenom);
if inserting and :NEW.E_DATE_DOSSIER is null THEN
:NEW.E_DATE_DOSSIER:=sysdate;
end if;
if updating and :NEW.E_DATE_DOSSIER is null THEN

end if;
end;
/