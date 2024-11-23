
# 📚 Library Management System

Welcome to the **Library Management System**, a modern, Netflix-inspired web application for managing a library's resources. This system provides features for managing books, members, librarians, transactions, and fines while offering a clean and user-friendly interface. 🚀

---

## 🌟 Features

### ✅ Core Functionalities:
- **Manage Books**: Add, edit, delete, and view books in the library.
- **Manage Members**: Keep track of library members, their contact details, and membership status.
- **Manage Librarians**: Oversee librarian details, including their hire date and contact information.
- **Manage Transactions**: Track book borrow and return activities.
- **Handle Fines**: Manage overdue fines for borrowed books.
- **Available Books**: View all books currently available in the library.
- **Search System**:
  - Search books by title, author, or genre.
  - Search members by name to view their information, borrowed books, and fines.



## 🛠️ Tech Stack

- **Backend**: Python (Flask Framework)
- **Frontend**: HTML, CSS (Netflix-style)
- **Database**: SQLite (lightweight and easy to set up)
- **Deployment**: Locally via Flask or hosted on any platform that supports Python.

---

## 🚀 Getting Started

### Prerequisites
1. **Python 3.8+**
2. **Flask** (Install using `pip install flask`)
3. **SQLite** (Pre-installed on most systems, or download from [sqlite.org](https://sqlite.org/))
4. **Basic understanding of Flask routing and database management**.

---

### 💻 Installation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-repo/library-management-system.git
   cd library-management-system
   ```

2. **Install dependencies**:
   ```bash
   pip install flask
   ```

3. **Set up the database**:
   - Run the `library_setup.sql` script to create the database and populate initial data:
     ```bash
     sqlite3 library.db
     .read library_setup.sql
     ```

4. **Run the Flask app**:
   ```bash
   python app.py
   ```

5. **Access the app**:
   Open [http://127.0.0.1:5000](http://127.0.0.1:5000) in your browser.

---

## 📂 Project Structure

```
library_app/
├── static/
│   ├── style.css          # Styling for the app
│   └── logo.png           # Library logo
├── templates/
│   ├── base.html          # Layout for all pages
│   ├── index.html         # Homepage
│   ├── books.html         # Manage books
│   ├── members.html       # Manage members
│   ├── librarians.html    # Manage librarians
│   ├── transactions.html  # Manage transactions
│   ├── fines.html         # Handle fines
│   ├── available_books.html # Display available books
│   ├── search_member.html # Search for a member
├── app.py                 # Main Flask app
├── library_setup.sql      # SQL script for database setup
├── library.db             # SQLite database
└── README.md              # Project documentation
```
---

💡 *"Libraries store the energy that fuels the imagination."* 📖
