-- criação do banco de dados para o cenário de E-commerce

create database Desafioecommerce;
use Desafioecommerce;

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

create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum("Eletrônico", "Vestimenta", "Brinquedos","Alimentos","Móveis") not null,
		assessment float default 0, 
        size varchar(10), 
        valueProduct decimal(10,2) not null
);

create table payments(
        idPayment int auto_increment primary key,
        typePayment enum("Boleto","Pix","Crédito","Débito"),
        limitAvailable float default null,
        cvv int(13) default null,
	    numbercard int(16) default null,
        datePayment datetime not null
         
);

create table orders(
		idOrder int auto_increment primary key,
		idOrderClient int,
        IDOproduct int, 
		orderStatus enum("Cancelador","Confirmado","Em processamento") default "Em processamento",
		orderDescription varchar(255),
        sendValue float default 0,
        paymentCash bool default false,
        dateOrder datetime not null,
        valueOrder decimal(10,2) not null,
        quantity int, 
        idOPayment   int,
        
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
            on delete set null,
        constraint fk_payments foreign key (idOPayment) references payments(idPayment) 
			on update cascade
            on delete set null,
		constraint fk_product foreign key(IDOproduct) references product(idProduct)
		    on update cascade
            on delete set null
);

create table productStorage(
		idProdStorage int auto_increment primary key  ,
		storageLocation varchar(255),
        quantity int  default 0
);
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

select * from productOrder;

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
INSERT INTO clients (Fname, Minit, Lname, CPF, Adress, Telephone, Cellphone, Email) VALUES
('John', 'A.', 'Doe', '12345678901', '123 Elm St', '1234567890', '9876543210', 'john.doe@example.com'),
('Jane', 'B.', 'Smith', '23456789012', '456 Oak St', '2345678901', '8765432109', 'jane.smith@example.com'),
('Alice', 'C.', 'Johnson', '34567890123', '789 Pine St', '3456789012', '7654321098', 'alice.johnson@example.com'),
('Bob', 'D.', 'Brown', '45678901234', '101 Maple St', '4567890123', '6543210987', 'bob.brown@example.com'),
('Charlie', 'E.', 'White', '56789012345', '202 Cedar St', '5678901234', '5432109876', 'charlie.white@example.com');
INSERT INTO clients (Fname, Minit, Lname, CPF, Adress, Telephone, Cellphone, Email) VALUES
('David', 'F.', 'Taylor', '67890123456', '303 Birch St', '6789012345', '4321098765', 'david.taylor@example.com'),
('Emily', 'G.', 'Clark', '78901234567', '404 Spruce St', '7890123456', '3210987654', 'emily.clark@example.com'),
('Frank', 'H.', 'Hall', '89012345678', '505 Walnut St', '8901234567', '2109876543', 'frank.hall@example.com'),
('Grace', 'I.', 'Adams', '90123456789', '606 Willow St', '9012345678', '1098765432', 'grace.adams@example.com'),
('Henry', 'J.', 'Baker', '01234567891', '707 Ash St', '0123456789', '0987654321', 'henry.baker@example.com'),
('Isabel', 'K.', 'Green', '11234567892', '808 Cherry St', '1123456789', '9876543210', 'isabel.green@example.com'),
('Jack', 'L.', 'Nelson', '22345678903', '909 Fir St', '2234567890', '8765432109', 'jack.nelson@example.com'),
('Katherine', 'M.', 'Carter', '33456789014', '1010 Elm St', '3345678901', '7654321098', 'katherine.carter@example.com'),
('Liam', 'N.', 'Scott', '44567890125', '1111 Oak St', '4456789012', '6543210987', 'liam.scott@example.com'),
('Mia', 'O.', 'Hughes', '55678901236', '1212 Pine St', '5567890123', '5432109876', 'mia.hughes@example.com'),
('Nathan', 'P.', 'Morgan', '66789012347', '1313 Maple St', '6678901234', '4321098765', 'nathan.morgan@example.com'),
('Olivia', 'Q.', 'Perez', '77890123458', '1414 Cedar St', '7789012345', '3210987654', 'olivia.perez@example.com'),
('Paul', 'R.', 'Cook', '88901234569', '1515 Birch St', '8890123456', '2109876543', 'paul.cook@example.com'),
('Quincy', 'S.', 'Ward', '99012345670', '1616 Spruce St', '9901234567', '1098765432', 'quincy.ward@example.com'),
('Rachel', 'T.', 'Murphy', '00123456781', '1717 Walnut St', '0012345678', '0987654321', 'rachel.murphy@example.com'),
('Samuel', 'U.', 'Bell', '11234567893', '1818 Willow St', '1123456789', '9876543210', 'samuel.bell@example.com'),
('Tina', 'V.', 'Brooks', '22345678904', '1919 Ash St', '2234567890', '8765432109', 'tina.brooks@example.com'),
('Victor', 'W.', 'Reed', '33456789015', '2020 Cherry St', '3345678901', '7654321098', 'victor.reed@example.com'),
('Wendy', 'X.', 'Simmons', '44567890126', '2121 Fir St', '4456789012', '6543210987', 'wendy.simmons@example.com'),
('Xavier', 'Y.', 'King', '55678901237', '2222 Elm St', '5567890123', '5432109876', 'xavier.king@example.com'),
('Yasmine', 'Z.', 'Young', '66789012348', '2323 Oak St', '6678901234', '4321098765', 'yasmine.young@example.com');



INSERT INTO product (Pname, classification_kids, category, assessment, size) VALUES
('Toy Car', true, 'Brinquedos', 4.5, 'Small'),
('Laptop', false, 'Eletrônico', 4.8, 'Medium'),
('T-Shirt', false, 'Vestimenta', 4.3, 'Large'),
('Chair', false, 'Móveis',false, 'Standard'),
('Chips', false, 'Alimentos', 4.1, 'Packet');
INSERT INTO product (Pname, classification_kids, category, assessment, size) VALUES
('Toy Train', true, 'Brinquedos', 4.7, 'Medium'),
('Smartphone', false, 'Eletrônico', 4.9, 'Small'),
('Jeans', false, 'Vestimenta', 4.4, 'Large'),
('Table', false, 'Móveis', 4.6, 'Standard'),
('Cookies', true, 'Alimentos', 4.2, 'Packet'),
('Doll', true, 'Brinquedos', 4.8, 'Small'),
('Tablet', false, 'Eletrônico', 4.6, 'Medium'),
('Jacket', false, 'Vestimenta', 4.5, 'Large'),
('Sofa', false, 'Móveis', 4.7, 'Standard'),
('Chocolate', true, 'Alimentos', 4.3, 'Packet'),
('Building Blocks', true, 'Brinquedos', 4.9, 'Medium'),
('Headphones', false, 'Eletrônico', 4.8, 'Small'),
('Sweater', false, 'Vestimenta', 4.2, 'Large'),
('Bookshelf', false, 'Móveis', 4.4, 'Standard'),
('Candy', true, 'Alimentos', 4.1, 'Packet'),
('Puzzle', true, 'Brinquedos', 4.6, 'Medium'),
('Camera', false, 'Eletrônico', 4.7, 'Small'),
('Shorts', false, 'Vestimenta', 4.3, 'Large'),
('Desk', false, 'Móveis', 4.5, 'Standard'),
('Soda', false, 'Alimentos', 4.0, 'Bottle');


INSERT INTO payments (typePayment, limitAvailable, cvv, numbercard, datePayment) VALUES
('Crédito', 1000.00, 123, 4111111111111111, '2024-12-01 10:00:00'),
('Débito', NULL, NULL, NULL, '2024-12-02 11:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-03 12:00:00'),
('Boleto', NULL, NULL, NULL, '2024-12-04 13:00:00'),
('Crédito', 500.00, 456, 4222222222222222, '2024-12-05 14:00:00');
INSERT INTO payments (typePayment, limitAvailable, cvv, numbercard, datePayment) VALUES
('Débito', NULL, NULL, NULL, '2024-12-06 09:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-07 10:00:00'),
('Boleto', NULL, NULL, NULL, '2024-12-08 11:00:00'),
('Crédito', 2000.00, 789, 4333333333333333, '2024-12-09 12:00:00'),
('Crédito', 1500.00, 321, 4444444444444444, '2024-12-10 13:00:00'),
('Débito', NULL, NULL, NULL, '2024-12-11 14:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-12 15:00:00'),
('Boleto', NULL, NULL, NULL, '2024-12-13 16:00:00'),
('Crédito', 3000.00, 654, 4555555555555555, '2024-12-14 17:00:00'),
('Débito', NULL, NULL, NULL, '2024-12-15 18:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-16 19:00:00'),
('Boleto', NULL, NULL, NULL, '2024-12-17 20:00:00'),
('Crédito', 1000.00, 987, 4666666666666666, '2024-12-18 21:00:00'),
('Crédito', 2500.00, 741, 4777777777777777, '2024-12-19 22:00:00'),
('Débito', NULL, NULL, NULL, '2024-12-20 23:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-21 08:00:00'),
('Boleto', NULL, NULL, NULL, '2024-12-22 09:00:00'),
('Crédito', 1800.00, 852, 4888888888888888, '2024-12-23 10:00:00'),
('Crédito', 3500.00, 963, 4999999999999999, '2024-12-24 11:00:00'),
('Pix', NULL, NULL, NULL, '2024-12-25 12:00:00');



-- Continuar com os demais INSERTs, incluindo o valueOrder para cada um
-- Inserindo pedidos com os IDs dos produtos variando de 1 a 25 e quantidade
INSERT INTO orders (idOrderClient, IDOproduct, orderStatus, orderDescription, sendValue, paymentCash, dateOrder, idOPayment, valueOrder, quantity) VALUES
(1, 1, default, 'Order for electronics', 15.00, true, '2024-12-01 15:00:00', 1, 15.00, 2),
(2, 2, default, 'Order for furniture', 25.00, false, '2024-12-02 16:00:00', 2, 25.00, 1),
(3, 3, default, 'Order for clothes', 10.00, true, '2024-12-03 17:00:00', 3, 10.00, 3),
(4, 4, 'Confirmado', 'Order for toys', 5.00, false, '2024-12-04 18:00:00', 4, 5.00, 4),
(5, 5, 'Confirmado', 'Order for snacks', 8.00, true, '2024-12-05 19:00:00', 5, 8.00, 2),
(6, 6, default, 'Order for gadgets', 12.00, false, '2024-12-06 10:00:00', 6, 12.00, 1),
(7, 7, default, 'Order for home decor', 18.00, true, '2024-12-07 11:00:00', 7, 18.00, 2),
(8, 8, default, 'Order for books', 20.00, false, '2024-12-08 12:00:00', 8, 20.00, 5),
(9, 9, 'Confirmado', 'Order for beauty products', 7.50, true, '2024-12-09 13:00:00', 9, 7.50, 2),
(10, 10, 'Confirmado', 'Order for stationery', 9.00, false, '2024-12-10 14:00:00', 10, 9.00, 3),
(11, 11, default, 'Order for appliances', 30.00, true, '2024-12-11 15:00:00', 11, 30.00, 1),
(12, 12, default, 'Order for groceries', 5.50, false, '2024-12-12 16:00:00', 12, 5.50, 6),
(13, 13, default, 'Order for sports equipment', 22.00, true, '2024-12-13 17:00:00', 13, 22.00, 2),
(14, 14, 'Confirmado', 'Order for jewelry', 50.00, false, '2024-12-14 18:00:00', 14, 50.00, 1),
(15, 15, 'Confirmado', 'Order for kitchenware', 15.00, true, '2024-12-15 19:00:00', 15, 15.00, 3),
(16, 16, default, 'Order for outdoor gear', 25.00, false, '2024-12-16 20:00:00', 16, 25.00, 2),
(17, 17, default, 'Order for pet supplies', 10.00, true, '2024-12-17 21:00:00', 17, 10.00, 4),
(18, 18, default, 'Order for musical instruments', 40.00, false, '2024-12-18 22:00:00', 18, 40.00, 1),
(19, 19, 'Confirmado', 'Order for baby products', 6.00, true, '2024-12-19 23:00:00', 19, 6.00, 3),
(20, 20, 'Confirmado', 'Order for health items', 8.50, false, '2024-12-20 08:00:00', 20, 8.50, 2),
(21, 21, default, 'Order for cleaning supplies', 12.00, true, '2024-12-21 09:00:00', 21, 12.00, 3),
(22, 22, default, 'Order for automotive parts', 27.00, false, '2024-12-22 10:00:00', 22, 27.00, 2),
(23, 23, default, 'Order for art supplies', 14.00, true, '2024-12-23 11:00:00', 23, 14.00, 5),
(24, 24, 'Confirmado', 'Order for gardening tools', 19.50, false, '2024-12-24 12:00:00', 24, 19.50, 1),
(25, 25, 'Confirmado', 'Order for fitness equipment', 35.00, true, '2024-12-25 13:00:00', 25, 35.00, 3);


select * from clients;
select * from product;
select * from payments;
select * from orders;
desc orders;

INSERT INTO productStorage (storageLocation, quantity) VALUES
('Rio de Janeiro', 1000),
('Rio de Janeiro', 200),
('São Paulo', 150),
('São Paulo', 80),
('Brasília', 50);
INSERT INTO productStorage (storageLocation, quantity) VALUES
('Rio de Janeiro', 500),
('Rio de Janeiro', 300),
('Rio de Janeiro', 250),
('Rio de Janeiro', 600),
('Rio de Janeiro', 450),
('Rio de Janeiro', 700),
('São Paulo', 200),
('São Paulo', 300),
('São Paulo', 400),
('São Paulo', 250),
('São Paulo', 100),
('São Paulo', 600),
('Brasília', 200),
('Brasília', 150),
('Brasília', 300),
('Brasília', 100),
('Brasília', 80),
('Brasília', 250),
('Brasília', 350),
('Brasília', 400);

INSERT INTO supplier (SocialName, CNPJ, contact, adress, buyer, email) VALUES
('Supplier A', '12345678901234', '1234567890', '123 Elm St', 'John Doe', 'supplierA@example.com'),
('Supplier B', '23456789012345', '2345678901', '456 Oak St', 'Jane Smith', 'supplierB@example.com'),
('Supplier C', '34567890123456', '3456789012', '789 Pine St', 'Alice Johnson', 'supplierC@example.com'),
('Supplier D', '45678901234567', '4567890123', '101 Maple St', 'Bob Brown', 'supplierD@example.com'),
('Supplier E', '56789012345678', '5678901234', '202 Cedar St', 'Charlie White', 'supplierE@example.com');
select * from supplier;

INSERT INTO seller (SocialName, AbstractName, CNPJ, CPF, location, contact) VALUES
('Seller A', 'SellerGroup A', '12345678901234', '123456789', 'Rio de Janeiro', '1234567890'),
('Seller B', 'SellerGroup B', '23456789012345', '234567890', 'Rio de Janeiro', '2345678901'),
('Seller C', 'SellerGroup C', '34567890123456', '345678901', 'São Paulo', '3456789012'),
('Seller D', 'SellerGroup D', '45678901234567', '456789012', 'São Paulo', '4567890123'),
('Seller E', 'SellerGroup E', '56789012345678', '567890123', 'Paraná', '5678901234');

select * from seller;
INSERT INTO seller (SocialName, AbstractName, CNPJ, CPF, location, contact) VALUES
('Seller F', 'SellerGroup F', '67890123456789', '678901234', 'Rio de Janeiro', '6789012345'),
('Seller G', 'SellerGroup G', '78901234567890', '789012345', 'Rio de Janeiro', '7890123456'),
('Seller H', 'SellerGroup H', '89012345678901', '890123456', 'Rio de Janeiro', '8901234567'),
('Seller I', 'SellerGroup I', '90123456789012', '901234567', 'Rio de Janeiro', '9012345678'),
('Seller J', 'SellerGroup J', '01234567890123', '012345678', 'Rio de Janeiro', '0123456789'),
('Seller K', 'SellerGroup K', '11234567890134', '112345678', 'São Paulo', '1123456780'),
('Seller L', 'SellerGroup L', '21234567890145', '212345678', 'São Paulo', '2123456781'),
('Seller M', 'SellerGroup M', '31234567890156', '312345678', 'São Paulo', '3123456782'),
('Seller N', 'SellerGroup N', '41234567890167', '412345678', 'São Paulo', '4123456783'),
('Seller O', 'SellerGroup O', '51234567890178', '512345678', 'São Paulo', '5123456784'),
('Seller P', 'SellerGroup P', '61234567890189', '612345678', 'Paraná', '6123456785'),
('Seller Q', 'SellerGroup Q', '71234567890190', '712345678', 'Paraná', '7123456786'),
('Seller R', 'SellerGroup R', '81234567890201', '812345678', 'Paraná', '8123456787'),
('Seller S', 'SellerGroup S', '91234567890212', '912345678', 'Paraná', '9123456788'),
('Seller T', 'SellerGroup T', '01345678901223', '013456789', 'Paraná', '0134567890'),
('Seller U', 'SellerGroup U', '11345678901234', '113456789', 'Rio de Janeiro', '1134567891'),
('Seller V', 'SellerGroup V', '21345678901245', '213456789', 'Rio de Janeiro', '2134567892'),
('Seller W', 'SellerGroup W', '31345678901256', '313456789', 'São Paulo', '3134567893'),
('Seller X', 'SellerGroup X', '41345678901267', '413456789', 'São Paulo', '4134567894'),
('Seller Y', 'SellerGroup Y', '51345678901278', '513456789', 'Paraná', '5134567895');


INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
(1, 1, 50),
(2, 2, 60),
(3, 3, 40),
(4, 4, 30),
(5, 5, 20);

select * from productSeller;
Alter table productSeller auto_increment = 6;


INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
(1, 51, 10, null),
(2, 52, 15, null),
(3, 53, 20, null),
(4, 54, 5, null),
(5, 55, 8, null);

INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
(6, 56, 30, 'Pending'),
(7, 57, 50, 'Shipped'),
(8, 58, 20, 'Delivered'),
(9, 59, 15, 'Cancelled'),
(10, 60, 10, 'Pending'),
(11, 61, 60, 'Shipped'),
(12, 62, 45, 'Delivered'),
(13, 63, 35, 'Pending'),
(14, 64, 50, 'Shipped'),
(15, 65, 25, 'Delivered'),
(16, 66, 30, 'Pending'),
(17, 67, 55, 'Shipped'),
(18, 68, 40, 'Delivered'),
(19, 69, 25, 'Pending'),
(20, 70, 50, 'Shipped'),
(21, 71, 60, 'Delivered'),
(22, 72, 40, 'Pending'),
(23, 73, 30, 'Shipped'),
(24, 74, 25, 'Delivered'),
(25, 75, 10, 'Pending');


select * from orders;

select * from productOrder;

INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
(6, 1, 'RJ'),
(7, 2, 'SP'),
(8, 3, 'GO'),
(9, 4, 'GO'),
(10, 5, 'SP'),
(11, 1, 'RJ'),
(12, 2, 'SP'),
(13, 3, 'GO'),
(14, 4, 'GO'),
(15, 5, 'SP'),
(16, 1, 'RJ'),
(17, 2, 'SP'),
(18, 3, 'GO'),
(19, 4, 'GO'),
(20, 5, 'SP'),
(21, 1, 'RJ'),
(22, 2, 'SP'),
(23, 3, 'GO'),
(24, 4, 'GO'),
(25, 5, 'SP');
select * from storageLocation;
show tables;

INSERT INTO productSupplier (IdPsSupplier, idPsProduct, quantity) VALUES
(1, 1, 100),
(2, 2, 200),
(3, 3, 150),
(4, 4, 80),
(5, 5, 50);

select * from productSupplier;
INSERT INTO productSupplier (IdPsSupplier, idPsProduct, quantity) VALUES
(1, 6, 120),
(2, 7, 220),
(3, 8, 130),
(4, 9, 90),
(5, 10, 60),
(1, 11, 140),
(2, 12, 180),
(3, 13, 110),
(4, 14, 70),
(5, 15, 40),
(1, 16, 130),
(2, 17, 160),
(3, 18, 110),
(4, 19, 50),
(5, 20, 70),
(1, 21, 100),
(2, 22, 150),
(3, 23, 120),
(4, 24, 80),
(5, 25, 90);


show tables;

-- quantos clientes temos cadastrados

select count(*) from  clients as totalClient;


-- contagem por Status da Order de Serviço

select orderStatus, count(*) from orders
		group by  orderStatus;
        
-- contagem por tipo de ordem
SELECT count(*) as total,o.orderStatus , orderDescription , typePayment
FROM orders o 
INNER JOIN payments p ON o.idOPayment = p.idPayment and o.orderStatus = "Confirmado" 
INNER JOIN  clients c on idOrderClient = c.idClient
			group by orderDescription;

show tables;

select  * from orders;

-- valor total das vendas confirmadas
select sum((valueOrder * quantity)) as ValorVendasConfirmadas from orders where orderStatus = "Confirmado";

-- media das compras confirmadas e em processamento
SELECT orderStatus, AVG(valueOrder) AS average_order_value
FROM orders
GROUP BY orderStatus;


-- produtos com quantidade maior que 50

SELECT idPOproduct, SUM(poQuantity) AS totalQuantity
FROM productOrder
GROUP BY idPOproduct
HAVING totalQuantity > 50;




