create database BibliotecaDatabase;
use BibliotecaDatabase;
CREATE TABLE IF NOT EXISTS Biblioteca (
   idBiblioteca INT AUTO_INCREMENT NOT NULL,
   Nome VARCHAR(200) NOT NULL,
   CNPJ VARCHAR(14) NOT NULL UNIQUE,
   Localizacao VARCHAR(200) NOT NULL,
   Telefone VARCHAR(11) NOT NULL,
   Email VARCHAR(100) NOT NULL,
   PRIMARY KEY (idBiblioteca)
);

CREATE TABLE IF NOT EXISTS Livros (
  idLivros INT AUTO_INCREMENT NOT NULL,
  Descricao VARCHAR(255) NOT NULL,
  Escritor VARCHAR(100) NOT NULL,
  DataEntrada DATE NOT NULL,
  Categoria VARCHAR(100) NOT NULL,
  Biblioteca_idBiblioteca INT NOT NULL,
  PRIMARY KEY (idLivros),
  FOREIGN KEY (Biblioteca_idBiblioteca) REFERENCES Biblioteca(idBiblioteca) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Usuarios (
  idUsuarios INT AUTO_INCREMENT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE,
  Telefone VARCHAR(11) NOT NULL,
  Endereco VARCHAR(255) NOT NULL,
  CPF VARCHAR(11) NOT NULL UNIQUE,
  PRIMARY KEY (idUsuarios)
);
CREATE TABLE IF NOT EXISTS Funcionario (
  idFuncionario INT AUTO_INCREMENT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Telefone VARCHAR(11) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  CPF VARCHAR(11) NOT NULL UNIQUE,
  Biblioteca_idBiblioteca INT NOT NULL,
  PRIMARY KEY (idFuncionario),
  FOREIGN KEY (Biblioteca_idBiblioteca) REFERENCES Biblioteca(idBiblioteca) ON DELETE CASCADE
);



CREATE TABLE IF NOT EXISTS Emprestimo (
  Livros_idLivros INT NOT NULL,
  Usuarios_idUsuarios INT NOT NULL,
  DataEmprestimo DATE NOT NULL,
  DataDevolucao DATE GENERATED ALWAYS AS (DataEmprestimo + INTERVAL 10 DAY) STORED,
  PRIMARY KEY (Livros_idLivros, Usuarios_idUsuarios),
  FOREIGN KEY (Livros_idLivros) REFERENCES Livros(idLivros) ON DELETE CASCADE,
  FOREIGN KEY (Usuarios_idUsuarios) REFERENCES Usuarios(idUsuarios) ON DELETE CASCADE
);

-- Inserir dados na tabela Biblioteca
INSERT INTO Biblioteca (Nome, CNPJ, Localizacao, Telefone, Email)
VALUES
  ('Biblioteca Central', '12345678000195', 'Rua Principal, 123, Centro', '12345678901', 'contato@bibliotecacentral.com'),
  ('Biblioteca Municipal', '98765432000100', 'Avenida Secundária, 456, Bairro Novo', '98765432100', 'atendimento@bibliotecamunicipal.com'),
  ('Biblioteca Universitária', '11223344000122', 'Campus Universitário, Bloco A', '11223344556', 'biblioteca@universidade.edu'),
  ('Biblioteca Infantil', '55667788000133', 'Rua das Flores, 789, Jardim das Crianças', '55667788900', 'contato@bibliotecainfantil.com'),
  ('Biblioteca Comunitária', '99887766000144', 'Praça da Paz, 101, Vila Esperança', '99887766554', 'comunidade@bibliotecacomunitaria.com');

-- Inserir dados na tabela Livros
INSERT INTO Livros (Descricao, Escritor, DataEntrada, Categoria, Biblioteca_idBiblioteca)
VALUES
  ('Livro sobre história do Brasil', 'João Silva', '2024-01-15', 'História', 1),
  ('Romance contemporâneo', 'Maria Oliveira', '2023-12-10', 'Ficção', 2),
  ('Manual de programação em Python', 'Carlos Souza', '2024-02-20', 'Tecnologia', 3),
  ('Coleção de poesias infantis', 'Ana Costa', '2023-11-05', 'Infantil', 4),
  ('Guia de jardinagem urbana', 'Paulo Lima', '2024-03-30', 'Jardinagem', 5);

-- Inserir dados na tabela Usuarios
INSERT INTO Usuarios (Nome, Email, Telefone, Endereco, CPF)
VALUES
  ('Lucas Almeida', 'lucas.almeida@email.com', '11987654321', 'Rua das Palmeiras, 100, Centro', '12345678901'),
  ('Fernanda Souza', 'fernanda.souza@email.com', '11987654322', 'Avenida Brasil, 200, Jardim das Flores', '23456789012'),
  ('Carlos Pereira', 'carlos.pereira@email.com', '11987654323', 'Rua das Acácias, 300, Vila Nova', '34567890123'),
  ('Mariana Lima', 'mariana.lima@email.com', '11987654324', 'Praça da Liberdade, 400, Bairro Alegre', '45678901234'),
  ('João Silva', 'joao.silva@email.com', '11987654325', 'Rua do Sol, 500, Jardim Esperança', '56789012345');

-- Inserir dados na tabela Funcionario
INSERT INTO Funcionario (Nome, Telefone, Email, CPF, Biblioteca_idBiblioteca)
VALUES
  ('Paulo Santos', '11987654326', 'paulo.santos@bibliotecacentral.com', '67890123456', 1),
  ('Cláudia Ferreira', '11987654327', 'claudia.ferreira@bibliotecamunicipal.com', '78901234567', 1),
  ('Roberto Almeida', '11987654328', 'roberto.almeida@universidade.edu', '89012345678', 1),
  ('Juliana Costa', '11987654329', 'juliana.costa@bibliotecainfantil.com', '90123456789', 1),
  ('Ricardo Lima', '11987654330', 'ricardo.lima@bibliotecacomunitaria.com', '01234567890', 1);
delete from Funcionario;
-- Inserir dados na tabela Emprestimo
INSERT INTO Emprestimo (Livros_idLivros, Usuarios_idUsuarios, DataEmprestimo)
VALUES
  (1, 1, '2024-01-20'),
  (2, 2, '2023-12-15'),
  (3, 3, '2024-02-25'),
  (4, 4, '2023-11-10'),
  (5, 5, '2024-04-05');

-- livros ordenados por tecnologia
SELECT U.Nome, E.DataEmprestimo, L.Descricao
FROM Usuarios U
JOIN Emprestimo E ON U.idUsuarios = E.Usuarios_idUsuarios
JOIN Livros L ON E.Livros_idLivros = L.idLivros
WHERE L.Categoria = 'Tecnologia';

-- livros por ordem de entrada
SELECT Descricao, DataEntrada
FROM Livros
ORDER BY DataEntrada DESC;

-- contagem de emprestimos
SELECT L.Descricao, COUNT(E.Livros_idLivros) AS Emprestimos
FROM Livros L
LEFT JOIN Emprestimo E ON L.idLivros = E.Livros_idLivros
GROUP BY L.Descricao
ORDER BY Emprestimos DESC;


-- Biblioteca com mais de 2 funcionários
SELECT b.Nome AS NomeBiblioteca, COUNT(f.idFuncionario) AS NumeroFuncionarios
FROM Biblioteca b
JOIN Funcionario f ON b.idBiblioteca = f.Biblioteca_idBiblioteca
GROUP BY b.Nome
HAVING COUNT(f.idFuncionario) > 2;

SELECT * FROM Livros
ORDER BY Descricao ASC;



