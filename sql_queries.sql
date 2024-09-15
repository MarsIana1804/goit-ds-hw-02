#Отримати всі завдання певного користувача. Використайте SELECT для отримання завдань конкретного користувача за його user_id.

SELECT * 
FROM tasks 
WHERE user_id = 5;

#Вибрати завдання за певним статусом. Використайте підзапит для вибору завдань з конкретним статусом, наприклад, 'new'.

SELECT * 
FROM tasks as t 
    INNER JOIN status as st 
    ON t.status_id = st.id
WHERE st.name in ('Not Started', 'In Progress');

#Оновити статус конкретного завдання. Змініть статус конкретного завдання на 'in progress' або інший статус.

UPDATE tasks 
SET status_id = 4 
WHERE id = 4;

#Отримати список користувачів, які не мають жодного завдання. Використайте комбінацію SELECT, WHERE NOT IN і підзапит.

SELECT * 
FROM users
WHERE id NOT IN (
    SELECT user_id 
    FROM tasks
);

#Додати нове завдання для конкретного користувача. Використайте INSERT для додавання нового завдання.

INSERT INTO tasks (user_id, description, title, status_id) 
VALUES (2, 'New Task Description', 'New task title', 2);

#Отримати всі завдання, які ще не завершено. Виберіть завдання, чий статус не є 'завершено'.

SELECT st.name, t.title
FROM tasks as t 
    INNER JOIN status as st 
    ON t.status_id = st.id
WHERE st.name != 'Completed'
ORDER BY st.name;

#Видалити конкретне завдання. Використайте DELETE для видалення завдання за його id.

DELETE FROM tasks 
WHERE id = 3;

#Знайти користувачів з певною електронною поштою. Використайте SELECT із умовою LIKE для фільтрації за електронною поштою.

SELECT * 
FROM users 
WHERE email LIKE '%gar%';

#Оновити ім'я користувача. Змініть ім'я користувача за допомогою UPDATE.

UPDATE users 
SET fullname = 'Garrett Johns' 
WHERE id = 8;

#Отримати кількість завдань для кожного статусу. Використайте SELECT, COUNT, GROUP BY для групування завдань за статусами.

SELECT status_id, COUNT(*) AS task_count 
FROM tasks 
GROUP BY status_id;

#Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти. Використайте SELECT з умовою LIKE в поєднанні з JOIN, щоб вибрати завдання, призначені користувачам, чия електронна пошта містить певний домен (наприклад, '%@example.com').

SELECT users.email, tasks.title
FROM tasks 
JOIN users ON tasks.user_id = users.id 
WHERE users.email LIKE '%@example.com';

#Отримати список завдань, що не мають опису. Виберіть завдання, у яких відсутній опис.

SELECT * 
FROM tasks 
WHERE description IS NULL OR description = '';

#Вибрати користувачів та їхні завдання, які є у статусі 'In Progress'. Використайте INNER JOIN для отримання списку користувачів та їхніх завдань із певним статусом.

SELECT users.fullname, tasks.title, status.name
FROM users 
INNER JOIN tasks ON users.id = tasks.user_id
INNER JOIN status ON status.id = tasks.status_id
WHERE status.name = 'In Progress';

#Отримати користувачів та кількість їхніх завдань. Використайте LEFT JOIN та GROUP BY для вибору користувачів та підрахунку їхніх завдань.

SELECT users.id, users.fullname, COUNT(tasks.id) AS task_count 
FROM users 
LEFT JOIN tasks ON users.id = tasks.user_id 
GROUP BY users.id;
