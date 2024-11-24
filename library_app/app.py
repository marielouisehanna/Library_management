from flask import Flask, render_template, request, redirect, url_for
import sqlite3

app = Flask(__name__)

# Database connection function
def get_db_connection():
    conn = sqlite3.connect('library.db')
    conn.row_factory = sqlite3.Row
    return conn

# Home route
@app.route('/')
def index():
    return render_template('index.html')

# CRUD for Librarians
@app.route('/librarians')
def librarians():
    conn = get_db_connection()
    librarians = conn.execute('SELECT * FROM Librarians').fetchall()
    conn.close()
    return render_template('librarians.html', librarians=librarians)

@app.route('/add_librarian', methods=('GET', 'POST'))
def add_librarian():
    if request.method == 'POST':
        name = request.form['name']
        contact_info = request.form['contact_info']
        hire_date = request.form['hire_date']
        conn = get_db_connection()
        conn.execute('INSERT INTO Librarians (Name, ContactInformation, HireDate) VALUES (?, ?, ?)',
                     (name, contact_info, hire_date))
        conn.commit()
        conn.close()
        return redirect(url_for('librarians'))
    return render_template('add_librarian.html')

@app.route('/edit_librarian/<int:id>', methods=('GET', 'POST'))
def edit_librarian(id):
    conn = get_db_connection()
    librarian = conn.execute('SELECT * FROM Librarians WHERE LibrarianID = ?', (id,)).fetchone()
    if request.method == 'POST':
        name = request.form['name']
        contact_info = request.form['contact_info']
        hire_date = request.form['hire_date']
        conn.execute('UPDATE Librarians SET Name = ?, ContactInformation = ?, HireDate = ? WHERE LibrarianID = ?',
                     (name, contact_info, hire_date, id))
        conn.commit()
        conn.close()
        return redirect(url_for('librarians'))
    conn.close()
    return render_template('edit_librarian.html', librarian=librarian)

@app.route('/delete_librarian/<int:id>', methods=('POST',))
def delete_librarian(id):
    conn = get_db_connection()
    conn.execute('DELETE FROM Librarians WHERE LibrarianID = ?', (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('librarians'))

# CRUD for Books
@app.route('/books')
def books():
    conn = get_db_connection()
    books = conn.execute('SELECT * FROM Books').fetchall()
    conn.close()
    return render_template('books.html', books=books)

@app.route('/add_book', methods=('GET', 'POST'))
def add_book():
    if request.method == 'POST':
        isbn = request.form['isbn']
        title = request.form['title']
        author = request.form['author']
        genre = request.form['genre']
        availability = request.form['availability']
        conn = get_db_connection()
        conn.execute('INSERT INTO Books (ISBN, Title, Author, Genre, AvailabilityStatus) VALUES (?, ?, ?, ?, ?)',
                     (isbn, title, author, genre, availability))
        conn.commit()
        conn.close()
        return redirect(url_for('books'))
    return render_template('add_book.html')

@app.route('/edit_book/<int:id>', methods=('GET', 'POST'))
def edit_book(id):
    conn = get_db_connection()
    book = conn.execute('SELECT * FROM Books WHERE BookID = ?', (id,)).fetchone()
    if request.method == 'POST':
        isbn = request.form['isbn']
        title = request.form['title']
        author = request.form['author']
        genre = request.form['genre']
        availability = request.form['availability']
        conn.execute('UPDATE Books SET ISBN = ?, Title = ?, Author = ?, Genre = ?, AvailabilityStatus = ? WHERE BookID = ?',
                     (isbn, title, author, genre, availability, id))
        conn.commit()
        conn.close()
        return redirect(url_for('books'))
    conn.close()
    return render_template('edit_book.html', book=book)

@app.route('/delete_book/<int:id>', methods=('POST',))
def delete_book(id):
    conn = get_db_connection()
    conn.execute('DELETE FROM Books WHERE BookID = ?', (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('books'))

# CRUD for Members
@app.route('/members')
def members():
    conn = get_db_connection()
    members = conn.execute('SELECT * FROM Members').fetchall()
    conn.close()
    return render_template('members.html', members=members)

@app.route('/add_member', methods=('GET', 'POST'))
def add_member():
    if request.method == 'POST':
        name = request.form['name']
        contact_info = request.form['contact_info']
        membership_date = request.form['membership_date']
        member_type = request.form['member_type']
        max_books = request.form['max_books']
        max_duration = request.form['max_duration']
        conn = get_db_connection()
        conn.execute('INSERT INTO Members (Name, ContactInformation, MembershipDate, MemberType, MaxBooksAllowed, MaxDurationAllowed) VALUES (?, ?, ?, ?, ?, ?)',
                     (name, contact_info, membership_date, member_type, max_books, max_duration))
        conn.commit()
        conn.close()
        return redirect(url_for('members'))
    return render_template('add_member.html')

@app.route('/edit_member/<int:id>', methods=('GET', 'POST'))
def edit_member(id):
    conn = get_db_connection()
    member = conn.execute('SELECT * FROM Members WHERE MemberID = ?', (id,)).fetchone()
    if request.method == 'POST':
        name = request.form['name']
        contact_info = request.form['contact_info']
        membership_date = request.form['membership_date']
        member_type = request.form['member_type']
        max_books = request.form['max_books']
        max_duration = request.form['max_duration']
        conn.execute('UPDATE Members SET Name = ?, ContactInformation = ?, MembershipDate = ?, MemberType = ?, MaxBooksAllowed = ?, MaxDurationAllowed = ? WHERE MemberID = ?',
                     (name, contact_info, membership_date, member_type, max_books, max_duration, id))
        conn.commit()
        conn.close()
        return redirect(url_for('members'))
    conn.close()
    return render_template('edit_member.html', member=member)

@app.route('/delete_member/<int:id>', methods=('POST',))
def delete_member(id):
    conn = get_db_connection()
    conn.execute('DELETE FROM Members WHERE MemberID = ?', (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('members'))

# Manage Transactions
@app.route('/transactions')
def transactions():
    conn = get_db_connection()
    transactions = conn.execute('SELECT * FROM Transactions').fetchall()
    conn.close()
    return render_template('transactions.html', transactions=transactions)

@app.route('/add_transaction', methods=('GET', 'POST'))
def add_transaction():
    if request.method == 'POST':
        member_id = request.form['member_id']
        book_id = request.form['book_id']
        borrow_date = request.form['borrow_date']
        duration = request.form['duration']
        conn = get_db_connection()
        conn.execute('INSERT INTO Transactions (MemberID, BookID, BorrowDate, Duration) VALUES (?, ?, ?, ?)',
                     (member_id, book_id, borrow_date, duration))
        conn.commit()
        conn.close()
        return redirect(url_for('transactions'))
    return render_template('add_transaction.html')

# Manage Fines
@app.route('/fines')
def fines():
    conn = get_db_connection()
    fines = conn.execute('SELECT * FROM Fines').fetchall()
    conn.close()
    return render_template('fines.html', fines=fines)

@app.route('/add_fine', methods=('GET', 'POST'))
def add_fine():
    if request.method == 'POST':
        transaction_id = request.form['transaction_id']
        amount = request.form['amount']
        payment_status = request.form['payment_status']
        fine_date = request.form['fine_date']
        conn = get_db_connection()
        conn.execute('INSERT INTO Fines (TransactionID, Amount, PaymentStatus, FineDate, IsOverdue) VALUES (?, ?, ?, ?, 1)',
                     (transaction_id, amount, payment_status, fine_date))
        conn.commit()
        conn.close()
        return redirect(url_for('fines'))
    return render_template('add_fine.html')
@app.route('/search_books', methods=['GET', 'POST'])
def search_books():
    query = request.form.get('query', '').strip()
    books = []
    if query:
        conn = get_db_connection()
        books = conn.execute(
            "SELECT * FROM Books WHERE Title LIKE ? OR Author LIKE ? OR Genre LIKE ?",
            (f'%{query}%', f'%{query}%', f'%{query}%')
        ).fetchall()
        conn.close()
    return render_template('search_books.html', books=books, query=query)

@app.route('/search_member', methods=['GET', 'POST'])
def search_member():
    member_info = None
    borrowed_books = []
    total_fines = 0

    if request.method == 'POST':
        search_query = request.form.get('search_query', '').strip()
        conn = get_db_connection()

        if search_query.isdigit():
            # Search by MemberID (if the query is numeric)
            member_info = conn.execute(
                "SELECT * FROM Members WHERE MemberID = ?", (search_query,)
            ).fetchone()
        else:
            # Search by Name (if the query is text)
            member_info = conn.execute(
                "SELECT * FROM Members WHERE Name LIKE ?", (f'%{search_query}%',)
            ).fetchone()

        if member_info:
            # Get borrowed books
            borrowed_books = conn.execute("""
                SELECT Books.Title, Books.Author, Transactions.BorrowDate
                FROM Transactions
                JOIN Books ON Transactions.BookID = Books.BookID
                WHERE Transactions.MemberID = ? AND Transactions.ReturnDate IS NULL
            """, (member_info['MemberID'],)).fetchall()

            # Calculate total fines
            fines = conn.execute("""
                SELECT SUM(Amount) AS TotalFines
                FROM Fines
                WHERE TransactionID IN (
                    SELECT TransactionID
                    FROM Transactions
                    WHERE MemberID = ?
                )
            """, (member_info['MemberID'],)).fetchone()

            total_fines = fines['TotalFines'] if fines and fines['TotalFines'] else 0

        conn.close()

    return render_template(
        'search_member.html',
        member_info=member_info,
        borrowed_books=borrowed_books,
        total_fines=total_fines
    )


# Display Available Books
@app.route('/available_books')
def available_books():
    conn = get_db_connection()
    available_books = conn.execute('SELECT * FROM Books WHERE AvailabilityStatus = "Available"').fetchall()
    conn.close()
    return render_template('available_books.html', books=available_books)

if __name__ == '__main__':
    app.run(debug=True)
