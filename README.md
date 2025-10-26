# Sistema de Agendamento de Pacientes de Fisioterapia
#### Descrição

Projeto de um sistema de agendamento e controle de consultas para pacientes de fisioterapia, desenvolvido para gerenciar pacientes e seus respectivos fisioterapeutas.
O projeto demonstra planejamento, modelagem e implementação de um banco de dados, mostrando como a lógica do negócio se transforma em estrutura de dados.

#### Tecnologias utilizadas

MySQL (via MySQL Workbench)

#### Como rodar

Abra o MySQL Workbench.

Crie um novo schema/banco de dados.

Execute o código SQL (codigo.sql) para criar as tabelas e registros de exemplo.

Abra o diagrama (diagramas/modelo_der_projeto_fisio.mwb) no Workbench para visualizar toda a estrutura do banco e as relações entre tabelas.

Observação: Este projeto é educativo e não está configurado para uso em produção.

#### Observações

Desenvolvido a partir de um problema real de gerenciamento de consultas de fisioterapia, tradicionalmente controladas manualmente.

## Exemplo de código SQL
```sql
CREATE TABLE consulta (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_consulta DATE NOT NULL,
    horario TIME NOT NULL,
    id_fisio INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_fisio) REFERENCES fisioterapeuta(id_fisio) ON DELETE CASCADE,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE
);
