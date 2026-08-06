-- Módulo 06 — LIKE
SELECT cliente_id, nome FROM clientes WHERE nome LIKE 'A%';
SELECT cliente_id, nome FROM clientes WHERE nome LIKE '%a';
SELECT cliente_id, nome FROM clientes WHERE nome LIKE '%Souza%';
SELECT cliente_id, nome, email FROM clientes WHERE email LIKE '%@example.com';
SELECT produto_id, nome FROM produtos WHERE nome LIKE '%SQL%';
SELECT produto_id, nome FROM produtos WHERE nome LIKE 'Notebook%';
SELECT produto_id, nome, sku FROM produtos WHERE sku LIKE 'INF-%';
SELECT produto_id, nome, sku FROM produtos WHERE sku LIKE '%-001';
SELECT produto_id, sku FROM produtos WHERE sku LIKE 'INF-___-001';
SELECT fornecedor_id, razao_social FROM fornecedores WHERE razao_social LIKE '%Brasil%';
SELECT funcionario_id, nome, cargo FROM funcionarios WHERE cargo LIKE 'Gerente%';
SELECT cliente_id, nome, telefone FROM clientes WHERE telefone LIKE '119%';
SELECT cliente_id, nome FROM clientes WHERE nome NOT LIKE 'A%';
SELECT cliente_id, nome FROM clientes WHERE UPPER(nome) LIKE 'ANA%';
SELECT produto_id, nome FROM produtos WHERE nome LIKE '%Oracle%' AND ativo = 'S';
SELECT usuario_id, login FROM usuarios WHERE login LIKE '%.%';
SELECT produto_id, nome FROM produtos WHERE nome NOT LIKE '%Livro%';
SELECT 'Desconto 10%' texto FROM dual WHERE 'Desconto 10%' LIKE '%10\%%' ESCAPE '\';
