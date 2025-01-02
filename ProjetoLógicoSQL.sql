-- criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Adress varchar(30), 
        Telephone varchar(11),
        Cellphone varchar(11),
        Email varchar(50),
        constraint unique_cpf_client unique (CPF)
);

-- criar tabela produto
-- size  = dimensão do produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum("Eletrônico", "Vestimenta", "Brinquedos","Alimentos","Móveis") not null,
		assessment float default 0, 
        size varchar(10)
);


-- criar tabela pagamentos

create table payments(
        idPayment int auto_increment primary key,
        typePayment enum("Boleto","Pix","Crédito","Débito"),
        limitAvailable float default null,
        cvv int(13) default null,
	    numbercard int(16) default null,
        datePayment datetime not null
);

-- criar tabela pedido
create table orders(
		idOrder int auto_increment primary key,
		idOrderClient int,
		orderStatus enum("Cancelador","Confirmado","Em processamento") default "Em processamento",
		orderDescription varchar(255),
        sendValue float default 0,
        paymentCash bool default false,
        dateOrder datetime not null,
        idOPayment   int,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
            on delete set null,
        constraint fk_payments foreign key (idOPayment) references payments(idPayment) 
			on update cascade
            on delete set null
);


create table productStorage(
		idProdStorage int auto_increment primary key  ,
		storageLocation varchar(255),
        quantity int  default 0
);

-- criar tabela fornecedor

create table supplier(
		idSupplier int auto_increment primary key,
		SocialName varchar(255),
        CNPJ  char(15) not null,
        contact varchar(11) not null,
        adress varchar(255) not null,
        buyer varchar(50) not null,
        email varchar(255),
        constraint unique_supplier unique(CNPJ)
);

-- criar tabela vendedor

create table seller(
		idSeller int auto_increment primary key,
		SocialName varchar(255),
        AbstractName varchar(255),
        CNPJ  char(15),
        CPF char(9),
        location varchar(255),
        contact varchar(11) not null,
        constraint unique_cnpj_seller unique(CNPJ),
        constraint unique_cpf_seller unique(CPF)
);


create table productSeller(
		idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller,idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct) 
);


create table  productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum("Disponível", "Sem Estoque") default "Disponível",
		primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)

);


create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key  (idLproduct, idLstorage),
        constraint fk_storage_location_seller foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_locationc_product foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
		IdPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key(idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct) 
);



Alter table clients auto_increment = 1;

-- Inserir dados na tabela clients
INSERT INTO clients (Fname, Minit, Lname, CPF, Adress, Telephone, Cellphone, Email) VALUES
('John', 'A.', 'Doe', '12345678901', '123 Elm St', '1234567890', '9876543210', 'john.doe@example.com'),
('Jane', 'B.', 'Smith', '23456789012', '456 Oak St', '2345678901', '8765432109', 'jane.smith@example.com'),
('Alice', 'C.', 'Johnson', '34567890123', '789 Pine St', '3456789012', '7654321098', 'alice.johnson@example.com'),
('Bob', 'D.', 'Brown', '45678901234', '101 Maple St', '4567890123', '6543210987', 'bob.brown@example.com'),
('Charlie', 'E.', 'White', '56789012345', '202 Cedar St', '5678901234', '5432109876', 'charlie.white@example.com');

select * from clients;
-- Inserir dados na tabela product
INSERT INTO product (Pname, classification_kids, category, assessment, size) VALUES
('Toy Car', true, 'Brinquedos', 4.5, 'Small'),
('Laptop', false, 'Eletrônico', 4.8, 'Medium'),
('T-Shirt', false, 'Vestimenta', 4.3, 'Large'),
('Chair', false, 'Móveis',false, 'Standard'),
('Chips', false, 'Alimentos', 4.1, 'Packet');

select * from product;
-- Inserir dados na tabela payments
INSERT INTO payments (typePayment, limitAvailable, cvv, numbercard, datePayment) VALUES
('Crédito', 1000.00, 123, 4111111111111111, '2024-12-01 10:00:00'),
('Débito', NULL, NULL, NULL, '2024-12-02 11:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-03 12:00:00'),
('Boleto', NULL, NULL, NULL, '2024-12-04 13:00:00'),
('Crédito', 500.00, 456, 4222222222222222, '2024-12-05 14:00:00');

select * from payments;
-- Inserir dados na tabela orders
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash, dateOrder, idOPayment) VALUES
(1, default, 'Order for electronics', 15.00, true, '2024-12-01 15:00:00', 1),
(2, default, 'Order for furniture', 25.00, false, '2024-12-02 16:00:00', 2),
(3, default, 'Order for clothes', 10.00, true, '2024-12-03 17:00:00', 3),
(4, 'Confirmado', 'Order for toys', 5.00, false, '2024-12-04 18:00:00', 4),
(5, 'Confirmado', 'Order for snacks', 8.00, true, '2024-12-05 19:00:00', 5);

select * from orders;

DELETE FROM orders;

-- Inserir dados na tabela productStorage
INSERT INTO productStorage (storageLocation, quantity) VALUES
('Rio de Janeiro', 1000),
('Rio de Janeiro', 200),
('São Paulo', 150),
('São Paulo', 80),
('Brasília', 50);

select * from productStorage;
-- Inserir dados na tabela supplier
INSERT INTO supplier (SocialName, CNPJ, contact, adress, buyer, email) VALUES
('Supplier A', '12345678901234', '1234567890', '123 Elm St', 'John Doe', 'supplierA@example.com'),
('Supplier B', '23456789012345', '2345678901', '456 Oak St', 'Jane Smith', 'supplierB@example.com'),
('Supplier C', '34567890123456', '3456789012', '789 Pine St', 'Alice Johnson', 'supplierC@example.com'),
('Supplier D', '45678901234567', '4567890123', '101 Maple St', 'Bob Brown', 'supplierD@example.com'),
('Supplier E', '56789012345678', '5678901234', '202 Cedar St', 'Charlie White', 'supplierE@example.com');
select * from supplier;

-- Inserir dados na tabela seller
INSERT INTO seller (SocialName, AbstractName, CNPJ, CPF, location, contact) VALUES
('Seller A', 'SellerGroup A', '12345678901234', '123456789', 'Rio de Janeiro', '1234567890'),
('Seller B', 'SellerGroup B', '23456789012345', '234567890', 'Rio de Janeiro', '2345678901'),
('Seller C', 'SellerGroup C', '34567890123456', '345678901', 'São Paulo', '3456789012'),
('Seller D', 'SellerGroup D', '45678901234567', '456789012', 'São Paulo', '4567890123'),
('Seller E', 'SellerGroup E', '56789012345678', '567890123', 'Paraná', '5678901234');
select * from seller;

-- Inserir dados na tabela productSeller
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
(1, 1, 50),
(2, 2, 60),
(3, 3, 40),
(4, 4, 30),
(5, 5, 20);
select * from productSeller;
-- Inserir dados na tabela productOrder
alter table orders auto_increment = 1;
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
(1, 6, 10, null),
(2, 7, 15, null),
(3, 8, 20, null),
(4, 9, 5, null),
(5, 10, 8, null);

select * from product;
select * from orders;

select * from productOrder;
desc productOrder;
-- Inserir dados na tabela storageLocation
INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
(1, 1, 'RJ'),
(2, 2, 'RJ'),
(3, 3, 'GO'),
(4, 4, 'GO'),
(5, 5, 'SP');

select * from storageLocation;
-- Inserir dados na tabela productSupplier
INSERT INTO productSupplier (IdPsSupplier, idPsProduct, quantity) VALUES
(1, 1, 100),
(2, 2, 200),
(3, 3, 150),
(4, 4, 80),
(5, 5, 50);
select * from productSupplier;  

select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;

select Concat(Fname," ", Lname) as fullName, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;

 -- Order for electronics, Order for toys
select count(*) from clients c, orders o 
	where c.idClient = idOrderClient
    group by idOrder ;
    
    
select * from clients c left outer join orders on  c.idClient = idOrderClient;

select  c.idClient,c.Fname, count(*) as Number_of_orders from clients c  inner join orders o  on c.idClient = o.idOrderClient
		inner join productOrder p  on p.idPOorder = o.idOrder 
        group by c.idClient ;