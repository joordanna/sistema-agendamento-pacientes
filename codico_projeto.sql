CREATE DATABASE sistema_pacientes_fisio;
USE sistema_pacientes_fisio;


CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    data_nascimento DATE
);

CREATE TABLE fisioterapeuta (
    id_fisio INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    crefito VARCHAR(20) NOT NULL UNIQUE,
    especialidade VARCHAR(45)
);

CREATE TABLE consulta (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_consulta DATE NOT NULL,
    horario TIME NOT NULL,
    id_fisio INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_fisio) REFERENCES fisioterapeuta(id_fisio) ON DELETE CASCADE,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE
);

CREATE TABLE historico_atendimento (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    observacao TEXT,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP, -- a data será inserida automaticamente seguindo  sistema
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta) ON DELETE CASCADE
);

-- para limitar o número de consultas por paciente
DELIMITER //
CREATE TRIGGER limite_consultas BEFORE INSERT ON consulta
FOR EACH ROW
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM consulta WHERE id_paciente = NEW.id_paciente;
    IF total >= 15 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Limite de 15 consultas atingido para este paciente';
    END IF;
END;
//
DELIMITER ;

USE sistema_pacientes_fisio;

-- inserção da tabela paciente
INSERT INTO paciente (nome, telefone, data_nascimento) VALUES
('Aaliyah', '11990010001', '1990-01-01'),
('Hadassah', '11990010002', '1985-05-12'),
('Josh', '11990010003', '2000-03-22'),
('Asaf', '11990010004', '1992-07-15'),
('Leah', '11990010005', '1988-11-30'),
('Ethan', '11990010006', '2002-06-18'),
('Naomi', '11990010007', '1993-02-28'),
('Micah', '11990010008', '1999-12-05'),
('Abigail', '11990010009', '1987-08-20'),
('Caleb', '11990010010', '1991-04-10'),
('Miriam', '11990010011', '1994-09-09'),
('Daniel', '11990010012', '1986-03-17'),
('Sarah', '11990010013', '2001-01-25'),
('Benjamin', '11990010014', '1998-10-11'),
('Esther', '11990010015', '1992-12-02');

-- inserção da tabela fisioterapeuta
INSERT INTO fisioterapeuta (nome, crefito, especialidade) VALUES
('Joshua', 'CRE1001', 'Gerontologia'),
('Malia', 'CRE1002', 'Traumato-Ortopédica'),
('Serena', 'CRE1003', 'Neurofuncional');

-- =================================================
-- INSERÇÃO DE CONSULTAS E HISTÓRICOS (45 consultas)
-- Cada paciente tem 3 consultas
-- Pacientes 1-5 -> Joshua (id_fisio = 1)
-- Pacientes 6-10 -> Malia (id_fisio = 2)
-- Pacientes 11-15 -> Serena (id_fisio = 3)
-- Datas: 22/09/2025 - 22/10/2025, apenas dias úteis
-- Horários: 07:00 - 12:00
-- Observação: 70% chance de 'compareceu', 30% 'não compareceu'
-- =================================================

/* ---------- Paciente 1 (id_paciente = 1) -> Joshua (id_fisio = 1) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-22', '07:30:00', 1, 1);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-29', '09:00:00', 1, 1);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-06', '11:15:00', 1, 1);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


/* ---------- Paciente 2 (id_paciente = 2) -> Joshua (id_fisio = 1) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-23', '08:15:00', 1, 2);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-30', '10:00:00', 1, 2);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-07', '07:45:00', 1, 2);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


/* ---------- Paciente 3 (id_paciente = 3) -> Joshua (id_fisio = 1) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-24', '09:30:00', 1, 3);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-01', '08:00:00', 1, 3);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-08', '10:10:00', 1, 3);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

/* ---------- Paciente 4 (id_paciente = 4) -> Joshua (id_fisio = 1) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-25', '07:50:00', 1, 4);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-02', '09:20:00', 1, 4);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-09', '11:00:00', 1, 4);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

/* ---------- Paciente 5 (id_paciente = 5) -> Joshua (id_fisio = 1) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-26', '08:10:00', 1, 5);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-03', '09:45:00', 1, 5);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-10', '10:30:00', 1, 5);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

/* ---------- Paciente 6 (id_paciente = 6) -> Malia (id_fisio = 2) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-22', '07:45:00', 2, 6);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-29', '09:15:00', 2, 6);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-06', '11:00:00', 2, 6);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


/* ---------- Paciente 7 (id_paciente = 7) -> Malia (id_fisio = 2) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-23', '08:00:00', 2, 7);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-30', '10:20:00', 2, 7);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-07', '07:30:00', 2, 7);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


/* ---------- Paciente 8 (id_paciente = 8) -> Malia (id_fisio = 2) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-24', '09:45:00', 2, 8);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-01', '08:30:00', 2, 8);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-08', '10:00:00', 2, 8);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


/* ---------- Paciente 9 (id_paciente = 9) -> Malia (id_fisio = 2) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-25', '07:50:00', 2, 9);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-02', '09:10:00', 2, 9);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-09', '11:30:00', 2, 9);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


/* ---------- Paciente 10 (id_paciente = 10) -> Malia (id_fisio = 2) ---------- */
INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-09-26', '08:20:00', 2, 10);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-03', '09:40:00', 2, 10);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));

INSERT INTO consulta (data_consulta, horario, id_fisio, id_paciente)
VALUES ('2025-10-10', '10:50:00', 2, 10);

INSERT INTO historico_atendimento (id_consulta, observacao)
VALUES (LAST_INSERT_ID(), IF(RAND() < 0.7, 'compareceu', 'não compareceu'));


-- Consultas

-- pacientes e suas consultas, agrupados por fisioterapeutas, em ordem cronológica.
    
SELECT 
    f.nome AS fisioterapeuta,
    p.nome AS paciente,
    GROUP_CONCAT(
        DATE_FORMAT(c.data_consulta, '%d/%m/%Y') 
        ORDER BY c.data_consulta ASC SEPARATOR ', '
    ) AS datas_consultas
FROM 
    consulta c
JOIN 
    paciente p ON c.id_paciente = p.id_paciente
JOIN 
    fisioterapeuta f ON c.id_fisio = f.id_fisio
GROUP BY 
    f.nome, p.nome
ORDER BY 
    f.nome, MIN(c.data_consulta);
    
-- histórico de atendimento, incluindo datas e observações  realizadas durante as sessões

SELECT 
    p.nome AS paciente,
    f.nome AS fisioterapeuta,
    h.data_registro,
    h.observacao
FROM 
    historico_atendimento h
JOIN 
    consulta c ON h.id_consulta = c.id_consulta
JOIN 
    paciente p ON c.id_paciente = p.id_paciente
JOIN 
    fisioterapeuta f ON c.id_fisio = f.id_fisio
ORDER BY 
    h.data_registro DESC;