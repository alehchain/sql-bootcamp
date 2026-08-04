-- ============================================================
-- SQL Bootcamp - Banco Loja Virtual
-- Setup completo para Oracle Live SQL
-- ============================================================

-- 1. Remove objetos existentes
BEGIN
    FOR obj IN (
        SELECT object_name, object_type
        FROM user_objects
        WHERE object_name IN (
            'AUDITORIA','USUARIOS','PERFIS','ESTOQUE','PAGAMENTOS',
            'ITENS_PEDIDO','PEDIDOS','TRANSPORTADORAS','PRODUTOS',
            'FORNECEDORES','CATEGORIAS','CLIENTES','FUNCIONARIOS',
            'VW_RESUMO_PEDIDOS','VW_ESTOQUE_CRITICO'
        )
        AND object_type IN ('TABLE','VIEW')
    ) LOOP
        BEGIN
            IF obj.object_type = 'TABLE' THEN
                EXECUTE IMMEDIATE 'DROP TABLE ' || obj.object_name || ' CASCADE CONSTRAINTS PURGE';
            ELSE
                EXECUTE IMMEDIATE 'DROP VIEW ' || obj.object_name;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN NULL;
        END;
    END LOOP;

    FOR seq IN (
        SELECT sequence_name
        FROM user_sequences
        WHERE sequence_name LIKE 'SEQ_%'
    ) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seq.sequence_name;
    END LOOP;
END;
/

-- 2. Cria tabelas e constraints

CREATE TABLE clientes (
    cliente_id       NUMBER(10)      NOT NULL,
    nome             VARCHAR2(120)   NOT NULL,
    email            VARCHAR2(160)   NOT NULL,
    cpf              VARCHAR2(14),
    telefone         VARCHAR2(20),
    data_nascimento  DATE,
    data_cadastro    DATE            DEFAULT SYSDATE NOT NULL,
    status           VARCHAR2(15)    DEFAULT 'ATIVO' NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (cliente_id),
    CONSTRAINT uk_clientes_email UNIQUE (email),
    CONSTRAINT uk_clientes_cpf UNIQUE (cpf),
    CONSTRAINT ck_clientes_status CHECK (status IN ('ATIVO','INATIVO','BLOQUEADO'))
);

CREATE TABLE categorias (
    categoria_id NUMBER(10)     NOT NULL,
    nome         VARCHAR2(80)   NOT NULL,
    descricao    VARCHAR2(300),
    ativo        CHAR(1)        DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_categorias PRIMARY KEY (categoria_id),
    CONSTRAINT uk_categorias_nome UNIQUE (nome),
    CONSTRAINT ck_categorias_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE fornecedores (
    fornecedor_id NUMBER(10)     NOT NULL,
    razao_social  VARCHAR2(150)  NOT NULL,
    nome_fantasia VARCHAR2(120),
    cnpj          VARCHAR2(18)   NOT NULL,
    email         VARCHAR2(160),
    telefone      VARCHAR2(20),
    ativo         CHAR(1)        DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_fornecedores PRIMARY KEY (fornecedor_id),
    CONSTRAINT uk_fornecedores_cnpj UNIQUE (cnpj),
    CONSTRAINT ck_fornecedores_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE produtos (
    produto_id      NUMBER(10)      NOT NULL,
    categoria_id    NUMBER(10)      NOT NULL,
    fornecedor_id   NUMBER(10)      NOT NULL,
    nome            VARCHAR2(150)   NOT NULL,
    descricao       VARCHAR2(500),
    preco           NUMBER(12,2)    NOT NULL,
    custo           NUMBER(12,2)    NOT NULL,
    sku             VARCHAR2(40)    NOT NULL,
    data_cadastro   DATE            DEFAULT SYSDATE NOT NULL,
    ativo           CHAR(1)         DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_produtos PRIMARY KEY (produto_id),
    CONSTRAINT uk_produtos_sku UNIQUE (sku),
    CONSTRAINT fk_produtos_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id),
    CONSTRAINT fk_produtos_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(fornecedor_id),
    CONSTRAINT ck_produtos_preco CHECK (preco >= 0),
    CONSTRAINT ck_produtos_custo CHECK (custo >= 0),
    CONSTRAINT ck_produtos_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE transportadoras (
    transportadora_id NUMBER(10)     NOT NULL,
    nome               VARCHAR2(120)  NOT NULL,
    cnpj               VARCHAR2(18)   NOT NULL,
    telefone           VARCHAR2(20),
    prazo_medio_dias   NUMBER(3)      DEFAULT 5 NOT NULL,
    ativo              CHAR(1)        DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_transportadoras PRIMARY KEY (transportadora_id),
    CONSTRAINT uk_transportadoras_cnpj UNIQUE (cnpj),
    CONSTRAINT ck_transportadoras_prazo CHECK (prazo_medio_dias > 0),
    CONSTRAINT ck_transportadoras_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE funcionarios (
    funcionario_id NUMBER(10)      NOT NULL,
    gestor_id      NUMBER(10),
    nome           VARCHAR2(120)   NOT NULL,
    cargo          VARCHAR2(80)    NOT NULL,
    salario        NUMBER(12,2)    NOT NULL,
    data_admissao  DATE            NOT NULL,
    email          VARCHAR2(160)   NOT NULL,
    ativo          CHAR(1)         DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_funcionarios PRIMARY KEY (funcionario_id),
    CONSTRAINT uk_funcionarios_email UNIQUE (email),
    CONSTRAINT fk_funcionarios_gestor FOREIGN KEY (gestor_id) REFERENCES funcionarios(funcionario_id),
    CONSTRAINT ck_funcionarios_salario CHECK (salario > 0),
    CONSTRAINT ck_funcionarios_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE pedidos (
    pedido_id           NUMBER(10)      NOT NULL,
    cliente_id          NUMBER(10)      NOT NULL,
    transportadora_id   NUMBER(10),
    vendedor_id         NUMBER(10),
    data_pedido         DATE            DEFAULT SYSDATE NOT NULL,
    status              VARCHAR2(20)    DEFAULT 'ABERTO' NOT NULL,
    valor_produtos      NUMBER(12,2)    DEFAULT 0 NOT NULL,
    valor_frete         NUMBER(12,2)    DEFAULT 0 NOT NULL,
    valor_desconto      NUMBER(12,2)    DEFAULT 0 NOT NULL,
    valor_total         NUMBER(12,2)    DEFAULT 0 NOT NULL,
    observacao          VARCHAR2(500),
    CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id),
    CONSTRAINT fk_pedidos_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    CONSTRAINT fk_pedidos_transportadora FOREIGN KEY (transportadora_id) REFERENCES transportadoras(transportadora_id),
    CONSTRAINT fk_pedidos_vendedor FOREIGN KEY (vendedor_id) REFERENCES funcionarios(funcionario_id),
    CONSTRAINT ck_pedidos_status CHECK (status IN ('ABERTO','PAGO','FATURADO','ENVIADO','ENTREGUE','CANCELADO')),
    CONSTRAINT ck_pedidos_valores CHECK (
        valor_produtos >= 0 AND valor_frete >= 0 AND valor_desconto >= 0 AND valor_total >= 0
    )
);

CREATE TABLE itens_pedido (
    item_pedido_id NUMBER(10)      NOT NULL,
    pedido_id      NUMBER(10)      NOT NULL,
    produto_id     NUMBER(10)      NOT NULL,
    quantidade     NUMBER(10)      NOT NULL,
    preco_unitario NUMBER(12,2)    NOT NULL,
    desconto       NUMBER(12,2)    DEFAULT 0 NOT NULL,
    CONSTRAINT pk_itens_pedido PRIMARY KEY (item_pedido_id),
    CONSTRAINT uk_itens_pedido UNIQUE (pedido_id, produto_id),
    CONSTRAINT fk_itens_pedido_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    CONSTRAINT fk_itens_pedido_produto FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    CONSTRAINT ck_itens_pedido_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_itens_pedido_preco CHECK (preco_unitario >= 0),
    CONSTRAINT ck_itens_pedido_desconto CHECK (desconto >= 0)
);

CREATE TABLE pagamentos (
    pagamento_id    NUMBER(10)      NOT NULL,
    pedido_id       NUMBER(10)      NOT NULL,
    forma_pagamento VARCHAR2(20)    NOT NULL,
    status          VARCHAR2(20)    DEFAULT 'PENDENTE' NOT NULL,
    valor           NUMBER(12,2)    NOT NULL,
    data_pagamento  DATE,
    quantidade_parcelas NUMBER(2)   DEFAULT 1 NOT NULL,
    CONSTRAINT pk_pagamentos PRIMARY KEY (pagamento_id),
    CONSTRAINT fk_pagamentos_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    CONSTRAINT ck_pagamentos_forma CHECK (forma_pagamento IN ('PIX','CARTAO','BOLETO','TRANSFERENCIA')),
    CONSTRAINT ck_pagamentos_status CHECK (status IN ('PENDENTE','APROVADO','RECUSADO','ESTORNADO')),
    CONSTRAINT ck_pagamentos_valor CHECK (valor > 0),
    CONSTRAINT ck_pagamentos_parcelas CHECK (quantidade_parcelas BETWEEN 1 AND 24)
);

CREATE TABLE estoque (
    estoque_id         NUMBER(10)   NOT NULL,
    produto_id         NUMBER(10)   NOT NULL,
    quantidade_atual   NUMBER(10)   DEFAULT 0 NOT NULL,
    quantidade_minima  NUMBER(10)   DEFAULT 0 NOT NULL,
    data_atualizacao   DATE         DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_estoque PRIMARY KEY (estoque_id),
    CONSTRAINT uk_estoque_produto UNIQUE (produto_id),
    CONSTRAINT fk_estoque_produto FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    CONSTRAINT ck_estoque_quantidade CHECK (quantidade_atual >= 0 AND quantidade_minima >= 0)
);

CREATE TABLE perfis (
    perfil_id NUMBER(10)     NOT NULL,
    nome      VARCHAR2(50)   NOT NULL,
    descricao VARCHAR2(200),
    CONSTRAINT pk_perfis PRIMARY KEY (perfil_id),
    CONSTRAINT uk_perfis_nome UNIQUE (nome)
);

CREATE TABLE usuarios (
    usuario_id      NUMBER(10)      NOT NULL,
    perfil_id       NUMBER(10)      NOT NULL,
    funcionario_id  NUMBER(10),
    login            VARCHAR2(80)    NOT NULL,
    email            VARCHAR2(160)   NOT NULL,
    senha_hash       VARCHAR2(255)   NOT NULL,
    ativo            CHAR(1)         DEFAULT 'S' NOT NULL,
    ultimo_acesso    DATE,
    CONSTRAINT pk_usuarios PRIMARY KEY (usuario_id),
    CONSTRAINT uk_usuarios_login UNIQUE (login),
    CONSTRAINT uk_usuarios_email UNIQUE (email),
    CONSTRAINT fk_usuarios_perfil FOREIGN KEY (perfil_id) REFERENCES perfis(perfil_id),
    CONSTRAINT fk_usuarios_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id),
    CONSTRAINT ck_usuarios_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE auditoria (
    auditoria_id      NUMBER(12)      NOT NULL,
    usuario_id        NUMBER(10),
    tabela            VARCHAR2(60)    NOT NULL,
    operacao          VARCHAR2(10)    NOT NULL,
    chave_registro    VARCHAR2(100),
    dados_anteriores  CLOB,
    dados_novos       CLOB,
    data_operacao     TIMESTAMP       DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_auditoria PRIMARY KEY (auditoria_id),
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    CONSTRAINT ck_auditoria_operacao CHECK (operacao IN ('INSERT','UPDATE','DELETE','LOGIN'))
);

-- 3. Cria sequences
CREATE SEQUENCE seq_clientes START WITH 1001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_categorias START WITH 101 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_fornecedores START WITH 201 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_produtos START WITH 10001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_transportadoras START WITH 301 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_funcionarios START WITH 401 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_pedidos START WITH 50001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_itens_pedido START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_pagamentos START WITH 70001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_estoque START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_perfis START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_usuarios START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_auditoria START WITH 1 INCREMENT BY 1 NOCACHE;

-- 4. Carrega dados fictícios
INSERT ALL
    INTO categorias VALUES (1, 'Eletrônicos', 'Equipamentos e acessórios eletrônicos', 'S')
    INTO categorias VALUES (2, 'Informática', 'Computadores, componentes e periféricos', 'S')
    INTO categorias VALUES (3, 'Casa', 'Produtos para casa e cozinha', 'S')
    INTO categorias VALUES (4, 'Livros', 'Livros técnicos e literatura', 'S')
    INTO categorias VALUES (5, 'Esportes', 'Produtos esportivos', 'S')
SELECT 1 FROM dual;

INSERT ALL
    INTO fornecedores VALUES (1, 'Tech Supply Brasil Ltda', 'Tech Supply', '10.000.000/0001-10', 'contato@techsupply.example', '1130001000', 'S')
    INTO fornecedores VALUES (2, 'Casa Nova Distribuidora Ltda', 'Casa Nova', '20.000.000/0001-20', 'vendas@casanova.example', '1130002000', 'S')
    INTO fornecedores VALUES (3, 'Editora Saber Ltda', 'Editora Saber', '30.000.000/0001-30', 'comercial@saber.example', '1130003000', 'S')
    INTO fornecedores VALUES (4, 'Sport Max Comércio Ltda', 'Sport Max', '40.000.000/0001-40', 'pedidos@sportmax.example', '1130004000', 'S')
SELECT 1 FROM dual;

INSERT ALL
    INTO clientes VALUES (1, 'Ana Souza', 'ana.souza@example.com', '111.111.111-11', '11990000001', DATE '1992-04-18', DATE '2025-01-10', 'ATIVO')
    INTO clientes VALUES (2, 'Bruno Lima', 'bruno.lima@example.com', '222.222.222-22', '11990000002', DATE '1988-08-03', DATE '2025-01-15', 'ATIVO')
    INTO clientes VALUES (3, 'Carla Mendes', 'carla.mendes@example.com', '333.333.333-33', NULL, DATE '1995-12-11', DATE '2025-02-01', 'ATIVO')
    INTO clientes VALUES (4, 'Daniel Alves', 'daniel.alves@example.com', '444.444.444-44', '11990000004', NULL, DATE '2025-02-10', 'BLOQUEADO')
    INTO clientes VALUES (5, 'Eduarda Reis', 'eduarda.reis@example.com', '555.555.555-55', '11990000005', DATE '1984-07-29', DATE '2025-03-05', 'INATIVO')
    INTO clientes VALUES (6, 'Felipe Costa', 'felipe.costa@example.com', '666.666.666-66', NULL, DATE '1998-01-21', DATE '2025-03-15', 'ATIVO')
    INTO clientes VALUES (7, 'Gabriela Martins', 'gabriela.martins@example.com', '777.777.777-77', '11990000007', DATE '1990-09-09', DATE '2025-04-02', 'ATIVO')
    INTO clientes VALUES (8, 'Henrique Rocha', 'henrique.rocha@example.com', '888.888.888-88', '11990000008', DATE '1979-05-30', DATE '2025-04-18', 'ATIVO')
SELECT 1 FROM dual;

INSERT ALL
    INTO produtos VALUES (1, 1, 1, 'Smartphone Alpha', 'Smartphone intermediário 128 GB', 1899.90, 1350.00, 'ELE-SMA-001', DATE '2025-01-02', 'S')
    INTO produtos VALUES (2, 2, 1, 'Notebook Pro 15', 'Notebook com 16 GB de RAM', 4799.00, 3650.00, 'INF-NOT-001', DATE '2025-01-02', 'S')
    INTO produtos VALUES (3, 2, 1, 'Mouse Sem Fio', 'Mouse ergonômico sem fio', 129.90, 65.00, 'INF-MOU-001', DATE '2025-01-03', 'S')
    INTO produtos VALUES (4, 2, 1, 'Teclado Mecânico', 'Teclado ABNT2 com iluminação', 349.90, 210.00, 'INF-TEC-001', DATE '2025-01-03', 'S')
    INTO produtos VALUES (5, 3, 2, 'Cafeteira Elétrica', 'Cafeteira de 30 xícaras', 219.90, 140.00, 'CAS-CAF-001', DATE '2025-01-04', 'S')
    INTO produtos VALUES (6, 3, 2, 'Jogo de Panelas', 'Conjunto antiaderente com cinco peças', 399.90, 245.00, 'CAS-PAN-001', DATE '2025-01-04', 'S')
    INTO produtos VALUES (7, 4, 3, 'SQL na Prática', 'Livro introdutório de SQL', 89.90, 35.00, 'LIV-SQL-001', DATE '2025-01-05', 'S')
    INTO produtos VALUES (8, 4, 3, 'Oracle para Desenvolvedores', 'Livro de Oracle SQL e PL/SQL', 139.90, 55.00, 'LIV-ORA-001', DATE '2025-01-05', 'S')
    INTO produtos VALUES (9, 5, 4, 'Tênis de Corrida', 'Tênis leve para treinos diários', 499.90, 290.00, 'ESP-TEN-001', DATE '2025-01-06', 'S')
    INTO produtos VALUES (10, 5, 4, 'Óculos de Natação', 'Óculos com proteção UV', 119.90, 55.00, 'ESP-OCU-001', DATE '2025-01-06', 'S')
SELECT 1 FROM dual;

INSERT ALL
    INTO transportadoras VALUES (1, 'Entrega Rápida', '50.000.000/0001-50', '1131001000', 3, 'S')
    INTO transportadoras VALUES (2, 'Logística Nacional', '60.000.000/0001-60', '1131002000', 7, 'S')
SELECT 1 FROM dual;

INSERT INTO funcionarios VALUES (1, NULL, 'Mariana Torres', 'Diretora Comercial', 18500, DATE '2020-01-10', 'mariana.torres@loja.example', 'S');
INSERT INTO funcionarios VALUES (2, 1, 'Ricardo Nunes', 'Gerente de Vendas', 10500, DATE '2021-03-15', 'ricardo.nunes@loja.example', 'S');
INSERT INTO funcionarios VALUES (3, 2, 'Laura Freitas', 'Vendedora', 4800, DATE '2023-06-01', 'laura.freitas@loja.example', 'S');
INSERT INTO funcionarios VALUES (4, 2, 'Marcelo Dias', 'Vendedor', 4600, DATE '2024-02-12', 'marcelo.dias@loja.example', 'S');

INSERT ALL
    INTO pedidos VALUES (1, 1, 1, 3, DATE '2025-05-02', 'ENTREGUE', 2029.80, 25.00, 50.00, 2004.80, NULL)
    INTO pedidos VALUES (2, 2, 2, 4, DATE '2025-05-05', 'ENTREGUE', 4799.00, 0, 200.00, 4599.00, 'Retirada promocional')
    INTO pedidos VALUES (3, 3, 1, 3, DATE '2025-05-12', 'CANCELADO', 219.90, 20.00, 0, 239.90, 'Cancelado pelo cliente')
    INTO pedidos VALUES (4, 1, 1, 4, DATE '2025-06-01', 'PAGO', 489.80, 18.00, 0, 507.80, NULL)
    INTO pedidos VALUES (5, 6, 2, 3, DATE '2025-06-08', 'ENVIADO', 499.90, 30.00, 25.00, 504.90, NULL)
    INTO pedidos VALUES (6, 7, NULL, 4, DATE '2025-06-15', 'ABERTO', 279.80, 0, 0, 279.80, NULL)
SELECT 1 FROM dual;

INSERT ALL
    INTO itens_pedido VALUES (1, 1, 1, 1, 1899.90, 0)
    INTO itens_pedido VALUES (2, 1, 3, 1, 129.90, 0)
    INTO itens_pedido VALUES (3, 2, 2, 1, 4799.00, 0)
    INTO itens_pedido VALUES (4, 3, 5, 1, 219.90, 0)
    INTO itens_pedido VALUES (5, 4, 7, 2, 89.90, 0)
    INTO itens_pedido VALUES (6, 4, 8, 1, 139.90, 0)
    INTO itens_pedido VALUES (7, 4, 10, 1, 119.90, 0)
    INTO itens_pedido VALUES (8, 5, 9, 1, 499.90, 0)
    INTO itens_pedido VALUES (9, 6, 8, 2, 139.90, 0)
SELECT 1 FROM dual;

INSERT ALL
    INTO pagamentos VALUES (1, 1, 'PIX', 'APROVADO', 2004.80, DATE '2025-05-02', 1)
    INTO pagamentos VALUES (2, 2, 'CARTAO', 'APROVADO', 4599.00, DATE '2025-05-05', 10)
    INTO pagamentos VALUES (3, 3, 'BOLETO', 'ESTORNADO', 239.90, DATE '2025-05-13', 1)
    INTO pagamentos VALUES (4, 4, 'PIX', 'APROVADO', 507.80, DATE '2025-06-01', 1)
    INTO pagamentos VALUES (5, 5, 'CARTAO', 'APROVADO', 504.90, DATE '2025-06-08', 3)
    INTO pagamentos VALUES (6, 6, 'BOLETO', 'PENDENTE', 279.80, NULL, 1)
SELECT 1 FROM dual;

INSERT ALL
    INTO estoque VALUES (1, 1, 18, 5, DATE '2025-06-20')
    INTO estoque VALUES (2, 2, 7, 3, DATE '2025-06-20')
    INTO estoque VALUES (3, 3, 42, 10, DATE '2025-06-20')
    INTO estoque VALUES (4, 4, 12, 5, DATE '2025-06-20')
    INTO estoque VALUES (5, 5, 4, 5, DATE '2025-06-20')
    INTO estoque VALUES (6, 6, 9, 4, DATE '2025-06-20')
    INTO estoque VALUES (7, 7, 30, 8, DATE '2025-06-20')
    INTO estoque VALUES (8, 8, 16, 6, DATE '2025-06-20')
    INTO estoque VALUES (9, 9, 3, 5, DATE '2025-06-20')
    INTO estoque VALUES (10, 10, 25, 8, DATE '2025-06-20')
SELECT 1 FROM dual;

INSERT ALL
    INTO perfis VALUES (1, 'ADMINISTRADOR', 'Acesso completo ao sistema')
    INTO perfis VALUES (2, 'GERENTE', 'Acesso a relatórios e gestão')
    INTO perfis VALUES (3, 'OPERADOR', 'Acesso operacional')
SELECT 1 FROM dual;

INSERT ALL
    INTO usuarios VALUES (1, 1, 1, 'mariana.torres', 'mariana.torres@loja.example', 'HASH_FICTICIO_1', 'S', DATE '2025-06-20')
    INTO usuarios VALUES (2, 2, 2, 'ricardo.nunes', 'ricardo.nunes@loja.example', 'HASH_FICTICIO_2', 'S', DATE '2025-06-19')
    INTO usuarios VALUES (3, 3, 3, 'laura.freitas', 'laura.freitas@loja.example', 'HASH_FICTICIO_3', 'S', NULL)
SELECT 1 FROM dual;

COMMIT;

-- 5. Cria views
CREATE OR REPLACE VIEW vw_resumo_pedidos AS
SELECT
    p.pedido_id,
    p.data_pedido,
    p.status,
    c.cliente_id,
    c.nome AS cliente,
    f.nome AS vendedor,
    t.nome AS transportadora,
    p.valor_produtos,
    p.valor_frete,
    p.valor_desconto,
    p.valor_total
FROM pedidos p
JOIN clientes c ON c.cliente_id = p.cliente_id
LEFT JOIN funcionarios f ON f.funcionario_id = p.vendedor_id
LEFT JOIN transportadoras t ON t.transportadora_id = p.transportadora_id;

CREATE OR REPLACE VIEW vw_estoque_critico AS
SELECT
    p.produto_id,
    p.nome AS produto,
    e.quantidade_atual,
    e.quantidade_minima,
    e.data_atualizacao
FROM produtos p
JOIN estoque e ON e.produto_id = p.produto_id
WHERE e.quantidade_atual <= e.quantidade_minima;

-- 6. Cria índices
CREATE INDEX ix_pedidos_cliente_data ON pedidos (cliente_id, data_pedido);
CREATE INDEX ix_pedidos_status ON pedidos (status);
CREATE INDEX ix_produtos_categoria ON produtos (categoria_id);
CREATE INDEX ix_produtos_fornecedor ON produtos (fornecedor_id);
CREATE INDEX ix_itens_pedido_produto ON itens_pedido (produto_id);
CREATE INDEX ix_pagamentos_pedido_status ON pagamentos (pedido_id, status);
CREATE INDEX ix_auditoria_data ON auditoria (data_operacao);

-- 7. Validação final
SELECT 'CLIENTES' AS objeto, COUNT(*) AS quantidade FROM clientes
UNION ALL
SELECT 'PRODUTOS', COUNT(*) FROM produtos
UNION ALL
SELECT 'PEDIDOS', COUNT(*) FROM pedidos
UNION ALL
SELECT 'ITENS_PEDIDO', COUNT(*) FROM itens_pedido
UNION ALL
SELECT 'PAGAMENTOS', COUNT(*) FROM pagamentos;

SELECT 'Ambiente do SQL Bootcamp criado com sucesso!' AS resultado
FROM dual;
