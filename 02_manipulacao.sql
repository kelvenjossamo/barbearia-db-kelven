USE barbearia;

-- ========== SELECT SIMPLES ==========
-- 1) Serviços com preço acima de 200 MT, do mais caro para o mais barato
SELECT nome, preco, duracao_min FROM servico WHERE preco > 200 ORDER BY preco DESC;

-- 2) Clientes registados depois de 1 de Maio de 2026, por ordem alfabética
SELECT nome, telefone, data_registo FROM cliente WHERE data_registo > '2026-05-01' ORDER BY nome;

-- 3) Marcações concluídas, da mais recente para a mais antiga
SELECT id_marcacao, data_hora, estado FROM marcacao WHERE estado = 'concluida' ORDER BY data_hora DESC;

-- ========== SELECT COM JOIN ==========
-- 4) Marcações com nome do cliente e do barbeiro
SELECT m.id_marcacao, m.data_hora, c.nome AS cliente, b.nome AS barbeiro, m.estado
FROM marcacao m
JOIN cliente  c ON c.id_cliente  = m.id_cliente
JOIN barbeiro b ON b.id_barbeiro = m.id_barbeiro
ORDER BY m.data_hora;

-- 5) Detalhe de cada marcação: cliente, serviço e preço cobrado
SELECT m.id_marcacao, c.nome AS cliente, s.nome AS servico, i.preco_aplicado
FROM item_marcacao i
JOIN marcacao m ON m.id_marcacao = i.id_marcacao
JOIN cliente  c ON c.id_cliente  = m.id_cliente
JOIN servico  s ON s.id_servico  = i.id_servico
ORDER BY m.id_marcacao, i.num_item;

-- ========== UPDATE ==========
-- 6) Aumentar em 10% o preço do serviço "Corte simples"
UPDATE servico SET preco = preco * 1.10 WHERE nome = 'Corte simples';

-- 7) Marcar como concluída a marcação número 15 (estava agendada)
UPDATE marcacao SET estado = 'concluida' WHERE id_marcacao = 15;

-- ========== DELETE (respeitando as chaves estrangeiras) ==========
-- 8) Eliminar a marcação 24: primeiro os itens (filhos), depois a marcação (pai)
DELETE FROM item_marcacao WHERE id_marcacao = 24;
DELETE FROM marcacao      WHERE id_marcacao = 24;

-- ========== TESTE DE INTEGRIDADE ==========
-- 9) Inserir marcação com cliente inexistente (id 999)
-- Erro esperado: ERROR 1452 - Cannot add or update a child row: a foreign key constraint fails
-- Explicação: a coluna id_cliente é chave estrangeira para cliente(id_cliente);
-- como o cliente 999 não existe, o SGBD recusa o registo e protege a integridade.
INSERT INTO marcacao (id_cliente, id_barbeiro, data_hora, estado)
VALUES (999, 1, '2026-12-01 10:00:00', 'agendada');
