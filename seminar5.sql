-- 1. Создайте представление, в которое попадет информация о пользователях
-- (имя, фамилия, город и пол), которые не старше 20 лет.

CREATE OR REPLACE VIEW younger20 AS
SELECT users.firstname, users.lastname,
profiles.hometown, profiles.gender
FROM users JOIN profiles ON users.id = profiles.user_id
WHERE profiles.birthday >= '2003-07-18';

-- 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите
-- ранжированный список пользователей, указав имя и фамилию пользователя,
-- количество отправленных сообщений и место в рейтинге (первое место у пользователя
-- с максимальным количеством сообщений) . (используйте DENSE_RANK)

CREATE OR REPLACE VIEW count_messenges AS
SELECT users.firstname, users.lastname, COUNT(from_user_id) AS 'count_mes'
FROM users JOIN messages ON users.id = messages.from_user_id
GROUP BY from_user_id
ORDER BY count_mes DESC;

SELECT firstname, lastname, count_mes, DENSE_RANK()
OVER (ORDER BY count_mes DESC) AS 'rank'
FROM count_messenges;

/*3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями,
получившегося списка. (используйте LEAD или LAG)*/

SELECT id, created_at, LAG(created_at, 1,0) OVER (ORDER BY created_at) AS 'prev',
LEAD(created_at,1,0) OVER (ORDER BY created_at) AS 'next',
(created_at -'prev') AS '1',
('next' - created_at) AS '2'
FROM messages;
