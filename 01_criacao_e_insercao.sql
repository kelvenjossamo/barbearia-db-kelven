-- =====================================================
-- Base de dados: Barbearia (marcações e serviços)
-- Autor: Kelven Jossamo Gulane | Tecnologias de Base de Dados
-- SGBD: MySQL / MariaDB
-- =====================================================
DROP DATABASE IF EXISTS barbearia;
CREATE DATABASE barbearia CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE barbearia;

CREATE TABLE cliente (
  id_cliente   INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(80)  NOT NULL,
  telefone     VARCHAR(15)  NOT NULL UNIQUE,
  email        VARCHAR(80),
  data_registo DATE         NOT NULL
);

CREATE TABLE barbeiro (
  id_barbeiro   INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(80) NOT NULL,
  telefone      VARCHAR(15) NOT NULL UNIQUE,
  especialidade VARCHAR(40) NOT NULL,
  data_admissao DATE        NOT NULL
);

CREATE TABLE servico (
  id_servico  INT AUTO_INCREMENT PRIMARY KEY,
  nome        VARCHAR(50)   NOT NULL UNIQUE,
  preco       DECIMAL(8,2)  NOT NULL CHECK (preco > 0),
  duracao_min INT           NOT NULL CHECK (duracao_min > 0)
);

CREATE TABLE utilizador (
  id_utilizador INT AUTO_INCREMENT PRIMARY KEY,
  username      VARCHAR(30)  NOT NULL UNIQUE,
  senha_hash    VARCHAR(64)  NOT NULL,
  perfil        ENUM('admin','barbeiro','cliente') NOT NULL,
  id_cliente    INT NULL,
  id_barbeiro   INT NULL,
  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_barbeiro) REFERENCES barbeiro(id_barbeiro)
);

CREATE TABLE marcacao (
  id_marcacao INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente  INT NOT NULL,
  id_barbeiro INT NOT NULL,
  data_hora   DATETIME NOT NULL,
  estado      ENUM('agendada','concluida','cancelada') NOT NULL DEFAULT 'agendada',
  observacoes VARCHAR(120),
  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_barbeiro) REFERENCES barbeiro(id_barbeiro),
  UNIQUE (id_barbeiro, data_hora)
);

-- Entidade fraca: um item só existe dentro de uma marcação
CREATE TABLE item_marcacao (
  id_marcacao    INT NOT NULL,
  num_item       INT NOT NULL,
  id_servico     INT NOT NULL,
  preco_aplicado DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (id_marcacao, num_item),
  FOREIGN KEY (id_marcacao) REFERENCES marcacao(id_marcacao),
  FOREIGN KEY (id_servico)  REFERENCES servico(id_servico)
);

INSERT INTO cliente (nome, telefone, email, data_registo) VALUES
('Armando Machava','841000100','armando1@email.co.mz','2026-01-01'),
('Beatriz Sitoe','841008019','beatriz2@email.co.mz','2026-02-04'),
('Carlos Tembe','841015938','carlos3@email.co.mz','2026-03-07'),
('Dulce Mabunda','841023857','dulce4@email.co.mz','2026-04-10'),
('Edson Cossa','841031776','edson5@email.co.mz','2026-05-13'),
('Fátima Chongo','841039695','fatima6@email.co.mz','2026-06-16'),
('Gil Nhaca','841047614','gil7@email.co.mz','2026-07-19'),
('Helena Massingue','841055533','helena8@email.co.mz','2026-08-22'),
('Ivan Bila','841063452','ivan9@email.co.mz','2026-09-25'),
('Joana Mucavele','841071371','joana10@email.co.mz','2026-01-28'),
('Luís Macuácua','841079290','luis11@email.co.mz','2026-02-03'),
('Marta Zandamela','841087209','marta12@email.co.mz','2026-03-06'),
('Nelson Mondlane','841095128','nelson13@email.co.mz','2026-04-09'),
('Olga Mavie','841103047','olga14@email.co.mz','2026-05-12'),
('Paulo Chissano','841110966','paulo15@email.co.mz','2026-06-15'),
('Quitéria Langa','841118885','quiteria16@email.co.mz','2026-07-18'),
('Rui Matsinhe','841126804','rui17@email.co.mz','2026-08-21'),
('Sara Uamusse','841134723','sara18@email.co.mz','2026-09-24'),
('Tiago Manhiça','841142642','tiago19@email.co.mz','2026-01-27'),
('Ubaldina Nhantumbo','841150561','ubaldina20@email.co.mz','2026-02-02'),
('Vasco Muianga','841158480','vasco21@email.co.mz','2026-03-05'),
('Zélia Cumbe','841166399','zelia22@email.co.mz','2026-04-08');

INSERT INTO barbeiro (nome, telefone, especialidade, data_admissao) VALUES
('Abel Guambe','822000200','Corte clássico','2018-01-15'),
('Bruno Tivane','822006351','Degradê','2019-02-15'),
('Cláudio Sumbana','822012502','Barba','2020-03-15'),
('Domingos Chaúque','822018653','Corte infantil','2021-04-15'),
('Elias Mahumane','822024804','Degradê','2022-05-15'),
('Filipe Nhamitambo','822030955','Coloração','2023-06-15'),
('Gaspar Uaiene','822037106','Corte clássico','2024-07-15'),
('Hélio Cuamba','822043257','Barba','2025-08-15'),
('Inácio Magaia','822049408','Penteados','2018-09-15'),
('Jaime Sigaúque','822055559','Degradê','2019-10-15'),
('Kelton Mandlate','822061710','Corte clássico','2020-11-15'),
('Lázaro Bambo','822067861','Barba','2021-12-15'),
('Moisés Tamele','822074012','Coloração','2022-01-15'),
('Nuno Pondja','822080163','Penteados','2023-02-15'),
('Osvaldo Come','822086314','Degradê','2024-03-15'),
('Pedro Sitole','822092465','Corte infantil','2025-04-15'),
('Quintino Alface','822098616','Corte clássico','2018-05-15'),
('Ricardo Massango','822104767','Barba','2019-06-15'),
('Sérgio Fumo','822110918','Degradê','2020-07-15'),
('Tomás Vilanculos','822117069','Penteados','2021-08-15');

INSERT INTO servico (nome, preco, duracao_min) VALUES
('Corte simples',150.00,30),
('Corte degradê',200.00,40),
('Barba completa',100.00,20),
('Aparar barba',70.00,15),
('Corte infantil',120.00,25),
('Coloração',350.00,60),
('Alisamento',400.00,70),
('Tranças',500.00,90),
('Massagem capilar',180.00,20),
('Hidratação capilar',250.00,30),
('Sobrancelha',50.00,10),
('Relaxamento',300.00,45),
('Lavagem',60.00,10),
('Corte + barba',250.00,50),
('Penteado de festa',450.00,60),
('Desenho no cabelo',220.00,35),
('Remoção de risco',80.00,15),
('Tratamento anticaspa',280.00,30),
('Pacote noivo',900.00,120),
('Limpeza de pele',320.00,40);

-- senha_hash: valores fictícios (num sistema real usar password_hash/bcrypt)
INSERT INTO utilizador (username, senha_hash, perfil, id_cliente, id_barbeiro) VALUES
('admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','admin',NULL,NULL),
('barb_abel','c7be6520f5874c7b10da4ab84afa61fbc910db3b82015b9143d0a191f7ae6e8f','barbeiro',NULL,1),
('barb_bruno','f0e5bd233e721a9e011ab801d0103cd2a228db9223904e5543d905eeec0bb763','barbeiro',NULL,2),
('barb_cláudio','93f3b056c8327b4eca8623d3ea931ae08afcfbe67e4eeb08161796f6d6bff56c','barbeiro',NULL,3),
('barb_domingos','6364cad78e39ca4c17ae7c575b2bd2d360f73526be3c630642961d6e311830ca','barbeiro',NULL,4),
('barb_elias','baef215990f98112f4dfc6a0c9206b180d067c8eaa915ced33627c4ae94f92ee','barbeiro',NULL,5),
('cli_armando','1e3563b9b59cf3a8725341ff14eafafce85c2122be36fccdac15015f40803f7f','cliente',1,NULL),
('cli_beatriz','73d154575e8e0020bddc582d2a6efb099faf4a1747010655b39bfb07c7310e51','cliente',2,NULL),
('cli_carlos','3a131c57e6298597526c71b90ad9ccaeee53f44fe40dca7ded6d87af4781fff9','cliente',3,NULL),
('cli_dulce','744c5ff05d6376452836dff7caefb8173a49e07263b24544ec5912b7c258a52a','cliente',4,NULL),
('cli_edson','a5004c8f0c1ad4196db322db19bad21671a46043dd05c1838fa95d086d92a14a','cliente',5,NULL),
('cli_fatima','4804747a6569dcc303769ca408636936b1c72937612603fd1a7085dd11d8a7a9','cliente',6,NULL),
('cli_gil','6f0dfe6a9f87383237e9086549bbe27ee6b319ce975be790a3ad05128c2d5ac1','cliente',7,NULL),
('cli_helena','9b512d0857ab61739e7bc6e3974bf7768fdcde00c742a1c8e4669e71779a46d0','cliente',8,NULL),
('cli_ivan','1f4a721ba022daa44b025832ce19e75e5d536bf6d2844864df9a82798a4d3f4d','cliente',9,NULL),
('cli_joana','0921c9d53218b79882485ab7af997b7a318b42291c0e1b25fde7e9bb65b5d9c0','cliente',10,NULL),
('cli_luis','dd2ae4e0c5fe181ffecaa9e757ea3390886443538c0883bb4cf2342ab842efb9','cliente',11,NULL),
('cli_marta','a930ec218fdf984c2d1e99f4a6062040e5ddbed2e1f42f2a547c049a02cb7bdb','cliente',12,NULL),
('cli_nelson','0e142c70361cffc4600c87762f30edc36ba5b879d30e63b4e598836e80566273','cliente',13,NULL),
('cli_olga','10736d43899656640190720d6f1fc0d55be3bb19e5e23b38b734060fec23a748','cliente',14,NULL),
('recepcao','1c3ae5382d9c463da74914d715ff1bdee926784de699a0a9e391403e5a1f7201','admin',NULL,NULL);

INSERT INTO marcacao (id_cliente, id_barbeiro, data_hora, estado, observacoes) VALUES
(1,1,'2026-09-01 08:00:00','concluida',NULL),
(6,8,'2026-09-02 09:00:00','concluida','Cliente pediu corte mais curto'),
(11,15,'2026-09-03 10:00:00','concluida','Primeira visita'),
(16,2,'2026-09-04 11:00:00','concluida','Prefere atendimento rápido'),
(21,9,'2026-09-05 12:00:00','concluida',NULL),
(4,16,'2026-09-06 13:00:00','concluida','Cliente pediu corte mais curto'),
(9,3,'2026-09-07 14:00:00','concluida','Primeira visita'),
(14,10,'2026-09-08 15:00:00','concluida','Prefere atendimento rápido'),
(19,17,'2026-09-09 16:00:00','concluida',NULL),
(2,4,'2026-09-10 08:00:00','concluida','Cliente pediu corte mais curto'),
(7,11,'2026-09-11 09:00:00','concluida','Primeira visita'),
(12,18,'2026-09-12 10:00:00','concluida','Prefere atendimento rápido'),
(17,5,'2026-09-13 11:00:00','concluida',NULL),
(22,12,'2026-09-14 12:00:00','concluida','Cliente pediu corte mais curto'),
(5,19,'2026-10-21 08:00:00','agendada','Primeira visita'),
(10,6,'2026-10-22 09:00:00','agendada','Prefere atendimento rápido'),
(15,13,'2026-10-23 10:00:00','agendada',NULL),
(20,20,'2026-10-24 11:00:00','agendada','Cliente pediu corte mais curto'),
(3,7,'2026-10-25 12:00:00','agendada','Primeira visita'),
(8,14,'2026-10-26 13:00:00','agendada','Prefere atendimento rápido'),
(13,1,'2026-10-27 10:00:00','cancelada',NULL),
(18,8,'2026-10-28 10:00:00','cancelada','Cliente pediu corte mais curto'),
(1,15,'2026-10-15 09:00:00','concluida','Primeira visita'),
(6,2,'2026-10-16 10:00:00','concluida','Prefere atendimento rápido');

INSERT INTO item_marcacao (id_marcacao, num_item, id_servico, preco_aplicado) VALUES
(1,1,9,180.00),
(2,1,12,300.00),
(3,1,15,450.00),
(3,2,20,320.00),
(4,1,18,280.00),
(5,1,1,150.00),
(6,1,4,70.00),
(6,2,9,180.00),
(7,1,7,400.00),
(8,1,10,250.00),
(9,1,13,60.00),
(9,2,18,280.00),
(10,1,16,220.00),
(11,1,19,900.00),
(12,1,2,200.00),
(12,2,7,400.00),
(13,1,5,120.00),
(14,1,8,500.00),
(15,1,11,50.00),
(15,2,16,220.00),
(16,1,14,250.00),
(17,1,17,80.00),
(18,1,20,320.00),
(18,2,5,120.00),
(19,1,3,100.00),
(20,1,6,350.00),
(21,1,9,180.00),
(21,2,14,250.00),
(22,1,12,300.00),
(23,1,15,450.00),
(24,1,18,280.00),
(24,2,3,100.00);
