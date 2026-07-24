-- ============================================================
-- SQL Bootcamp - Banco Loja Virtual
-- Criação das tabelas, chaves e constraints
-- Compatível com Oracle Live SQL
-- ============================================================

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
    usuario_id    NUMBER(10)      NOT NULL,
    perfil_id     NUMBER(10)      NOT NULL,
    funcionario_id NUMBER(10),
    login         VARCHAR2(80)    NOT NULL,
    email         VARCHAR2(160)   NOT NULL,
    senha_hash    VARCHAR2(255)   NOT NULL,
    ativo         CHAR(1)         DEFAULT 'S' NOT NULL,
    ultimo_acesso DATE,
    CONSTRAINT pk_usuarios PRIMARY KEY (usuario_id),
    CONSTRAINT uk_usuarios_login UNIQUE (login),
    CONSTRAINT uk_usuarios_email UNIQUE (email),
    CONSTRAINT fk_usuarios_perfil FOREIGN KEY (perfil_id) REFERENCES perfis(perfil_id),
    CONSTRAINT fk_usuarios_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id),
    CONSTRAINT ck_usuarios_ativo CHECK (ativo IN ('S','N'))
);

CREATE TABLE auditoria (
    auditoria_id   NUMBER(12)      NOT NULL,
    usuario_id     NUMBER(10),
    tabela         VARCHAR2(60)    NOT NULL,
    operacao       VARCHAR2(10)    NOT NULL,
    chave_registro VARCHAR2(100),
    dados_anteriores CLOB,
    dados_novos      CLOB,
    data_operacao  TIMESTAMP       DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_auditoria PRIMARY KEY (auditoria_id),
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    CONSTRAINT ck_auditoria_operacao CHECK (operacao IN ('INSERT','UPDATE','DELETE','LOGIN'))
);
