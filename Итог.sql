-- Таблица Событий
CREATE TABLE Event (
    EventID INT IDENTITY PRIMARY KEY,
    Date DATE,
    Name NVARCHAR(255),
    StartDate DATETIME2,
    EndDate DATETIME2,
    Description NVARCHAR(255),
    VisitorLimit INT,
    AgeRestriction INT
);
-- Таблица Руководителей
CREATE TABLE Supervisor (
    SupervisorID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,  -- Уникальный Email
    Phone NVARCHAR(20) UNIQUE,   -- Уникальный Phone
    Department NVARCHAR(255),
    Password NVARCHAR(255)
);
-- Обновленная таблица Аттракционов
CREATE TABLE Attraction (
    AttractionID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    SafetyStatus NVARCHAR(50) CHECK (SafetyStatus IN ('Open', 'Closed for Restoration')),
    Description NVARCHAR(500)  -- Добавлено поле для краткого описания
);

-- Обновленная таблица Билетов
CREATE TABLE Ticket (
    TicketID INT IDENTITY PRIMARY KEY,
    Status NVARCHAR(50),
    ExpirationDate DATE,
    AvailableAttractions NVARCHAR(255),
    EventID INT,  -- Ссылка на событие
    AttractionID INT,
    Price DECIMAL(10, 2),  -- Добавлено поле для цены билета
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (AttractionID) REFERENCES Attraction(AttractionID)  -- Связь с аттракционами
);




-- Таблица Сотрудников
CREATE TABLE Employee (
    EmployeeID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255),
    Position NVARCHAR(50),
    HireDate DATE,
    Phone NVARCHAR(20) UNIQUE,   -- Уникальный Phone
    SupervisorID INT,  -- Ссылка на руководителя
    Password NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,   -- Уникальный Email
    FOREIGN KEY (SupervisorID) REFERENCES Supervisor(SupervisorID)  -- Связь с руководителем
);

-- Таблица Клиентов
CREATE TABLE Client (
    ClientID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50),
    Email NVARCHAR(50) UNIQUE,   -- Уникальный Email
    DateOfBirth DATE,
    Address NVARCHAR(255),
    Phone NVARCHAR(20) UNIQUE,   -- Уникальный Phone
    Password NVARCHAR(255)
);
-- Таблица Заказов
CREATE TABLE [Order] (
    OrderID INT IDENTITY PRIMARY KEY,
    VisitDate DATE,
    TicketQuantity INT,
    TotalPrice DECIMAL(10, 2),
    UniqueCode NVARCHAR(255),
    ClientID INT,  -- Ссылка на клиента
    EmployeeID INT,  -- Ссылка на сотрудника, обработавшего заказ
    TicketID INT,  -- Ссылка на билет
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)  -- Связь с билетами
);


-- Заполнение таблицы Event (События)
INSERT INTO Event (Date, Name, StartDate, EndDate, Description, VisitorLimit, AgeRestriction)
VALUES
    ('2024-11-01', 'Концерт', '2024-11-01 19:00:00', '2024-11-01 22:00:00', 'Живое музыкальное представление', 500, 18),
    ('2024-12-15', 'Выставка Искусств', '2024-12-15 10:00:00', '2024-12-15 18:00:00', 'Современные художественные работы', 300, 12),
    ('2025-01-20', 'Техническая Конференция', '2025-01-20 09:00:00', '2025-01-20 17:00:00', 'Доклады об инновационных технологиях', 800, 21);

-- Заполнение таблицы Supervisor (Руководители)
INSERT INTO Supervisor (Name, Email, Phone, Department, Password)
VALUES
    ('Алиса Смирнова', 'alice.smirnova@example.com', '123-456-7890', 'Управление', 'password123'),
    ('Боб Иванов', 'bob.ivanov@example.com', '234-567-8901', 'Технический отдел', 'password456'),
    ('Чарли Петров', 'charlie.petrov@example.com', '345-678-9012', 'Обслуживание клиентов', 'password789');

-- Заполнение таблицы Employee (Сотрудники)
INSERT INTO Employee (Name, Position, HireDate, Phone, SupervisorID, Password, Email)
VALUES
    ('Ева Адамс', 'Техник', '2023-01-10', '456-789-0123', 2, 'password321', 'eva.adams@example.com'),
    ('Даниил Белый', 'Координатор мероприятий', '2022-05-15', '567-890-1234', 1, 'password654', 'daniel.beliy@example.com'),
    ('Грейс Ли', 'Служба поддержки клиентов', '2023-09-20', '678-901-2345', 3, 'password987', 'grace.lee@example.com');

-- Заполнение таблицы Client (Клиенты)
INSERT INTO Client (Name, Email, DateOfBirth, Address, Phone, Password)
VALUES
    ('Джон Доу', 'john.doe@example.com', '1985-07-15', 'Ул. Лиственная, 123', '789-012-3456', 'password111'),
    ('Джейн Роу', 'jane.roe@example.com', '1990-11-20', 'Ул. Кленовая, 456', '890-123-4567', 'password222'),
    ('Ричард Майлз', 'richard.miles@example.com', '1978-02-05', 'Ул. Дубовая, 789', '901-234-5678', 'password333');


	
-- Заполнение таблицы Ticket (Билеты)
INSERT INTO Ticket (Status, ExpirationDate, AvailableAttractions, EventID, AttractionID, Price)
VALUES 
    ('Активен', '2024-11-01', 'Американские горки, Автодром', 1, 1, 500.00),
    ('Активен', '2024-12-15', 'Колесо обозрения, Комната страха', 2, 2, 450.00),
    ('Использован', '2024-11-01', 'Комната страха', 1, 3, 300.00),
    ('Активен', '2025-01-20', 'Автодром', 3, 4, 200.00), 
    ('Активен', '2024-12-15', 'Водные горки', 2, 5, 600.00); 

-- Заполнение таблицы Attraction (Аттракционы)
INSERT INTO Attraction (Name, SafetyStatus, Description)
VALUES 
    ('Американские горки', 'Open', 'Экстремальные горки с крутыми спусками и подъёмами'),
    ('Колесо обозрения', 'Closed for Restoration', 'Высокое колесо обозрения с панорамным видом на парк'),
    ('Комната страха', 'Open', 'Мистическая комната с пугающими эффектами'),
    ('Автодром', 'Open', 'Катание на машинках с возможностью столкновений'),
    ('Водные горки', 'Closed for Restoration', 'Аквапарк с горками разной высоты и сложности');
	
	INSERT INTO [Order] (VisitDate, TicketQuantity, TotalPrice, UniqueCode, ClientID, EmployeeID, TicketID)
VALUES
    ('2024-11-01', 2, 150.00, 'ORD12345', 1, 2, 4), -- TicketID=1
    ('2024-12-15', 1, 75.00, 'ORD67890', 2, 1, 2), -- TicketID=2
    ('2025-01-20', 3, 225.00, 'ORD54321', 3, 3, 3); -- TicketID=3
-- Вывести данные из таблицы Event (События)
SELECT * FROM Event;

-- Вывести данные из таблицы Attraction (Аттракционы)
SELECT * FROM Attraction;

-- Вывести данные из таблицы Supervisor (Руководители)
SELECT * FROM Supervisor;

-- Вывести данные из таблицы Employee (Сотрудники)
SELECT * FROM Employee;

-- Вывести данные из таблицы Client (Клиенты)
SELECT * FROM Client;

-- Вывести данные из таблицы Order (Заказы)
SELECT * FROM [Order];

-- Вывести данные из таблицы Ticket (Билеты)
SELECT * FROM Ticket;
