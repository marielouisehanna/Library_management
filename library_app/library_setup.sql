-- Create Librarians table (only if not exists)
CREATE TABLE IF NOT EXISTS Librarians (
    LibrarianID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    ContactInformation TEXT NOT NULL UNIQUE,
    HireDate DATE NOT NULL
);

-- Create Members table (only if not exists)
CREATE TABLE IF NOT EXISTS Members (
    MemberID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    ContactInformation TEXT NOT NULL UNIQUE,
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
    FOREIGN KEY (IssuedTo) REFERENCES Members (MemberID),
    UNIQUE (Title, Author) -- Ensure unique Title and Author combination
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

-- Insert additional Librarians
INSERT INTO Librarians (Name, ContactInformation, HireDate) VALUES
('Kelly Brooks', 'kelly.brooks@example.com', '2023-03-12'),
('Liam Turner', 'liam.turner@example.com', '2022-10-15'),
('Mason Hall', 'mason.hall@example.com', '2021-07-01');

-- Insert additional Members
INSERT INTO Members (Name, ContactInformation, MembershipDate, MemberType, MaxBooksAllowed, MaxDurationAllowed) VALUES
('Ava White', 'ava.white@example.com', '2023-01-19', 'Premium', 10, 60),
('Sophia Green', 'sophia.green@example.com', '2021-06-11', 'Regular', 5, 30),
('Ethan Clark', 'ethan.clark@example.com', '2020-09-03', 'Regular', 5, 30),
('Isabella Walker', 'isabella.walker@example.com', '2023-05-22', 'Premium', 10, 60),
('James Scott', 'james.scott@example.com', '2022-08-14', 'Regular', 5, 30),
('Charlotte Adams', 'charlotte.adams@example.com', '2021-03-27', 'Regular', 5, 30),
('William Baker', 'william.baker@example.com', '2023-02-09', 'Premium', 10, 60),
('Liam Evans', 'liam.evans@example.com', '2023-03-01', 'Regular', 5, 30),
('Mia Lopez', 'mia.lopez@example.com', '2022-11-21', 'Premium', 10, 60),
('Noah Walker', 'noah.walker@example.com', '2021-09-17', 'Regular', 5, 30),
('Sophia Carter', 'sophia.carter@example.com', '2020-05-23', 'Premium', 10, 60),
('James Taylor', 'james.taylor@example.com', '2023-06-05', 'Regular', 5, 30),
('Amelia Rivera', 'amelia.rivera@example.com', '2021-04-12', 'Premium', 10, 60),
('Oliver Turner', 'oliver.turner@example.com', '2022-08-28', 'Regular', 5, 30),
('Charlotte Edwards', 'charlotte.edwards@example.com', '2023-02-19', 'Premium', 10, 60),
('Henry Wright', 'henry.wright@example.com', '2020-07-03', 'Regular', 5, 30),
('Isabella Bennett', 'isabella.bennett@example.com', '2021-12-15', 'Premium', 10, 60);

-- Insert additional Books
INSERT INTO Books (ISBN, Title, Author, Genre, AvailabilityStatus) VALUES
('978-0451490711', 'The Song of Achilles', 'Madeline Miller', 'Fiction', 'Available'),
('978-0345538376', 'Circe', 'Madeline Miller', 'Fantasy', 'Issued'),
('978-0062358202', 'The Alchemist', 'Paulo Coelho', 'Philosophy', 'Available'),
('978-0143127550', 'Educated', 'Tara Westover', 'Memoir', 'Available'),
('978-0553380163', 'The Road', 'Cormac McCarthy', 'Fiction', 'Issued'),
('978-1250313172', 'Beach Read', 'Emily Henry', 'Romance', 'Available'),
('978-1524762941', 'Origin', 'Dan Brown', 'Thriller', 'Available'),
('978-0593188940', 'The Guest List', 'Lucy Foley', 'Mystery', 'Issued'),
('978-0142000670', 'The Catcher in the Rye', 'J.D. Salinger', 'Classic', 'Available'),
('978-1501128035', 'The Light We Lost', 'Jill Santopolo', 'Romance', 'Available'),
('978-0143110439', 'Outliers', 'Malcolm Gladwell', 'Psychology', 'Available'),
('978-0307277785', 'The Immortal Life of Henrietta Lacks', 'Rebecca Skloot', 'Biography', 'Available'),
('978-0679783275', 'Pride and Prejudice', 'Jane Austen', 'Classic', 'Available'),
('978-0140177398', 'Of Mice and Men', 'John Steinbeck', 'Classic', 'Available'),
('978-0812973815', 'The Kite Runner', 'Khaled Hosseini', 'Fiction', 'Issued'),
('978-0553296983', 'Dune', 'Frank Herbert', 'Science Fiction', 'Available'),
('978-0812993547', 'Gone Girl', 'Gillian Flynn', 'Thriller', 'Issued'),
('978-1400078776', 'Life of Pi', 'Yann Martel', 'Adventure', 'Issued'),
('978-0140283334', 'Angela’s Ashes', 'Frank McCourt', 'Memoir', 'Available'),
('978-0385484517', 'The Poisonwood Bible', 'Barbara Kingsolver', 'Fiction', 'Available');

-- Insert additional Transactions
INSERT INTO Transactions (MemberID, BookID, BorrowDate, ReturnDate, Duration) VALUES
(2, 5, '2023-11-10', NULL, 30),
(5, 15, '2023-10-25', NULL, 30),
(7, 16, '2023-10-28', '2023-11-15', 30),
(8, 8, '2023-11-05', NULL, 30),
(10, 9, '2023-10-18', '2023-11-02', 30),
(1, 13, '2023-11-14', NULL, 30),
(3, 4, '2023-11-12', NULL, 30);

-- Insert additional Fines
INSERT INTO Fines (TransactionID, Amount, PaymentStatus, FineDate, PaidDate, IsOverdue) VALUES
(3, 10.00, 'Unpaid', '2023-11-20', NULL, 1),
(5, 2.50, 'Paid', '2023-11-17', '2023-11-19', 1),
(6, 1.00, 'Paid', '2023-11-15', '2023-11-16', 1),
(7, 3.50, 'Unpaid', '2023-11-20', NULL, 1),
(8, 0.00, 'Paid', '2023-11-02', '2023-11-03', 0),
(9, 5.00, 'Unpaid', '2023-11-21', NULL, 1),
(10, 8.00, 'Unpaid', '2023-11-22', NULL, 1);

-- Update some book statuses to reflect new transactions
UPDATE Books SET AvailabilityStatus = 'Issued' WHERE BookID IN (5, 16, 8, 4, 9, 13);