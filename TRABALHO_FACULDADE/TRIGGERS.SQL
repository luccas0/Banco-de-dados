/*
Gatilho que permite a alteração da tabela t_cliente entre as seis da manhã de meia-noite.
*/

create or replace trigger horario before update on t_cliente
begin

if to_char (sysdate, 'HH24') not between '06' and '18' then
RAISE_APPLICATION_ERROR(-20205, 'Não é permitido alterar essa tabela a partir desse horário!');
end if;
end horario;

update t_cliente set ds_senha = 'oqwjd8*#$#123'
where cd_cliente = 3;

select * from t_cliente;

CREATE TABLE t_cliente (
    cd_cliente     NUMBER(5) NOT NULL,
    nm_cliente     VARCHAR2(50) NOT NULL,
    ds_email       VARCHAR2(100) NOT NULL,
    ds_genero      VARCHAR2(100),
    ds_senha       VARCHAR2(100) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    nr_telefone    NUMBER(11),
    ds_cpf         VARCHAR2(11) NOT NULL
);

CREATE TABLE armazenamento_dados (cd_cliente number(5),
nm_cliente varchar2(50),
ds_email varchar2(100),
ds_genero varchar2(100),
ds_senha varchar2(100),
dt_nascimento date,
nr_telefone number(11),
ds_cpf number(11));

/*
Gatilho que realiza as operações de INSERT em uma entidade associativa.
*/
create or replace trigger verifica_cliente after insert or update or delete on t_cliente for each row
declare

begin

if inserting then

insert into armazenamento_dados (cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha,
dt_nascimento, nr_telefone, ds_cpf) values (:new.cd_cliente, :new.nm_cliente, :new.ds_email, 
:new.ds_genero, :new.ds_senha, :new.dt_nascimento, :new.nr_telefone, :new.ds_cpf);

elsif updating then

insert into armazenamento_dados (cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha,
dt_nascimento, nr_telefone, ds_cpf) values (:old.cd_cliente, :new.nm_cliente, :new.ds_email, 
:new.ds_genero, :new.ds_senha, :old.dt_nascimento, :new.nr_telefone, :old.ds_cpf);

elsif deleting then

insert into armazenamento_dados (cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha,
dt_nascimento, nr_telefone, ds_cpf) values (:old.cd_cliente, :new.nm_cliente, :new.ds_email, 
:new.ds_genero, :new.ds_senha, :new.dt_nascimento, :new.nr_telefone, :new.ds_cpf);

end if;

end verifica_cliente;

insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(4,'Ana Silva', 'ana@rmorl.com', 'F', 'oqipd8*#$#','01012120', 11235517333, 12142238744 );

update t_cliente set nm_cliente ='Paulo henrique', ds_email ='paulo123@rmail.com' , ds_genero='M',
ds_senha='654987#$*&', dt_nascimento ='14051985', nr_telefone=11966666666, ds_cpf =10945612345
where cd_cliente = 2;

delete from t_cliente where cd_cliente  = 4;

select * from t_cliente;
select * from armazenamento_dados;
