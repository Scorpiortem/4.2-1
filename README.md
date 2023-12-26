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
> Начну с себя. При распределении задач мы изначально не знали, что из диаграммы можно получить скрипт создания базы данных, поэтому у нас вышло так, что диаграммы создавал Антон, а я создавал сам скрипт БД. Но когда узнали, что всё это можно делать в одном месте решили объединить усилия. То есть Антон создал сами диаграмки с названиями, а я прописал им типы данных. Подробнее про нормализацию Антон расскажет чуть позже, а пока я расскажу про сам скрипт. Тут не очень много, потому что нчиего сложного или замудрённого тут нет. Далее привожу скрины создания через Forward Engineer

![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/c7375cd4-a59b-45c8-abe1-7bb0e1ffeb04)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/ddcecd6f-f9dd-44fc-bc0a-a5e7abf139f8)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/0ca51b3e-6d21-4db1-8bbe-74eb61e36dd6)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/d70a2d89-7dbf-4a2c-a919-e07642e858b8)

1. CREATE SCHEMA IF NOT EXISTS COVID-19 DEFAULT CHARACTER SET utf8 - здесь создаётся схема COVID-19, если такой ещё нет.
2. USE COVID-19 - выбирает базу данных COVID-19
3. CREATE TABLE IF NOT EXISTS.... - избегаю повторения одинаковых команд и перехожу сразу к сути. Эта часть скрипта создаёт таблицу, а если быть точнее, то 3 таблицы(observations, regions, countries)
4. Что касается типов данных и почему я выбрал именно их. Начну с маленьких таблиц. В regions у нас для ID стоит, конечно же PRIMARY KEY и SMALLINT UNSIGNED(так как нет тут нулевых значений), потому что, мне показалось, что 65,5 тыс. значений будет вполне достаточно, к счастью, на планете Земля нет такого большого количества регионов, ведь чем меньше памяти занимает БД - тем лучше. Для названия провинции я выбрал VARCHAR максмальной длиной 60, так как существуют достаточно длинные названия регинов в несколько слов, понятное дело, что 60 - это многовато, но я решил оставить место с запасом, чтобы точно хватило. В countries я действовал по точно такой же схеме, поэтому пропускаем её. В observations у ID, естественно, стоит PK, для serialnumber стоит INT UNSIGNED, INT поставил, потому что обследвоаний у нас очень много, хотя в изначально файле более 300 тысяч строк, понятное дело, что на этом данные не остановятся, ведь ковид никуда магическим образом не пропал, далее прописывается observationsDate с типом данных DATE(почему не TIMESTAMP? Потому что в оригнальном файле у даты обследования нет часов, минут, секунд). Далее идут ID регинов и стран, у них такие же типы данных, как и в других таблицах. Далее идёт lastUpdate - дата последнего обновления данных, вот она уже в TIMESTAMP, замыкает список столбцов у нас Confirmed, Deathsm Recovered - их названия говорят сами за себя. Там идут только положительные числа, поэтому UNSIGNED, объясняю почему MEDIUMINT именно в confirmed. За то время, которое присутствует в этой таблице, к счастью, не было такого, чтобы умершие исчислялись пятизначными числами больше 60 тысяч. Насчёт создания базы данных всё.

### Создание ER-диаграммы

### Нормализация данных БД

### Импорт данных БД

### Развернуть базу данных на web-сервере db4.net

### Визуализация данных на Python
> Работать я буду через Jupyter Notebook. Поэтому расширение файла у меня ipynb. Также я буду использовать самые популярные библиотеки для построеняи графиков.

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

Дальше я пишу код для визулизации значений сразу двух параметров - заболеваний и смертей в Чехии. Как раз этот график показывает как делать не надо, ведь значения заболевших настолько сильно превышают значения умерших, что красная кривая стремится к 0. Поэтому я отдельно написал изменённый код, для более наглядного представления. Приэтом использовал метод для установления логарифмической шкалы plt.yscale('log').
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/5063f40a-f90e-4298-ae38-76ce119a4901)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/f1c4dd42-7cb8-4782-8211-e3e55371d3c0)

Дальше, я решил немного увеличить масштаб визуализации и, с помощью гистограмм, показал статистику сразу по нескольким государствам. А именно: по России, Венгрии, Мексике и Индонезии. В самом коде я сгруппировал данные по названию страны и суммировал значения по каждому параметру. А потом расположил диаграмки на оси.
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/223082e9-6a78-46d5-84a2-cc747bd0e5e5)
![image](https://github.com/Scorpiortem/4.2-1/assets/147166471/762c459d-8f4f-4400-95b9-4f7c364d435e)



### Создание Docker для разворачивания базы данных
