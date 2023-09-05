-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-08-22 00:30:18.682

-- tables
-- Table: Cliente
CREATE TABLE Cliente (
    cli_id integer  NOT NULL,
    nome varchar2(255)  NOT NULL,
    CONSTRAINT Cliente_pk PRIMARY KEY (cli_id)
) ;

-- Table: Peca
CREATE TABLE Peca (
    pec_id integer  NOT NULL,
    descricao varchar2(255)  NOT NULL,
    valor number(18,2)  NOT NULL,
    quantidade integer  NOT NULL,
    CONSTRAINT Peca_pk PRIMARY KEY (pec_id)
) ;

-- Table: Pedido
CREATE TABLE Pedido (
    ped_id integer  NOT NULL,
    data date  NOT NULL,
    valor number(18,2)  NOT NULL,
    Cliente_cli_id integer  NOT NULL,
    CONSTRAINT Pedido_pk PRIMARY KEY (ped_id)
) ;

-- Table: Pedido_Peca
CREATE TABLE Pedido_Peca (
    Pedido_ped_id integer  NOT NULL,
    Peca_pec_id integer  NOT NULL,
    quantidade integer  NULL,
    valor number(18,2)  NULL,
    CONSTRAINT Pedido_Peca_pk PRIMARY KEY (Pedido_ped_id,Peca_pec_id)
) ;

-- foreign keys
-- Reference: Pedido_Cliente (table: Pedido)
ALTER TABLE Pedido ADD CONSTRAINT Pedido_Cliente
    FOREIGN KEY (Cliente_cli_id)
    REFERENCES Cliente (cli_id);

-- Reference: Pedido_Peca_Peca (table: Pedido_Peca)
ALTER TABLE Pedido_Peca ADD CONSTRAINT Pedido_Peca_Peca
    FOREIGN KEY (Peca_pec_id)
    REFERENCES Peca (pec_id);

-- Reference: Pedido_Peca_Pedido (table: Pedido_Peca)
ALTER TABLE Pedido_Peca ADD CONSTRAINT Pedido_Peca_Pedido
    FOREIGN KEY (Pedido_ped_id)
    REFERENCES Pedido (ped_id);

-- sequences
-- Sequence: Cliente_seq
CREATE SEQUENCE Cliente_seq
      INCREMENT BY 1
      NOMINVALUE
      NOMAXVALUE
      START WITH 1
      NOCACHE
      NOCYCLE;

-- Sequence: Peca_seq
CREATE SEQUENCE Peca_seq
      INCREMENT BY 1
      NOMINVALUE
      NOMAXVALUE
      START WITH 1
      NOCACHE
      NOCYCLE;

-- Sequence: Pedido_seq
CREATE SEQUENCE Pedido_seq
      INCREMENT BY 1
      NOMINVALUE
      NOMAXVALUE
      START WITH 1
      NOCACHE
      NOCYCLE;

-- End of file.

