
create database db_locadora_noite;

create sequence sequence_id_sexo;
create table tb_sexos(
	sex_id smallint not null default nextval('sequence_id_sexo'),
	sex_nome varchar(10) not null,
	sex_sigla char(1) not null,
	constraint pk_sexo primary key(sex_id),
	constraint uk_sigla unique(sex_sigla)
);


insert into tb_sexos
(sex_sigla, sex_nome)
values
('M','MASCULINO'),
('F', 'FEMININO');


select * from tb_sexos 

create sequence sequence_id_ufs;
create table tb_ufs(
ufs_id smallint not null default nextval('sequence_id_ufs'),
ufs_nome varchar(30) not null,
ufs_sigla char(2) not null,
constraint pk_uf primary key(ufs_id),
constraint uk_siglas unique(ufs_sigla)
);



insert into tb_ufs 
(ufs_nome, ufs_sigla) 
values 
('Rio Grande do Norte', 'RN'), ('Paraíba', 'PB'), ('Recife', 'PE');

select * from tb_ufs 

-- CIDADES
create sequence sequence_id_cidade;
create table tb_cidades(
cid_id smallint not null default nextval('sequence_id_cidade'),
cid_nome varchar(30) not null,
cid_ufs_id smallint,
constraint pk_cidade primary key(cid_id),
constraint fk_ufs_cid foreign key(cid_ufs_id) references tb_ufs(ufs_id)
on update cascade on delete cascade
);


insert into tb_cidades
(cid_ufs_id, cid_nome)
values
(1, 'Natal'), (1, 'Mossoró'), 
(2, 'João Pessoa'), (2, 'Campina Grande'), 
(3, 'Recife');

select * from tb_cidades 

drop sequence sequence_id_bairro;

-- BAIRROS
create sequence sequence_id_bairro;
create table tb_bairros(
bai_id int not null default nextval('sequence_id_bairro'),
bai_nome varchar(50) not null,
bai_cid_id smallint,
constraint pk_bairro primary key(bai_id),
constraint fk_cid_bai foreign key(bai_cid_id) references tb_cidades(cid_id)
on update cascade on delete cascade
);

drop table tb_cidades;
drop table tb_bairros 

insert into tb_bairros
(bai_cid_id, bai_nome)
values
(1, 'Lagoa Azul'), (1, 'Cidade Alta'), 
(2, 'Alto de São Manoel'), 
(3, 'Centro'),
(4, 'Palmeira');


-- CEPS

create table tb_ceps(
cep_id char(8) not null,
cep_logradouro varchar(60),
cep_bai_id int,
constraint pk_cep primary key(cep_id),
constraint fk_bai_cep foreign key(cep_bai_id) references tb_bairros(bai_id)
on update cascade on delete cascade
);


insert into tb_ceps
	(cep_id, cep_bai_id, cep_logradouro)
values
	('59138520', 1, 'Rua Patativa do Assaré'),
    ('59025000', 1, 'Avenida Rio Branco'),
    ('59650000', null, null),
    ('59500000', 3, 'Avenida Central'),
    ('58620000', 5,'Rua Praia de Cabedelo');
   
   
   
   select * from tb_ceps;
  
   
     
   

create sequence sequence_id_cliente;
create table tb_clientes(
	cli_id bigint not null default nextval('sequence_id_cliente'),
	cli_nome varchar(80) not null,
	cli_cpf char(11) not null,
	cli_data_nascimento date not null,
	cli_logradouro varchar(60),
    cli_numero varchar(10),
    cli_complemento varchar(20),
    cli_sex_id smallint,
    cli_cep_id char(8) not null,
	constraint pk_cliente primary key(cli_id),
    constraint uk_cpf unique(cli_cpf),
    constraint fk_sex_cli foreign key(cli_sex_id) references tb_sexos(sex_id)
    on update cascade on delete cascade,
    constraint fk_cep_cli foreign key(cli_cep_id) references tb_ceps(cep_id)
    on update cascade on delete cascade
);


insert into tb_clientes
(cli_nome, cli_cpf, cli_data_nascimento, cli_logradouro, cli_numero, cli_complemento, cli_sex_id, cli_cep_id)
values
('Wescley Bezerra', '12445697898', '2000-01-17', 'Rua Patativa do Assaré', '1982', 'Nova Natal', 1, '59138520'),
('José Maria', '39445997898', '1999-02-27', 'Rua da Fosforitas', '19', 'Gramoré', 1, '59025000'),
('Joana da Silva', '55845569825', '1973-02-13', 'Rua Desconhecida', 's/n', 'Lot. José Sarney', 2, '59650000'),
('Maria DB', '87459697800', '2000-05-02', 'Av. Principal', '82', 'Soledade', 2, '59500000');


select * from tb_clientes; 


create table tb_fones_clientes(
	fdc_cli_id bigint not null,
	fdc_fone varchar(12) not null,
	constraint pf_fone_cliente primary key(fdc_cli_id, fdc_fone),
	constraint fk_cli_fdc foreign key(fdc_cli_id)
	references tb_clientes(cli_id)
	on update cascade on delete cascade
);


insert into tb_fones_clientes
(fdc_cli_id, fdc_fone)
values
(1, '84984578956'),
(1, '32226032'), (3, 8432232228);


select * from tb_fones_clientes 

drop database db_locadora_noite; 
