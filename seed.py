import sqlite3
from faker import Faker
import random

fake = Faker()

# Connect to the database (the database file will be created in the current directory)
conn = sqlite3.connect('mydatabase.db')

# Create a cursor object to execute SQL commands
cursor = conn.cursor()

# Drop tables if they exist
cursor.execute('DROP TABLE IF EXISTS users;')
cursor.execute('DROP TABLE IF EXISTS status;')
cursor.execute('DROP TABLE IF EXISTS tasks;')

# Create the `users` table
cursor.execute('''
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullname VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
''')

# Create the `status` table
cursor.execute('''
CREATE TABLE status (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL
);
''')

# Create the `tasks` table
cursor.execute('''
CREATE TABLE tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    status_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY (status_id) REFERENCES status(id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
''')

# Insert sample data into the `users` table
for _ in range(10):  # Adjust the range for the desired number of records
    cursor.execute('''
        INSERT INTO users (fullname, email)
        VALUES (?, ?)
    ''', (fake.user_name(), fake.email()))

# Insert predefined status names into the `status` table
status_names = ['Not Started', 'In Progress', 'Completed', 'On Hold']
for name in status_names:
    cursor.execute('''
        INSERT INTO status (name)
        VALUES (?)
    ''', (name,))

# Fetch the IDs of the inserted status and users
cursor.execute('SELECT id FROM status;')
status_ids = [row[0] for row in cursor.fetchall()]

cursor.execute('SELECT id FROM users;')
user_ids = [row[0] for row in cursor.fetchall()]

# Insert sample data into the `tasks` table
for _ in range(10):  # Adjust the range for the desired number of records
    cursor.execute('''
        INSERT INTO tasks (title, description, status_id, user_id)
        VALUES (?, ?, ?, ?)
    ''', (fake.sentence(), fake.text(), random.choice(status_ids), random.choice(user_ids)))

# Save changes and close the connection
conn.commit()
conn.close()

print("База даних створена успішно.")
