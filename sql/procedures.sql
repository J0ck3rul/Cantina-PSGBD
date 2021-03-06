-- drop procedure INSERTINGREDIENTSCANTITY;
CREATE OR REPLACE PROCEDURE Update_Ingredients_Cantity(ID_INGREDIENT IN number_list, CANTITY IN number_list)
AS
    v_size      number;
    v_i         number;
    v_cantitate number;
BEGIN
    v_size := ID_INGREDIENT.COUNT;
--     dbms_output.put_line(v_size);
    for v_i in 1..v_size
        loop
            update INGREDIENTE set CANTITATE_INGREDIENT = CANTITY(v_i) where ID_INGREDIENT = v_i;
--     dbms_output.put_line(v_size);
        end loop;
END Update_Ingredients_Cantity;
/
CREATE OR REPLACE PROCEDURE Update_Ingredient_Cantity(ID IN number, CANTITY IN number)
AS

BEGIN

    update INGREDIENTE
    set CANTITATE_INGREDIENT = CANTITY
    where ID_INGREDIENT = ID;
END Update_Ingredient_Cantity;
/
CREATE OR REPLACE PROCEDURE GENERATE_MENU
AS
    cursor lista_produse is select distinct *
                            from produse p
                            order by (select count(nume)
                                      from produse p
                                               join INGREDIENTELEPRODUSELOR I2 on p.ID_PRODUS = I2.ID_PRODUS) /
                                     p.PRET asc ;
    v_number number;
    v_index  number := 1;
    v_start  number := 1;
    v_end    number := 10;
BEGIN
    for produs in lista_produse
        loop
            v_number := GET_NUMBER_OF_PRODUCTS(produs.ID_PRODUS);
--             dbms_output.put_line(v_number);
            if (v_number > 0) then
                insert into meniu(ID, ID_PRODUS, CANTITATE) VALUES (v_index, produs.ID_PRODUS, v_number);
                v_index := v_index+1;
            end if;
        end loop;
END GENERATE_MENU;
/
/
create or replace procedure updateMenu(idProdus number)
as
begin
        update MENIU set CANTITATE = CANTITATE -1 where idProdus = ID_PRODUS;
end updateMenu;
/
create or replace procedure InsertOrder(idUutilizator number, idComanda number)
as
begin
    insert into COMANDA(ID_COMANDA, ID_UTILIZATOR) values (idComanda, idUutilizator);
end;
/
create or replace procedure AddProductIntoOrder(id_produs number, id_comanda number)
as
     v_count number;
begin
     select count(*) + 1 into v_count from PRODUSECOMANDATE;
    insert into PRODUSECOMANDATE(ID_PRODUSE_COMANDATE, ID_COMANDA, ID_PRODUS) values (v_count , id_comanda,id_produs);
end;
