# Коллективный проект команды 4.2-1
#### Этот проект разработан для создания базы данных в сфере Диагностики COVID-19
## Описание нашего проекта
#### CSV датасет на тему диагностики COVID-19 [Kagle](https://www.kaggle.com/datasets/sudalairajkumar/novel-corona-virus-2019-dataset/data)
### Содержание базы данных 
> Этот датасет содержит серийный номер, дату обследования, провинцию или штат, страну или регион, дату последнего обновления, совокупное количество подтверждённых случаев COVID-19 на одну и ту же дату, совокупное количество смертей на одну и ту же дату, совокупное количество выздоровлений на одну и ту же дату.
### Области применения этой базы данных
> Это достаточно интересная и до сих пор востребованная в наше время база данных. Её можно использовать для анализа тенденций и прогонозирования, например, для просчёта будущих сценариев эпидемий, что, несомненно, важно, ведь, как мы видим, COVID-19 не собирается отступать, пускай сейчас не такой высокий процент смертности среди населения, но полностью забывать про этот вирус точно не стоит. Также эту базу данных можно применить в исследовании факторов риска и защиты, например, можно проанализировать данные, чтобы выявить факторы, влияющие на риск заболевания COVID-19, а также факторы, способствующие выздоровлению. Это может помочь в планировании и разработке мер по предотвращению заболевания. К тому же, не стоит забывать про оценку воздействия мер по борьбе с COVID-19, ведь анализ данных позволит оценить эффективность различных мер по борьбе с вирусом, таких как: карантинные меры, программа вакцинации и другие общественные интервенции.
## Участники коллективного проекта
* [Боровков Артём Андреевич](https://github.com/Scorpiortem)
    - [x] Создание базы данных
    - [x] Распределение задач между участниками проекта
    - [x] Создания репозитория с открытой всем возможностью редактирования
    - [x] Контролирование хода разработки и реализации проекта
    - [x] Тестировка работоспособности базы данных
    - [x] Визуализация данных на Python и составление к ним выводов
* [Хохлов Антон Владимирович](https://github.com/antonkhokhlow)
    - [x] Создание Docker для разворачивания базы данных
    - [x] Создание ER-Диаграммы
    - [x] Нормализация данных БД
* [Мишина Диана Андреевна](https://github.com/MishinaDiana)
    - [x] Импорт данных в созданную базу данных
* [Попроцкий Глеб Геннадьевич](https://github.com/godleifrg)
    - [x] Развернуть базу данных на web-сервере db4.net
### Создание коллективного проекта(презентация в текстовом формате)
### Создание БД
> Начну с себя. При распределении задач мы изначально не знали, что из диаграммы можно получить скрипт создания базы данных, поэтому у нас вышло так, что диаграммы создавал Антон, а я создавал сам скрипт БД. Но когда узнали, что всё это можно делать в одном месте, решили объединить усилия. То есть Антон создал сами диаграмки с названиями, а я прописал им типы данных. Подробнее про нормализацию Антон расскажет чуть позже, а пока я расскажу про сам скрипт. Тут не очень много, потому что нчиего сложного или замудрённого тут нет. Далее привожу скрины создания через Forward Engineer

![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/c7375cd4-a59b-45c8-abe1-7bb0e1ffeb04)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/ddcecd6f-f9dd-44fc-bc0a-a5e7abf139f8)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/0ca51b3e-6d21-4db1-8bbe-74eb61e36dd6)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/d70a2d89-7dbf-4a2c-a919-e07642e858b8)

1. CREATE SCHEMA IF NOT EXISTS COVID-19 DEFAULT CHARACTER SET utf8 - здесь создаётся схема COVID-19, если такой ещё нет.
2. USE COVID-19 - выбирает базу данных COVID-19
3. CREATE TABLE IF NOT EXISTS.... - избегаю повторения одинаковых команд и перехожу сразу к сути. Эта часть скрипта создаёт таблицу, а если быть точнее, то 3 таблицы(observations, regions, countries)
4. Что касается типов данных и почему я выбрал именно их. Начну с маленьких таблиц. В regions у нас для ID стоит, конечно же PRIMARY KEY и SMALLINT UNSIGNED(так как нет тут нулевых значений), потому что, мне показалось, что 65,5 тыс. значений будет вполне достаточно, к счастью, на планете Земля нет такого большого количества регионов, ведь чем меньше памяти занимает БД - тем лучше. Для названия провинции я выбрал VARCHAR максимальной длиной 60, так как существуют достаточно длинные названия регионов в несколько слов, понятное дело, что 60 - это многовато, но я решил оставить место с запасом, чтобы точно хватило. В countries я действовал по точно такой же схеме, поэтому пропускаем её. В observations у ID, естественно, стоит PK, для serialnumber стоит INT UNSIGNED, INT поставил, потому что обследований у нас очень много, хотя в изначально файле более 300 тысяч строк, понятное дело, что на этом данные не остановятся, ведь ковид никуда магическим образом не пропал, далее прописывается observationDate с типом данных DATE(почему не TIMESTAMP? Потому что в оригинальном файле у даты обследования нет часов, минут, секунд). Далее идут ID региноов и стран, у них такие же типы данных, как и в других таблицах. Далее идёт lastUpdate - дата последнего обновления данных, вот она уже в TIMESTAMP, замыкает список столбцов у нас Confirmed, Deaths и Recovered - их названия говорят сами за себя. Там идут только положительные числа, поэтому UNSIGNED, объясняю почему MEDIUMINT именно в confirmed. За то время, которое присутствует в этой таблице, к счастью, не было такого, чтобы умершие исчислялись пятизначными числами больше 60 тысяч. Насчёт создания базы данных всё.

### Создание ER-диаграммы

> ER-диаграмма (сущность-связь, от англ. Entity-Relationship diagram) является графическим методом представления сущностей и их взаимосвязей в информационной системе. Она широко используется для моделирования баз данных и представления структуры данных.

Для того чтобы создать ER-диаграмму необходимо зайти в MySQLWorkbench, далее нужно перейти в создание моделей, нажимаем на (+), в Model Overview выбираем Add Diagram - откроется окно для создания ER-диаграммы. После нужно выбрать функцию Place a New Table и нажать на поле создания диаграммы. В результате появиться конструктор таблицы, для того чтобы её заполнить необходимо кликнуть два раза на нашу таблицу, после чего появиться окно, в котором мы можем прописывать название, тип данных и атрибуты наших столбцов. 
Для того чтобы соеденить наши таблицы используем связь 1:n, нажимаем на нужный нам атрибут в одной таблице и соединяем с атрибутом другой таблицы.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/9b663dbb-05b2-4c40-bd76-908eb357a69c)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/e73a7a3f-be4c-46cd-a44c-403451e1781b)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/248cabad-0a79-400b-a56f-96bfaba8768b)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/e1133cb0-6ad7-4536-ae56-1c3289185c41)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/b4c06a21-35b9-4b45-8310-67d9537d65ee)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/2ec94372-7c0e-40c5-be87-a61af31a32cf)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/aba09300-42f6-4f5f-8686-92524c160cd3)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/612e32f1-de94-4809-8239-f3cdf93da7c1)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/791e0206-4c34-47df-8b41-3fbc5095120b)

Связь между таблицами сооздаётся с помощью FK и PK. В таблицах regions и countries PK - ID. В таблице observations FK - regionID обращается к таблице regions, FK - countryID обращается к таблице countries.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/1c6a2711-aacf-4b0f-8165-aa5d7ae7d993)

### Нормализация данных БД

> Нормализация базы данных представляет собой процесс организации структуры базы данных для минимизации избыточности данных и обеспечения целостности информации. Цель нормализации состоит в устранении аномалий обновления, вставки и удаления, а также в предотвращении избыточности и противоречий в данных.

Принципы нормализации
1. Устранение повторений: Нормализация помогает уменьшить повторение данных путем разделения информации на отдельные таблицы и использованием отношений между этими таблицами.
2. Уменьшение аномалий: Нормализация помогает предотвратить аномалии данных, которые могут возникнуть при выполнении операций обновления, вставки и удаления, такие как аномалии обновления, вставки и удаления.
3. Сохранение целостности: Нормализация способствует сохранению целостности данных, обеспечивая, что каждая часть информации хранится только в одном месте и не противоречит другим частям информации.
Нормальные формы
В рамках процесса нормализации базы данных данные приводят к определенным нормальным формам (нф), таким как:
- Первая нормальная форма (1НФ): гарантирует, что каждый атрибут содержит атомарные значения, то есть значения не могут быть разделены на более мелкие части.
- Вторая нормальная форма (2НФ): требует, чтобы каждый неключевой атрибут полностью зависел от ключа.
- Третья нормальная форма (3НФ): устраняет транзитивные зависимости между атрибутами.

Для нормализации данных изначальной таблицы из CSV файла, мы можем воспользоваться процессом нормализации для хранения информации более эффективным способом. В частности, для полей "страна" и "регион" мы можем использовать отдельные таблицы для хранения уникальных значений и ссылаться на них из таблицы с общей информацией.
<В целом, нормализация базы данных помогает создать более гибкую и эффективную структуру данных, способствуя целостности и согласованности информации.

### Импорт данных БД

1. Скачиваем файл, изучаем его содержимое.
2. Начинаем транзакцию, в которой будет проходить заполнение базы.
   ![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/3772c212-3694-4f53-a085-dfc10ba1cda9)
3. Создаём временную таблицу “temp_table”, и загружаем в неё все данные из файла с помощью оператора LOAD DATA INFILE.
   ![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/ad827cb1-cbc3-4ec7-8f62-7a44585a3e09)
4. Далее с помощью конструкции “INSERT INTO … SELECT FROM” поочерёдно загружаем данные из временной таблицы в таблицы нашей базы: ‘regions’, ‘countries’, ‘observations’.
   ![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/8425bef2-24d4-4f6a-847a-1f77f498f20d)
5. Завершаем транзакцию,сохраняя все изменения.
   ![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/df796a77-e867-4928-af64-d9ebfe5f1fb8)
   
Проверка корректности работы кода:

Выводим строки, в которых значение ‘recovered’ больше нуля. 
![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/f7eeae6f-7d85-4bb4-a3e9-6153450b2b0b)

Выводим строки из таблицы’observations’, в которых значение ‘confirmed’ больше 100, и добавляем название региона.
![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/0abdc1eb-0fcd-4d26-831b-85907611c15d)

Выводим строки таблицы ‘observations’ за июль 2020 года, в которых количество смертей равно нулю, и добавляем название страны.  
![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/3d25ee91-79d1-4d0b-9e20-7908b68df165)
![image](https://github.com/Scorpiortem/4.2-1/assets/147314048/4d851ea3-3d81-400a-a5e0-2a27ca0a81e6)

### Развернуть базу данных на web-сервере db4.net

### Визуализация данных на Python
> Работать я буду через Jupyter Notebook. Поэтому расширение файла у меня ipynb. Также я буду использовать самые популярные библиотеки для построения графиков.

В первую очередь я импортирую нужные мне библиотеки.

![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/c4781c57-931f-48f3-8643-41d2b1b183b4)

С помощью этого кода я создаю датафрейм и заменяю все значения NaN на 'Not Stated'.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/46617bbf-3290-4964-acbc-9cd464a71011)

Далее пишу код для вывода графика зависимости смертей от даты обследования на Кипре. В этом графике используется обычная кривая, полученная с помощью plt.plot().
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/b3d27407-d87a-415b-9019-3bb369db643a)

В этом же коде я использую точечную диаграмму, показывающую зависимость количества заболевших от даты обследования в Бельгии. Для этого я использовал библиотеку seaborn и метод scatterplot(). Также выполнил группировку по дате.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/6634c7bc-2e9f-4ca6-a274-05bbad04666a)


В этом коде я строю гистограмму, показывающую также отношение заболевших к дате обследования в России с условием, что регионы будут без названия. Почему я так сделал? Всё очень просто. CSV файл немного некорректен, мягко говоря. Там идут сначала значения без регионов, они растут со временем, а потом резко появляются регионы и все значения падают почти до нулевых значений, из-за этого пришлось делать так, чтобы график был визуально понятен.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/b74ba1d8-b32b-46bf-bd63-7d7bc83cbb52)

Дальше я пишу код для визуализации значений сразу двух параметров - заболеваний и смертей в Чехии. Как раз этот график показывает как делать не надо, ведь значения заболевших настолько сильно превышают значения умерших, что красная кривая стремится к 0. Поэтому я отдельно написал изменённый код, для более наглядного представления. При этом использовал метод для установления логарифмической шкалы plt.yscale('log').
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/5063f40a-f90e-4298-ae38-76ce119a4901)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/f1c4dd42-7cb8-4782-8211-e3e55371d3c0)

Дальше, я решил немного увеличить масштаб визуализации и, с помощью гистограмм, показал статистику сразу по нескольким государствам. А именно: по России, Венгрии, Мексике и Индонезии. В самом коде я сгруппировал данные по названию страны и суммировал значения по каждому параметру. А потом расположил диаграмки на оси.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/223082e9-6a78-46d5-84a2-cc747bd0e5e5)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/762c459d-8f4f-4400-95b9-4f7c364d435e)

Далее у меня идут 2 диаграммы. Первая показывает суммарное кол-во заболевших, умерших и выздоровевших в Самарской, Тульской, Нижегородской областях и Краснодарском крае, вторая среднее значение по тем же областям и краю.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/a0e3750a-f363-49c8-a90e-18a53261de05)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/41287f36-53da-46a7-9630-60f27aa77ade)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/b38691b0-6b6e-4952-ac4b-98377d6b4d74)

И заключительная диаграмма - круговая. Она показывает отношение сумм всех подтверждённых обследований, смертей и выздоровлений. С помощью explode разрываю самую большую часть диаграмки от остальных - для наглядности.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/53814ab0-8730-4070-b029-af7c304df181)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/62c2cd28-1474-4b7f-aa58-446b2461347a)


### Создание Docker для разворачивания базы данных

> Docker — это проект с открытым исходным кодом для автоматизации развертывания приложений в виде переносимых автономных контейнеров, выполняемых в облаке или локальной среде. Представим, что вы создали проект, который может быть написан на чём угодно – python, java, C++. Мы кладём наш проект в контейнер, а вместе с проектом добавляем всё необходимое окружение: среду выполнения, сервер, различные пакеты, приложения и всё остальное, далее с помощью специальных команд вы можете выгрузить проект ну или другими словами контейнер и после передать его клиенту, начальнику или просто другому разработчику. Если вы писали проект на python, а отправили его java разработчику, то ему не составит труда запустить среду. Процесс запуска всех проектов один и тот же в независимости от того, что находится внутри.

Для того чтобы создать свой полноценный проект необходимо скачать Docker Desktop c официального сайта Docker. Далее заходим в программу и оставляем её открытой(это важно).

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/748a1e77-70c3-415b-9fd0-64c25c94143d)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/f180ffcb-8c97-4a2f-8581-ad1b87de775b)

Для того чтобы развернуть базу данных через Docker воспользуемся программой Visual studio Code. Также необходимо скачать расширение Docker чтобы все работало.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/521732ac-2ac7-4c08-97f1-e03b8dca5cff)

Для того чтобы спроектировать Docker необходимо создать файл docker-compose.yml. В этом файле мы можем описать множество различных образов, которые мы хотим подключать к проекту, а также настройки ко всем этим образам. Также создадим папку docker в репозитории, в которую мы закинем наши скрипты. 

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/4e4fa878-fc1a-427a-a195-ef78f8b1cb46)

В начале мы всегда указываем версию docker-compose. Ниже идут services - другими словами, в них мы будем описывать образы, которые у нас будут подключаться. Далее указываем название сервиса, оно может быть каким угодно. После названия сервиса идут характеристики по подключению. В первую очередь указывается image - это образ который мы с вами стягиваем.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/5521dae4-3f9a-43f1-9692-220fc01fa366)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/6fb0e1f4-7ae0-4fb4-bee1-04f8aabfd40f)

> Все необходимые образы мы берём с dockerhub, (здесь мы можем найти описание для нашего docker-compose и воспользоваться им) в нашем случае это mysql и phpmyadmin. Сервер phpmyadmin предоставляет нам графический интерфейс, а сервер mysql предоставляет нам саму систему управления базы данных. Также указываем версию образа, которую мы хотим использовать. Для phpmyadmin я использую latest – последнюю версию. Для mysql версию -  8.0.
> 
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/f9c25dbf-7afd-40ba-9d74-9e9f36ba1141)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/8b0e3679-87c7-494b-885a-59e65a15be39)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/208e3513-7dbc-4a7a-8cf0-c56e2862e533)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/03f3a436-1475-4737-b438-95bcad325c96)

Далее у нас есть настройка restart. Эта настройка работает в следующем формате: если вдруг какой-то образ прекращает работу (это может быть из-за ошибки или там не докачался) мы может указать что в таком случае будет делать программа. Можно указать no – в таком случае он не будет перезапускать образ, если он вдруг поломается, или же можно указать always, в таком случае он всегда будет перезапускать сервер, поэтому у нас в каждом сервере указана настройка restart: always, которая всегда будет обновлять образ если он вдруг поломался.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/71e11779-c863-421e-a8fe-16bc7292d13e)

После в phpmyadmin нам необходимо указать ports по которому мы будем подключаться, в нашем случае это 8080. Этот ports мы будем указывать при запуске в браузере. После прописываем environment – это различные настройки, переменные, которые могут понадобиться при работе с самим образом. Это может быть пароль, логин, или какие-то другие данные которые нам могут понадобиться. PMA_HOST — определяет адрес/имя хоста сервера MySQL. PMA_PORT - определяет port сервера MySQL. Ещё мы пишем такую настройку как depends_on, которая говорит о том, что сервис phpmyadmin будет зависеть от сервиса mysql. То есть за счёт этой настройки, я просто говорю, что мы с вами через сервис phpmyadmin можем обращаться к нашему сервису mysql, а нам это дейтвительно нужно по скольку мы хотим, чтобы в phpmyadmin у нас была какая-либо база данных.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/3aab2701-e967-430e-88ff-bf78c3a309bd)

Также в сервисе mysql мы описываем environvernt: 
MYSQL_ROOT_PASSWORD - Эта переменная является обязательной и определяет пароль, который будет установлен для учетной записи суперпользователя MySQL root.
MYSQL_DATABASE - Эта переменная необязательна и позволяет вам указать имя базы данных, которая будет создана при запуске образа.
MYSQL_USER, MYSQL_PASSWORD - Эти переменные необязательны и используются совместно для создания нового пользователя и установки пароля этого пользователя. Этому пользователю будут предоставлены права суперпользователя для базы данных, указанной переменной MYSQL_DATABASE. Обе переменные необходимы для создания пользователя.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/53446ef5-70fc-44cb-87e7-7bf486a9599b)

В конце нам необходимо описать volumes или тома. За счёт этого тома мы соединяем папку, которая у нас находится на виртуальной машине, где у меня лежит csv файл, заполняющий базу данных, с нашей текущей папкой, в которой лежат скрипты. Таким образом docker-entrypoint-initdb соединяет все нужные мне скрипты из папки docker и запускает их.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/8d646034-a57f-4f3b-b4ca-71bcc4ae5252)

Итак, чтобы всё это заработало мы должны открыть Docker Desktop(если вы его закрыли) и далее непосредственно в терминале VS Code необходимо обратиться к команде docker-compose build эта команда позволяет нам построить необходимые образы исходя из docker-compose файла. После запускаем их обратившись к команде docker-compose up. Далее у нас происходит обработка и скачивание наших образов с докер хаба, если они у вас не установлены и создаётся контейнер. После выполнения этой команды нам дополнительно делать ничего не требуется, поскольку команда docker-compose up запускает все сервисы и полностью весь наш проект. 

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/c8da082d-9dcf-4121-83c8-6b57932e1476)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/66a2427b-17db-459d-bca9-44210e148a4d)

Открываем любимый Docker Desktop. Проверяем наши образы и контейнер, видим что всё установилось и создалось.

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/02e6d891-1cca-45cc-8ce0-4fc3bbb5848c)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/8082ab41-d0e0-4983-9cb4-6b66a94af93f)

Далее переходим по localhost:8080 в браузере. Вводим наш MYSQL_USER и MYSQL_PASSWORD - авторизуемся

![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/6f0f12e1-45e7-4051-bf43-be6664d0fc01)

Docker для разворачивания базы данных успешно создан.
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/3cc7b6fd-5195-4b63-9b1f-43e2dc9ada49)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/d313153a-c651-41f1-87a5-a8908e69e5d3)
![image](https://github.com/Scorpiortem/4.2-1/assets/147417257/d04d053d-5ec0-4588-8a2e-199f4bbfe487)
