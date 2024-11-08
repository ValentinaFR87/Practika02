-- ������� �������
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
-- ������� �������������
CREATE TABLE Supervisor (
    SupervisorID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,  -- ���������� Email
    Phone NVARCHAR(20) UNIQUE,   -- ���������� Phone
    Department NVARCHAR(255),
    Password NVARCHAR(255)
);
-- ����������� ������� ������������
CREATE TABLE Attraction (
    AttractionID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    SafetyStatus NVARCHAR(50) CHECK (SafetyStatus IN ('Open', 'Closed for Restoration')),
    Description NVARCHAR(500)  -- ��������� ���� ��� �������� ��������
);

-- ����������� ������� �������
CREATE TABLE Ticket (
    TicketID INT IDENTITY PRIMARY KEY,
    Status NVARCHAR(50),
    ExpirationDate DATE,
    AvailableAttractions NVARCHAR(255),
    EventID INT,  -- ������ �� �������
    AttractionID INT,
    Price DECIMAL(10, 2),  -- ��������� ���� ��� ���� ������
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (AttractionID) REFERENCES Attraction(AttractionID)  -- ����� � �������������
);




-- ������� �����������
CREATE TABLE Employee (
    EmployeeID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255),
    Position NVARCHAR(50),
    HireDate DATE,
    Phone NVARCHAR(20) UNIQUE,   -- ���������� Phone
    SupervisorID INT,  -- ������ �� ������������
    Password NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,   -- ���������� Email
    FOREIGN KEY (SupervisorID) REFERENCES Supervisor(SupervisorID)  -- ����� � �������������
);

-- ������� ��������
CREATE TABLE Client (
    ClientID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50),
    Email NVARCHAR(50) UNIQUE,   -- ���������� Email
    DateOfBirth DATE,
    Address NVARCHAR(255),
    Phone NVARCHAR(20) UNIQUE,   -- ���������� Phone
    Password NVARCHAR(255)
);
-- ������� �������
CREATE TABLE [Order] (
    OrderID INT IDENTITY PRIMARY KEY,
    VisitDate DATE,
    TicketQuantity INT,
    TotalPrice DECIMAL(10, 2),
    UniqueCode NVARCHAR(255),
    ClientID INT,  -- ������ �� �������
    EmployeeID INT,  -- ������ �� ����������, ������������� �����
    TicketID INT,  -- ������ �� �����
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)  -- ����� � ��������
);


-- ���������� ������� Event (�������)
INSERT INTO Event (Date, Name, StartDate, EndDate, Description, VisitorLimit, AgeRestriction)
VALUES
    ('2024-11-01', '�������', '2024-11-01 19:00:00', '2024-11-01 22:00:00', '����� ����������� �������������', 500, 18),
    ('2024-12-15', '�������� ��������', '2024-12-15 10:00:00', '2024-12-15 18:00:00', '����������� �������������� ������', 300, 12),
    ('2025-01-20', '����������� �����������', '2025-01-20 09:00:00', '2025-01-20 17:00:00', '������� �� ������������� �����������', 800, 21);

-- ���������� ������� Supervisor (������������)
INSERT INTO Supervisor (Name, Email, Phone, Department, Password)
VALUES
    ('����� ��������', 'alice.smirnova@example.com', '123-456-7890', '����������', 'password123'),
    ('��� ������', 'bob.ivanov@example.com', '234-567-8901', '����������� �����', 'password456'),
    ('����� ������', 'charlie.petrov@example.com', '345-678-9012', '������������ ��������', 'password789');

-- ���������� ������� Employee (����������)
INSERT INTO Employee (Name, Position, HireDate, Phone, SupervisorID, Password, Email)
VALUES
    ('��� �����', '������', '2023-01-10', '456-789-0123', 2, 'password321', 'eva.adams@example.com'),
    ('������ �����', '����������� �����������', '2022-05-15', '567-890-1234', 1, 'password654', 'daniel.beliy@example.com'),
    ('����� ��', '������ ��������� ��������', '2023-09-20', '678-901-2345', 3, 'password987', 'grace.lee@example.com');

-- ���������� ������� Client (�������)
INSERT INTO Client (Name, Email, DateOfBirth, Address, Phone, Password)
VALUES
    ('���� ���', 'john.doe@example.com', '1985-07-15', '��. ����������, 123', '789-012-3456', 'password111'),
    ('����� ���', 'jane.roe@example.com', '1990-11-20', '��. ��������, 456', '890-123-4567', 'password222'),
    ('������ �����', 'richard.miles@example.com', '1978-02-05', '��. �������, 789', '901-234-5678', 'password333');


	
-- ���������� ������� Ticket (������)
INSERT INTO Ticket (Status, ExpirationDate, AvailableAttractions, EventID, AttractionID, Price)
VALUES 
    ('�������', '2024-11-01', '������������ �����, ��������', 1, 1, 500.00),
    ('�������', '2024-12-15', '������ ���������, ������� ������', 2, 2, 450.00),
    ('�����������', '2024-11-01', '������� ������', 1, 3, 300.00),
    ('�������', '2025-01-20', '��������', 3, 4, 200.00), 
    ('�������', '2024-12-15', '������ �����', 2, 5, 600.00); 

-- ���������� ������� Attraction (�����������)
INSERT INTO Attraction (Name, SafetyStatus, Description)
VALUES 
    ('������������ �����', 'Open', '������������� ����� � ������� �������� � ���������'),
    ('������ ���������', 'Closed for Restoration', '������� ������ ��������� � ���������� ����� �� ����'),
    ('������� ������', 'Open', '����������� ������� � ��������� ���������'),
    ('��������', 'Open', '������� �� �������� � ������������ ������������'),
    ('������ �����', 'Closed for Restoration', '�������� � ������� ������ ������ � ���������');
	
	INSERT INTO [Order] (VisitDate, TicketQuantity, TotalPrice, UniqueCode, ClientID, EmployeeID, TicketID)
VALUES
    ('2024-11-01', 2, 150.00, 'ORD12345', 1, 2, 4), -- TicketID=1
    ('2024-12-15', 1, 75.00, 'ORD67890', 2, 1, 2), -- TicketID=2
    ('2025-01-20', 3, 225.00, 'ORD54321', 3, 3, 3); -- TicketID=3
-- ������� ������ �� ������� Event (�������)
SELECT * FROM Event;

-- ������� ������ �� ������� Attraction (�����������)
SELECT * FROM Attraction;

-- ������� ������ �� ������� Supervisor (������������)
SELECT * FROM Supervisor;

-- ������� ������ �� ������� Employee (����������)
SELECT * FROM Employee;

-- ������� ������ �� ������� Client (�������)
SELECT * FROM Client;

-- ������� ������ �� ������� Order (������)
SELECT * FROM [Order];

-- ������� ������ �� ������� Ticket (������)
SELECT * FROM Ticket;
