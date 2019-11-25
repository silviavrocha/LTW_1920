PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- Table: Agenda
DROP TABLE IF EXISTS Agenda;

CREATE TABLE Agenda (
    dataInicio DATE PRIMARY KEY,
    dataFim DATE 
);

-- Table: Pais
DROP TABLE IF EXISTS Pais;

CREATE TABLE Pais (
    idPais      INTEGER PRIMARY KEY,
    nome    VARCHAR(15) UNIQUE NOT NULL 
);

-- Table: Cidade
DROP TABLE IF EXISTS Cidade;

CREATE TABLE Cidade (
    idCidade      INTEGER PRIMARY KEY,
    nome    VARCHAR(15) NOT NULL, 
    idPais    INTEGER REFERENCES Pais (idPais) 
);

-- Table: Utilizador
DROP TABLE IF EXISTS Utilizador;

CREATE TABLE Utilizador (
    idUtilizador    INTEGER PRIMARY KEY,
    hashedPassword TEXT NOT NULL,
    primeiroNome    VARCHAR(30) NOT NULL, 
    ultimoNome    VARCHAR(30) NOT NULL, 
    dataNascimento  DATE        NOT NULL, 
    email           VARCHAR(30) UNIQUE NOT NULL, 
    telefone        VARCHAR(15) UNIQUE NOT NULL, 
    idPais          INTEGER REFERENCES Pais (idPais) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Table: Cliente
DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (
    idCliente  INTEGER REFERENCES Utilizador(idUtilizador)  ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(idCliente)
);


-- Table: Anfitriao
DROP TABLE IF EXISTS Anfitriao;

CREATE TABLE Anfitriao (
    idAnfitriao INTEGER REFERENCES Utilizador(idUtilizador)  ON DELETE CASCADE ON UPDATE CASCADE,
    classificacaoAnfitriao INTEGER CHECK(classificacaoAnfitriao >= 1 AND classificacaoAnfitriao <= 5),
    PRIMARY KEY(idAnfitriao)
);

-- Table: Reserva
DROP TABLE IF EXISTS Reserva;

CREATE TABLE Reserva (
    idReserva          INTEGER PRIMARY KEY, 
    dataCheckIn DATE    NOT NULL,
    dataCheckOut DATE   NOT NULL,
    numHospedes INTEGER CHECK (numHospedes > 0), 
    precoTotal  REAL    CHECK (precoTotal > 0), 
    idEstado INTEGER REFERENCES Estado(idEstado) ON DELETE CASCADE ON UPDATE CASCADE,
    idHabitacao   INTEGER REFERENCES Habitacao (idHabitacao),
    UNIQUE (dataCheckIn, idHabitacao)
);

DROP TABLE IF EXISTS Estado;

CREATE TABLE Estado (
    idEstado      INTEGER PRIMARY KEY,                 
    estado  CHAR(9) UNIQUE NOT NULL
);

insert into Estado(idEstado,estado) values(0,"Em espera");
insert into Estado(idEstado,estado) values(1,"Concluida");
insert into Estado(idEstado,estado) values(2,"Comentado");
insert into Estado(idEstado,estado) values(3,"Cancelado");

-- Table: Cancelamento
DROP TABLE IF EXISTS Cancelamento;

CREATE TABLE Cancelamento (
    reembolso   INTEGER     NOT NULL, 
    idReserva     INTEGER REFERENCES Reserva (idReserva)  ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(idReserva)
);

-- Table: ClassificacaoPorCliente
DROP TABLE IF EXISTS ClassificacaoPorCliente;

CREATE TABLE ClassificacaoPorCliente (
    limpeza     INTEGER CHECK(limpeza >= 1 AND limpeza <= 5), 
    valor       INTEGER CHECK(valor >= 1 AND valor <= 5),
    checkIn     INTEGER CHECK(checkIn >= 1 AND checkIn <= 5),
    localizacao INTEGER CHECK(localizacao >= 1 AND localizacao <= 5),
    outros      VARCHAR(500) DEFAULT 'Nao preenchido', 
    idReserva INTEGER REFERENCES Reserva (idReserva) ON DELETE RESTRICT ON UPDATE RESTRICT, 
    PRIMARY KEY (idReserva)
);

-- Table: Comodidade
DROP TABLE IF EXISTS Comodidade;

CREATE TABLE Comodidade (
    idComodidade      INTEGER PRIMARY KEY,
    nome    VARCHAR(15) UNIQUE NOT NULL
);

-- Table: Efetua
DROP TABLE IF EXISTS Efetua;

CREATE TABLE Efetua (
    idCliente INTEGER REFERENCES Cliente(idCliente) ON DELETE CASCADE ON UPDATE CASCADE, 
    idReserva INTEGER REFERENCES Reserva(idReserva) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(idReserva)
);

-- Table: TipoDeHabitacao
DROP TABLE IF EXISTS TipoDeHabitacao;

CREATE TABLE TipoDeHabitacao (
    idTipo   INTEGER PRIMARY KEY,
    nome VARCHAR(30) UNIQUE NOT NULL
);

insert into TipoDeHabitacao(idTipo,nome) values (1,"Apartamento");
insert into TipoDeHabitacao(idTipo,nome) values (2,"Casa");
insert into TipoDeHabitacao(idTipo,nome) values (3,"Bungalow");
insert into TipoDeHabitacao(idTipo,nome) values (4,"Tenda");
insert into TipoDeHabitacao(idTipo,nome) values (5,"Quarto de Hotel");
insert into TipoDeHabitacao(idTipo,nome) values (6,"Quarto Privado");
insert into TipoDeHabitacao(idTipo,nome) values (7,"Quarto Partilhado");
insert into TipoDeHabitacao(idTipo,nome) values (8,"Hostel");

-- Table: PoliticaDeCancelamento
DROP TABLE IF EXISTS PoliticaDeCancelamento;

CREATE TABLE PoliticaDeCancelamento (
    idPolitica          INTEGER PRIMARY KEY,
    nome        VARCHAR(25) UNIQUE NOT NULL, 
    descricao   VARCHAR(500) NOT NULL, 
    percentagemReembolso INTEGER CHECK (percentagemReembolso >= 0 AND percentagemReembolso <= 1)
);

insert into PoliticaDeCancelamento(idPolitica, nome, descricao, percentagemReembolso) values(1,"Flexivel", " Reembolso total das taxas de alojamento e limpeza.", 1);
insert into PoliticaDeCancelamento(idPolitica, nome, descricao, percentagemReembolso) values(2,"Moderada", "Reembolso de 50% das taxas de alojamento e limpeza.", 0.5);
insert into PoliticaDeCancelamento(idPolitica, nome, descricao, percentagemReembolso) values(3,"Rigida", "Reembolso de 25% das taxas de alojamento e limpeza.",0.25);
insert into PoliticaDeCancelamento(idPolitica, nome, descricao, percentagemReembolso) values(4,"Super Rigida", "Nao reembolsavel", 0);

-- Table: Habitacao
DROP TABLE IF EXISTS Habitacao;

CREATE TABLE Habitacao (
    idHabitacao INTEGER PRIMARY KEY,
    nome        TEXT,
    numQuartos  INTEGER CHECK (numQuartos > 0), 
    maxHospedes INTEGER CHECK (maxHospedes > 0), 
    morada      VARCHAR(250) UNIQUE NOT NULL, 
    precoNoite  REAL    CHECK (precoNoite > 0), 
    taxaLimpeza REAL CHECK (taxaLimpeza >= 0), 
    classificacaoHabitacao INTEGER  CHECK(classificacaoHabitacao >= 1 AND classificacaoHabitacao <= 5), 
    idCidade      INTEGER REFERENCES Cidade (idCidade) ON DELETE CASCADE ON UPDATE CASCADE, 
    idTipo        INTEGER REFERENCES TipoDeHabitacao (idTipo) ON DELETE SET NULL ON UPDATE CASCADE, 
    idPolitica    INTEGER REFERENCES PoliticaDeCancelamento (idPolitica) ON DELETE RESTRICT ON UPDATE CASCADE,
    descricao   TEXT
);

-- Table: Disponivel
DROP TABLE IF EXISTS Disponivel;

CREATE TABLE Disponivel (
    idHabitacao   INTEGER REFERENCES Habitacao (idHabitacao)  ON DELETE CASCADE ON UPDATE CASCADE, 
    data        DATE REFERENCES Agenda (data)  ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idHabitacao, data)
);

-- Table: Dispoe
DROP TABLE IF EXISTS Dispoe;

CREATE TABLE Dispoe (
    idComodidade  INTEGER REFERENCES Comodidade (idComodidade) ON DELETE CASCADE ON UPDATE CASCADE, 
    idHabitacao   INTEGER REFERENCES Habitacao (idHabitacao) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY (idComodidade, idHabitacao)
);

-- Table: Favorito
DROP TABLE IF EXISTS Favorito;

CREATE TABLE Favorito (
    idCliente     INTEGER REFERENCES Cliente (idCliente) ON DELETE CASCADE ON UPDATE CASCADE, 
    idHabitacao   INTEGER REFERENCES Habitacao (idHabitacao) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY (idCliente, idHabitacao)
);

-- Table: Fotografia
DROP TABLE IF EXISTS Imagem;

CREATE TABLE Imagem (
    urlImagem   VARCHAR(20) PRIMARY KEY, 
    legenda TEXT,
    idHabitacao   INTEGER REFERENCES Habitacao(idHabitacao) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Table: Possui
DROP TABLE IF EXISTS Possui;

CREATE TABLE Possui (
    idAnfitriao   INTEGER REFERENCES Anfitriao (idAnfitriao) ON DELETE CASCADE ON UPDATE CASCADE, 
    idHabitacao   INTEGER REFERENCES Habitacao (idHabitacao) ON DELETE CASCADE ON UPDATE CASCADE, 
    PRIMARY KEY (idHabitacao)
);

COMMIT TRANSACTION;