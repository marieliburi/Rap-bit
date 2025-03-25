-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19/11/2024 às 01:43
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `elon_musk`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `aluno`
--

CREATE TABLE `aluno` (
  `ID_Aluno` int(11) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `COD_Matricula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `aluno`
--

INSERT INTO `aluno` (`ID_Aluno`, `ID_Usuario`, `COD_Matricula`) VALUES
(1, 1, 'MAT2024-001'),
(2, 2, 'MAT2024-002'),
(3, 3, 'MAT2024-003'),
(4, 4, 'MAT2024-004'),
(5, 5, 'MAT2024-005'),
(35, 104, 'MAT2024-006'),
(36, 105, '20240001'),
(37, 106, '20240002');

--
-- Acionadores `aluno`
--
DELIMITER $$
CREATE TRIGGER `GerarMatriculaAluno` BEFORE INSERT ON `aluno` FOR EACH ROW BEGIN
    DECLARE AnoAtual VARCHAR(4);
    DECLARE UltimaMatricula INT;
    
    -- Obter o ano atual
    SET AnoAtual = YEAR(CURDATE());
    
    -- Obter o último número de matrícula gerado
    SELECT MAX(CAST(SUBSTRING(COD_Matricula, 5, 4) AS UNSIGNED)) 
    INTO UltimaMatricula
    FROM aluno
    WHERE COD_Matricula LIKE CONCAT(AnoAtual, '%');
    
    -- Se não houver matrícula para o ano atual, iniciar com 0001
    IF UltimaMatricula IS NULL THEN
        SET UltimaMatricula = 0;
    END IF;
    
    -- Gerar a nova matrícula (incrementa o número sequencial)
    SET NEW.COD_Matricula = CONCAT(AnoAtual, LPAD(UltimaMatricula + 1, 4, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `aula`
--

CREATE TABLE `aula` (
  `ID_Aula` int(11) NOT NULL,
  `Titulo_Aula` varchar(100) NOT NULL,
  `Descricao` text DEFAULT NULL,
  `Link_Video` varchar(255) DEFAULT NULL,
  `ID_Curso` int(11) DEFAULT NULL,
  `ID_Professor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `curso`
--

CREATE TABLE `curso` (
  `ID_Curso` int(11) NOT NULL,
  `Nome_Curso` varchar(100) NOT NULL,
  `Descricao` text DEFAULT NULL,
  `ID_Professor` int(11) DEFAULT NULL,
  `Qtd_Alunos` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `curso`
--

INSERT INTO `curso` (`ID_Curso`, `Nome_Curso`, `Descricao`, `ID_Professor`, `Qtd_Alunos`) VALUES
(3, 'Criação Inteligente: Conteúdos e Vídeos com ChatGPT e D-ID', NULL, 12, 0),
(4, 'Trabalhar com grandes volumes de dados utilizando IA', NULL, 12, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `inscricao`
--

CREATE TABLE `inscricao` (
  `ID_Inscricao` int(11) NOT NULL,
  `Data_Inscricao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ID_Aluno` int(11) DEFAULT NULL,
  `ID_Curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inscricao`
--

INSERT INTO `inscricao` (`ID_Inscricao`, `Data_Inscricao`, `ID_Aluno`, `ID_Curso`) VALUES
(133, '2024-11-18 23:09:20', 36, 3),
(134, '2024-11-18 23:10:30', 36, 4),
(135, '2024-11-18 23:12:17', 5, 3),
(136, '2024-11-18 23:12:52', 37, 3),
(137, '2024-11-18 23:13:07', 37, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `material`
--

CREATE TABLE `material` (
  `ID_Material` int(11) NOT NULL,
  `Nome_Arquivo` varchar(100) NOT NULL,
  `Link_Arquivo` varchar(255) DEFAULT NULL,
  `ID_Curso` int(11) DEFAULT NULL,
  `ID_Professor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `professor`
--

CREATE TABLE `professor` (
  `ID_Professor` int(11) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `professor`
--

INSERT INTO `professor` (`ID_Professor`, `ID_Usuario`) VALUES
(12, 108);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `ID_Usuario` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telefone` varchar(15) DEFAULT NULL,
  `Data_Nascimento` varchar(11) DEFAULT NULL,
  `Senha` varchar(255) NOT NULL,
  `Data_Cadastro` timestamp NOT NULL DEFAULT current_timestamp(),
  `Tipo` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`ID_Usuario`, `Nome`, `Email`, `Telefone`, `Data_Nascimento`, `Senha`, `Data_Cadastro`, `Tipo`) VALUES
(1, 'João Silva', 'joao@example.com', '11987654321', '2001-02-15', 'senhaSegura123', '2024-11-16 15:05:51', 0),
(2, 'Maria Oliveira', 'maria.oliveira@example.com', '21998765432', '2002-04-20', 'senhaSegura456', '2024-11-16 15:06:39', 0),
(3, 'Carlos Souza', 'carlos.souza@example.com', '31987654321', '1999-08-12', 'senhaSegura789', '2024-11-16 15:06:39', 0),
(4, 'Ana Ferreira', 'ana.ferreira@example.com', '41976543210', '2000-12-01', 'senhaSegura101', '2024-11-16 15:06:39', 0),
(5, 'Roberto Lima', 'roberto.lima@example.com', '51987654321', '2003-06-30', 'senhaSegura202', '2024-11-16 15:06:39', 0),
(6, 'Felphes', 'lipao.gamer@example.com', '71987654321', '1975-09-20', 'senhaSegura303', '2024-11-16 15:10:22', 0),
(7, 'Nelso', 'notzin.ascendente@example.com', '62987654321', '1980-05-12', 'senhaSegura404', '2024-11-16 15:10:22', 0),
(104, 'teste', 'teste@gmail.com', '1231', '1111-11-11', '123', '2024-11-18 18:31:31', 0),
(105, 'teste123', 'testeinscricao@gmail.com', '121', '0001-11-11', '123', '2024-11-18 22:28:53', 0),
(106, 'testein', 'testefinalinscricao@gmail.com', '12', '0011-11-11', '123', '2024-11-18 23:12:45', 0),
(108, 'Felipe', 'professorum@gmail.com', '123', '0011-11-11', '123', '2024-11-18 23:40:41', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `aluno`
--
ALTER TABLE `aluno`
  ADD PRIMARY KEY (`ID_Aluno`),
  ADD UNIQUE KEY `COD_Matricula` (`COD_Matricula`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Índices de tabela `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`ID_Aula`),
  ADD KEY `ID_Curso` (`ID_Curso`),
  ADD KEY `ID_Professor` (`ID_Professor`);

--
-- Índices de tabela `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`ID_Curso`),
  ADD KEY `ID_Professor` (`ID_Professor`);

--
-- Índices de tabela `inscricao`
--
ALTER TABLE `inscricao`
  ADD PRIMARY KEY (`ID_Inscricao`),
  ADD UNIQUE KEY `ID_Aluno` (`ID_Aluno`,`ID_Curso`),
  ADD KEY `ID_Curso` (`ID_Curso`);

--
-- Índices de tabela `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`ID_Material`),
  ADD KEY `ID_Curso` (`ID_Curso`),
  ADD KEY `ID_Professor` (`ID_Professor`);

--
-- Índices de tabela `professor`
--
ALTER TABLE `professor`
  ADD PRIMARY KEY (`ID_Professor`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID_Usuario`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `aluno`
--
ALTER TABLE `aluno`
  MODIFY `ID_Aluno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de tabela `aula`
--
ALTER TABLE `aula`
  MODIFY `ID_Aula` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `curso`
--
ALTER TABLE `curso`
  MODIFY `ID_Curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `inscricao`
--
ALTER TABLE `inscricao`
  MODIFY `ID_Inscricao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT de tabela `material`
--
ALTER TABLE `material`
  MODIFY `ID_Material` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `professor`
--
ALTER TABLE `professor`
  MODIFY `ID_Professor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `aluno`
--
ALTER TABLE `aluno`
  ADD CONSTRAINT `aluno_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`) ON DELETE CASCADE;

--
-- Restrições para tabelas `aula`
--
ALTER TABLE `aula`
  ADD CONSTRAINT `aula_ibfk_1` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `aula_ibfk_2` FOREIGN KEY (`ID_Professor`) REFERENCES `professor` (`ID_Professor`) ON DELETE CASCADE;

--
-- Restrições para tabelas `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`ID_Professor`) REFERENCES `professor` (`ID_Professor`) ON DELETE CASCADE;

--
-- Restrições para tabelas `inscricao`
--
ALTER TABLE `inscricao`
  ADD CONSTRAINT `inscricao_ibfk_1` FOREIGN KEY (`ID_Aluno`) REFERENCES `aluno` (`ID_Aluno`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscricao_ibfk_2` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`) ON DELETE CASCADE;

--
-- Restrições para tabelas `material`
--
ALTER TABLE `material`
  ADD CONSTRAINT `material_ibfk_1` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `material_ibfk_2` FOREIGN KEY (`ID_Professor`) REFERENCES `professor` (`ID_Professor`) ON DELETE CASCADE;

--
-- Restrições para tabelas `professor`
--
ALTER TABLE `professor`
  ADD CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
