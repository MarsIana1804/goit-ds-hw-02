# goit-ds-hw-02

docker build -t my-sqlite:latest .      

docker run -it -v sqlite_data:/app my-sqlite

#inside container:

python seed.py

sqlite3 mydatabase.db

