#### Запуск контейнера:

`docker compose up -d`

---

#### Копирование загруженных файлов в контейнер:

`docker cp init/ abc123def456:/home/books`

Вывод: 

*Successfully copied 3.05MB to abc123def456:/home/books*

---

#### Проверка наличия скопированных файлов:

`docker exec -it abc123def456 bin/bash`

`cd home/books`

`ls`

Вывод:

*voyna-i-mir-tom-1.txt voyna-i-mir-tom-2.txt voyna-i-mir-tom-3.txt voyna-i-mir-tom-4.txt*

---

#### Объединение файлов в один:

`cat books/* > books/voyna-i-mir-all.txt`

`ls`

Вывод:

*voyna-i-mir-all.txt voyna-i-mir-tom-1.txt voyna-i-mir-tom-2.txt voyna-i-mir-tom-3.txt voyna-i-mir-tom-4.txt*

---

#### Загружаем полученный файл на hdfs:

`hdfs dfs -put books/voyna-i-mir-all.txt /user/tolik/voyna-i-mir-all.txt`

---

#### Содержание личной папки:

`hdfs dfs -ls /user/tolik`

Вывод:

*-rw-r--r-- 3 root tolik 3048008 2023-11-25 18:18 /user/tolik/voyna-i-mir-all.txt*

---

#### Установка прав доступа:

`hdfs dfs -chmod 755 /user/tolik/voyna-i-mir-all.txt`

`hdfs dfs -ls /user/tolik`

Вывод:

*-rwxr-xr-x 3 root tolik 3048008 2023-11-25 18:32 /user/tolik/voyna-i-mir-all.txt*

---

#### Информация о файле:

`hdfs dfs -du -h /user/tolik`

Вывод:

*2.9 M /user/tolik/voyna-i-mir-all.txt*

---

#### Изменение фактора репликации на 2:

`hdfs dfs -setrep 2 /user/tolik/voyna-i-mir-all.txt`

Вывод:

*Replication 2 set: /user/tolik/voyna-i-mir-all.txt*

---

#### Информация о файле после изменения фактора репликации:

`hdfs dfs -ls -h /user/tolik/voyna-i-mir-all.txt`

Вывод:

*-rwxr-xr-x 2 root tolik 2.9 M 2023-11-25 18:48 /user/tolik/voyna-i-mir-all.txt*

---

#### Количество строк в произведении «Война и мир»:

`hdfs dfs -cat /user/tolik/voyna-i-mir-all.txt | wc -l`

Вывод:

*10272*

---
