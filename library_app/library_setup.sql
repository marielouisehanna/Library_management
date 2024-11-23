-- Create Librarians table (only if not exists)
CREATE TABLE IF NOT EXISTS Librarians (
    LibrarianID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    ContactInformation TEXT NOT NULL,
    HireDate DATE NOT NULL
);

-- Create Members table (only if not exists)
CREATE TABLE IF NOT EXISTS Members (
    MemberID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    ContactInformation TEXT NOT NULL,
    MembershipDate DATE NOT NULL,
    MemberType TEXT NOT NULL,
    MaxBooksAllowed INTEGER NOT NULL,
    MaxDurationAllowed INTEGER NOT NULL
);

-- Create Books table (only if not exists)
CREATE TABLE IF NOT EXISTS Books (
    BookID INTEGER PRIMARY KEY AUTOINCREMENT,
    ISBN TEXT UNIQUE NOT NULL,
    Title TEXT NOT NULL,
    Author TEXT NOT NULL,
    Genre TEXT NOT NULL,
    AvailabilityStatus TEXT NOT NULL,
    IssuedBy INTEGER,
    IssueDate DATE,
    DueDate DATE,
    IssuedTo INTEGER,
    Duration INTEGER,
    FOREIGN KEY (IssuedBy) REFERENCES Librarians (LibrarianID),
    FOREIGN KEY (IssuedTo) REFERENCES Members (MemberID)
);

-- Create Transactions table (only if not exists)
CREATE TABLE IF NOT EXISTS Transactions (
    TransactionID INTEGER PRIMARY KEY AUTOINCREMENT,
    MemberID INTEGER NOT NULL,
    BookID INTEGER NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    Duration INTEGER NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members (MemberID),
    FOREIGN KEY (BookID) REFERENCES Books (BookID)
);

-- Create Fines table (only if not exists)
CREATE TABLE IF NOT EXISTS Fines (
    FineID INTEGER PRIMARY KEY AUTOINCREMENT,
    TransactionID INTEGER NOT NULL,
    Amount REAL NOT NULL,
    PaymentStatus TEXT NOT NULL,
    FineDate DATE NOT NULL,
    PaidDate DATE,
    IsOverdue INTEGER NOT NULL CHECK (IsOverdue IN (0, 1)),
    FOREIGN KEY (TransactionID) REFERENCES Transactions (TransactionID)
);

-- Insert data into Librarians table
INSERT INTO Librarians (Name, ContactInformation, HireDate) VALUES
('Alice Johnson', 'alice.johnson@example.com', '2021-05-12'),
('Bob Smith', 'bob.smith@example.com', '2019-08-21'),
('Catherine Brown', 'catherine.brown@example.com', '2020-11-02'),
('David Williams', 'david.williams@example.com', '2018-04-15'),
('Emily Davis', 'emily.davis@example.com', '2022-01-10'),
('Frank Thomas', 'frank.thomas@example.com', '2021-03-22'),
('Grace Wilson', 'grace.wilson@example.com', '2020-07-18'),
('Henry Moore', 'henry.moore@example.com', '2017-06-30'),
('Ivy Taylor', 'ivy.taylor@example.com', '2021-09-25'),
('Jack Harris', 'jack.harris@example.com', '2016-12-19');

-- Insert data into Members table
INSERT INTO Members (Name, ContactInformation, MembershipDate, MemberType, MaxBooksAllowed, MaxDurationAllowed) VALUES
('John Doe', 'john.doe@example.com', '2022-03-15', 'Regular', 5, 30),
('Jane Smith', 'jane.smith@example.com', '2021-08-19', 'Premium', 10, 60),
('Michael Brown', 'michael.brown@example.com', '2020-11-05', 'Regular', 5, 30),
('Sarah Johnson', 'sarah.johnson@example.com', '2019-02-10', 'Regular', 5, 30),
('Chris Davis', 'chris.davis@example.com', '2022-06-23', 'Premium', 10, 60),
('Emma Wilson', 'emma.wilson@example.com', '2021-01-08', 'Regular', 5, 30),
('Daniel Taylor', 'daniel.taylor@example.com', '2020-05-11', 'Premium', 10, 60),
('Sophia Martinez', 'sophia.martinez@example.com', '2021-09-15', 'Regular', 5, 30),
('Luke Anderson', 'luke.anderson@example.com', '2022-04-20', 'Premium', 10, 60),
('Olivia Thomas', 'olivia.thomas@example.com', '2020-12-25', 'Regular', 5, 30);

INSERT INTO Books (ISBN, Title, Author, Genre, AvailabilityStatus) VALUES
('978-1250776090', 'It Ends with Us', 'Colleen Hoover', 'Romance', 'Available'),
('978-1524763169', 'Becoming', 'Michelle Obama', 'Biography', 'Issued'),
('978-1250857553', 'Tomorrow, and Tomorrow, and Tomorrow', 'Gabrielle Zevin', 'Fiction', 'Available'),
('978-0063204157', 'Verity', 'Colleen Hoover', 'Thriller', 'Available'),
('978-1501171345', 'Ugly Love', 'Colleen Hoover', 'Romance', 'Issued'),
('978-1982149483', 'A Man Called Ove', 'Fredrik Backman', 'Fiction', 'Available'),
('978-0063068923', 'Reminders of Him', 'Colleen Hoover', 'Romance', 'Available'),
('978-1250810917', 'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'Historical Fiction', 'Available'),
('978-0593189574', 'Malibu Rising', 'Taylor Jenkins Reid', 'Fiction', 'Issued'),
('978-0062969801', 'Book Lovers', 'Emily Henry', 'Romance', 'Available'),
('978-0316393874', 'Fourth Wing', 'Rebecca Yarros', 'Fantasy', 'Available'),
('978-0593329825', 'The Paris Library', 'Janet Skeslien Charles', 'Historical Fiction', 'Issued'),
('978-1501170621', 'Daisy Jones & The Six', 'Taylor Jenkins Reid', 'Fiction', 'Available'),
('978-0593421918', 'The Last House on Needless Street', 'Catriona Ward', 'Thriller', 'Available'),
('978-0593419090', 'The Love Hypothesis', 'Ali Hazelwood', 'Romance', 'Available'),
('978-0316499345', 'Project Hail Mary', 'Andy Weir', 'Science Fiction', 'Issued'),
('978-0593203629', 'Where the Crawdads Sing', 'Delia Owens', 'Mystery', 'Available'),
('978-1501171803', 'People We Meet on Vacation', 'Emily Henry', 'Romance', 'Available'),
('978-1524763161', 'The Midnight Library', 'Matt Haig', 'Fiction', 'Available'),
('978-0525559474', 'A Court of Thorns and Roses', 'Sarah J. Maas', 'Fantasy', 'Issued');

-- Insert data into Transactions table
INSERT INTO Transactions (MemberID, BookID, BorrowDate, ReturnDate, Duration) VALUES
(1, 2, '2023-11-01', NULL, 30),
(4, 6, '2023-10-20', '2023-11-15', 30);

-- Insert data into Fines table
INSERT INTO Fines (TransactionID, Amount, PaymentStatus, FineDate, PaidDate, IsOverdue) VALUES
(2, 5.00, 'Paid', '2023-11-15', '2023-11-16', 1),
(4, 3.00, 'Unpaid', '2023-11-11', NULL, 1);
