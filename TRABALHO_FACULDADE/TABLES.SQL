set serveroutput on;
set verify off;

CREATE TABLE t_admin_mercado (
    cd_admin_mercado  NUMBER(4) NOT NULL,
    cd_mercado        NUMBER(3) NOT NULL,
    ds_email          VARCHAR2(100) NOT NULL,
    ds_senha          VARCHAR2(100) NOT NULL
);

SELECT * FROM t_cliente;



CREATE UNIQUE INDEX t_admin_mercado__idx ON
    t_admin_mercado (
        cd_mercado
    ASC );

ALTER TABLE t_admin_mercado ADD CONSTRAINT pk_t_admin_mercado PRIMARY KEY ( cd_admin_mercado );

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



ALTER TABLE t_cliente ADD CONSTRAINT pk_t_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE t_cliente ADD CONSTRAINT un_ds_email UNIQUE ( ds_email
                                                         );

ALTER TABLE t_cliente ADD CONSTRAINT un_ds_cpf UNIQUE ( ds_cpf );

CREATE TABLE t_corredor (
    cd_corredor           NUMBER(3) NOT NULL,
    in_sessao_corredor    CHAR(1) NOT NULL,
    cd_setor              NUMBER(3) NOT NULL,
    nr_corredor           NUMBER(2) NOT NULL,
    dt_cadastro_corredor  DATE NOT NULL
);





ALTER TABLE t_corredor ADD CONSTRAINT pk_t_corredor PRIMARY KEY ( cd_corredor,
                                                                  in_sessao_corredor );

CREATE TABLE t_descricao_setor (
    nr_descricao_setor  NUMBER(2) NOT NULL,
    nm_descricao_setor  VARCHAR2(50) NOT NULL
);



ALTER TABLE t_descricao_setor ADD CONSTRAINT pk_t_descricao_setor PRIMARY KEY ( nr_descricao_setor );

CREATE TABLE t_lista (
    cd_lista           NUMBER(6) NOT NULL,
    cd_cliente         NUMBER(5) NOT NULL,
    cd_produtos        NUMBER(4) NOT NULL,
    vl_total_produtos  FLOAT(10) NOT NULL,
    qt_produtos        NUMBER(2) NOT NULL
);



ALTER TABLE t_lista
    ADD CONSTRAINT ck_qt_produtos CHECK ( qt_produtos > 0
                                          AND qt_produtos < 70 );

ALTER TABLE t_lista
    ADD CONSTRAINT pk_t_lista PRIMARY KEY ( cd_lista,
                                            cd_cliente,
                                            cd_produtos );

CREATE TABLE t_mercado (
    cd_mercado           NUMBER(3) NOT NULL,
    cd_admin_mercado     NUMBER(4) NOT NULL,
    nm_mercado           VARCHAR2(50) NOT NULL,
    ds_endereco          VARCHAR2(100) NOT NULL,
    ds_mercado           VARCHAR2(100),
    dt_cadastro_mercado  DATE NOT NULL
);



CREATE UNIQUE INDEX t_mercado__idx ON
    t_mercado (
        cd_admin_mercado
    ASC );

ALTER TABLE t_mercado ADD CONSTRAINT pk_t_mercado PRIMARY KEY ( cd_mercado );

CREATE TABLE t_produtos (
    cd_produtos         NUMBER(4) NOT NULL,
    cd_corredor         NUMBER(3) NOT NULL,
    in_sessao_corredor  CHAR(1) NOT NULL,
    nm_produtos         VARCHAR2(50) NOT NULL,
    vl_produtos         FLOAT(10) NOT NULL,
    tp_produtos         VARCHAR2(50) NOT NULL
);



ALTER TABLE t_produtos ADD CONSTRAINT pk_t_produtos PRIMARY KEY ( cd_produtos );

CREATE TABLE t_setor (
    cd_setor            NUMBER(3) NOT NULL,
    cd_mercado          NUMBER(3) NOT NULL,
    nr_descricao_setor  NUMBER(2) NOT NULL,
    nm_setor            VARCHAR2(50) NOT NULL,
    ds_setor            VARCHAR2(100),
    dt_cadastro_setor   DATE NOT NULL
);



CREATE UNIQUE INDEX t_setor__idx ON
    t_setor (
        nr_descricao_setor
    ASC );

ALTER TABLE t_setor ADD CONSTRAINT pk_t_setor PRIMARY KEY ( cd_setor );

ALTER TABLE t_admin_mercado
    ADD CONSTRAINT fk_mercado_admin_mercado FOREIGN KEY ( cd_mercado )
        REFERENCES t_mercado ( cd_mercado );


ALTER TABLE t_lista
    ADD CONSTRAINT fk_t_cliente_lista FOREIGN KEY ( cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_produtos
    ADD CONSTRAINT fk_t_corredor_produtos FOREIGN KEY ( cd_corredor,
                                                        in_sessao_corredor )
        REFERENCES t_corredor ( cd_corredor,
                                in_sessao_corredor );

ALTER TABLE t_setor
    ADD CONSTRAINT fk_t_desc_setor FOREIGN KEY ( nr_descricao_setor )
        REFERENCES t_descricao_setor ( nr_descricao_setor );

ALTER TABLE t_setor
    ADD CONSTRAINT fk_t_mercado_setor FOREIGN KEY ( cd_mercado )
        REFERENCES t_mercado ( cd_mercado );

ALTER TABLE t_lista
    ADD CONSTRAINT fk_t_produtos_lista FOREIGN KEY ( cd_produtos )
        REFERENCES t_produtos ( cd_produtos );

ALTER TABLE t_corredor
    ADD CONSTRAINT fk_t_setor_corredor FOREIGN KEY ( cd_setor )
        REFERENCES t_setor ( cd_setor );

-- tabela t_cliente
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(1,'João Pedro', 'joao@rmail.com', 'M', '1233214!@#$','22121997', 11965465465, 12345678978 );
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(2,'Paulo henrique', 'paulo@rmail.com', 'M', '654987#$*&','14051985', 11966666666, 78945612345 );
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(3,'Maria clara', 'maria@rmail.com', 'F', 'oqwjd8*#$#','01012000', 11945613254, 11122233345 );
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(0,'Maria clara', 'maria@rmuil.com', 'F', 'oqwjd8*#$#','01012000', 11945613333, 11122234444 );





-- tabela t_descricao_setor
insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(1,'Bolachas e biscoitos');

insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(2,'Laticínios e derivados');

insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(3,'Massas e grãos');

insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(0,'Bebidas');








-- tabela t_mercado
insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(1,1,'Dia Av Paulista', 'Avenida Paulista nr 2','Mercado localisado na av paulista simples e completo', '20052022');

insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(2,2,'Extra da Lapa', 'Rua josé inácio 123','Hipermercado localizado na Lapa', '22052022');

insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(3,3,'Carrefour na aclimação', 'rua da aclimação numero 72','Mercado localizado na aclimação com todos os produtos que precisa', '20052022');

insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(0,0,'Carrefour na aclimação', 'rua da aclimação numero 72','Mercado localizado na aclimação com todos os produtos que precisa', '20052022');




--tabela t_admin_mercado
insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(1,1,'diamercadopaulista@email.com','123456789123124');

insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(2,2,'dmercadolapa@email.com','12awdasd45wd7ad');

insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(3,3,'mercadoaclimacao@email.com','123456adwda@#!@$d');

insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(0,0,'mercadocarrefour@email.com','123456agoid@#!@$d');

-- tabela t_setor

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(1,1,1,'Bolachas e biscoitos','Setor destinado a bolachas e biscoitos', '20052022');

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(2,1,2,'Laticínios e Derivados','Setor destinado a Laticínios e seus derivados', '22052022');

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(3,1,3,'Massas e grãos','Setor destinado a Massas, grãos e seus derivados', '20052022');

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(0,1,0,'Bebidas','Setor destinado a Bbidas e seus derivados', '20052022');






-- teabela t_corredor
insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(1,'A',1,1,'20052022');

insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(2,'B',2,6,'22052022');

insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(3,'C',3,5,'22052022');

insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(0,'F',3,5,'22052022');





--tabela t_produtos
insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(1,1,'A','Bolacha maizena', 2.45,'bolachas e biscoitos');

insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(2,2,'B','Requeijão aviação', 7.85,'Laticínios e derivados');

insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(3,3,'C','Macarrão vitarella', 5.45,'Massas e grãos');

insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(0,0,'F','Suco de laranja', 5.45,'Bebidas');





--tabela t_lista

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(1,1,1,3.85, 1);

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(2,2,2,7.85, 1);

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(3,3,3,5.45, 1);

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(0,0,0,5.45, 1);


UPDATE t_cliente 
SET nm_cliente = 'José ricardo' 
WHERE cd_cliente = 1;

update t_produtos set vl_produtos = 8.99
where cd_produtos = 3;

update t_setor set ds_setor = 'Setor destinado a produtos perecíveis'
where cd_setor = 1;

delete from t_lista where cd_cliente = 1;

delete from t_cliente where cd_cliente = 1;

delete from t_produtos where cd_produtos = 1;

select vl_produtos, nr_corredor , dt_cadastro_corredor, nm_setor, ds_setor from t_produtos pd inner join t_corredor cd on
pd.cd_corredor = cd.cd_corredor inner join  t_setor s on cd.cd_setor = s.cd_setor  order by nr_corredor;
