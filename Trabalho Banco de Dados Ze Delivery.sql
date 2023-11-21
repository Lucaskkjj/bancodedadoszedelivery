-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome_cliente VARCHAR(255),
    endereco_cliente VARCHAR(255),
    
);

-- Tabela Produto
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(255),
    preco_produto DECIMAL(10, 2),
    
);

-- Tabela Compra
CREATE TABLE Compra (
    id_compra INT PRIMARY KEY,
    id_cliente INT,
    data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_compra INT,
    status_pedido ENUM('Pendente', 'Em andamento', 'Concluído', 'Cancelado') DEFAULT 'Pendente',
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra)
);

-- Tabela LojaFisica
CREATE TABLE LojaFisica (
    id_loja_fisica INT PRIMARY KEY,
    nome_loja VARCHAR(255),
    endereco_loja VARCHAR(255),
    
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY,
    nome_fornecedor VARCHAR(255),
    cnpj_fornecedor VARCHAR(14),
    
);

-- Tabela ItensVenda
CREATE TABLE ItensVenda (
    id_itens_venda INT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Tabela ItemCompra
CREATE TABLE ItemCompra (
    id_item_compra INT PRIMARY KEY,
    id_compra INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);


CREATE INDEX idx_status_pedido ON Pedido(status_pedido);

SELECT
    Cliente.nome_cliente,
    Compra.id_compra,
    Compra.data_compra,
    Pedido.id_pedido,
    Pedido.status_pedido,
    ItensVenda.quantidade,
    Produto.nome_produto,
    Produto.preco_produto
FROM
    Cliente
    INNER JOIN Compra ON Cliente.id_cliente = Compra.id_cliente
    INNER JOIN Pedido ON Compra.id_compra = Pedido.id_compra
    INNER JOIN ItensVenda ON Pedido.id_pedido = ItensVenda.id_pedido
    INNER JOIN Produto ON ItensVenda.id_produto = Produto.id_produto
WHERE
    Cliente.id_cliente = 1; 

SELECT
    Compra.id_compra,
    Compra.data_compra,
    ItemCompra.id_item_compra,
    ItemCompra.quantidade,
    Produto.nome_produto,
    Produto.preco_produto
FROM
    Compra
    INNER JOIN ItemCompra ON Compra.id_compra = ItemCompra.id_compra
    INNER JOIN Produto ON ItemCompra.id_produto = Produto.id_produto
WHERE
    Compra.id_compra = 123; 

SELECT
    LojaFisica.nome_loja,
    Pedido.id_pedido,
    Pedido.status_pedido,
    Cliente.nome_cliente,
    Cliente.endereco_cliente
FROM
    LojaFisica
    INNER JOIN Pedido ON LojaFisica.id_loja_fisica = Pedido.id_loja_fisica
    INNER JOIN Compra ON Pedido.id_compra = Compra.id_compra
    INNER JOIN Cliente ON Compra.id_cliente = Cliente.id_cliente
WHERE
    LojaFisica.id_loja_fisica = 10; 

SELECT
    Compra.id_compra,
    Compra.data_compra,
    Produto.id_produto,
    Produto.nome_produto,
    ItemCompra.quantidade,
    ItemCompra.preco_unitario
FROM
    Compra
    INNER JOIN ItemCompra ON Compra.id_compra = ItemCompra.id_compra
    INNER JOIN Produto ON ItemCompra.id_produto = Produto.id_produto
WHERE
    Compra.id_compra = 456; 

