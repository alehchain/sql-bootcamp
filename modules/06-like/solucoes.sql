-- Soluções — LIKE
SELECT cliente_id, nome FROM clientes WHERE nome LIKE 'C%';
SELECT produto_id, nome FROM produtos WHERE nome LIKE '%Livro%';
SELECT funcionario_id, nome, cargo FROM funcionarios WHERE cargo LIKE 'Gerente%';
SELECT cliente_id, nome, email FROM clientes WHERE email LIKE '%@example.com';
SELECT produto_id, nome, sku FROM produtos WHERE sku LIKE 'INF-%';
SELECT cliente_id, nome, telefone FROM clientes WHERE telefone LIKE '119%';
SELECT fornecedor_id, razao_social FROM fornecedores WHERE razao_social LIKE '%Ltda%';
SELECT usuario_id, login FROM usuarios WHERE login LIKE '%.%';
SELECT produto_id, nome FROM produtos WHERE nome LIKE '%Oracle%' AND ativo = 'S';
SELECT produto_id, nome, sku FROM produtos WHERE sku LIKE '%001';
SELECT produto_id, nome, preco FROM produtos WHERE sku LIKE 'INF-%' AND preco > 200;
SELECT cliente_id, nome FROM clientes WHERE UPPER(nome) LIKE UPPER('%ana%');
SELECT funcionario_id, nome, cargo FROM funcionarios WHERE cargo NOT LIKE '%Venda%';
SELECT produto_id, sku FROM produtos WHERE sku LIKE '___-___-___';
SELECT 'Taxa 10%' texto FROM dual WHERE 'Taxa 10%' LIKE '%10\%%' ESCAPE '\';

-- Desafio 1
SELECT produto_id, nome, sku, preco
FROM produtos
WHERE nome LIKE '%Oracle%' OR nome LIKE '%SQL%' OR nome LIKE '%Notebook%';

-- Desafio 2
SELECT cliente_id, nome, email
FROM clientes
WHERE email NOT LIKE '%@example.com';

-- Desafio 3
SELECT produto_id, nome, sku
FROM produtos
WHERE sku LIKE 'INF-%-001';

-- Desafio 4
SELECT cliente_id, nome
FROM clientes
WHERE UPPER(nome) LIKE UPPER('%ana%');
