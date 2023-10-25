# Team 3 - Cars By Pharo Project

## Task Distribution
- Iryna: Responsible for creating and managing the GitHub repository and handling related issues. Also worked on the base class "Car".
- Taras: Worked on the derived class "Taxi" and implemented tasks 2 and 3.
- Kateryna: Focused on writing tests for the project.

## Project Tasks
1. Define a class that models the entity "car" An instance of the class should store the car's model, initial cost, and the years of operation. It should be able to display itself, provide its model, and estimate its value (with a 10% depreciation each year). Cars should be compared by their value. Create a subclass to model "taxi" cars, which will also store the company name and a depreciation coefficient (k > 1) that affects the yearly depreciation of the taxi.

2. Create five different cars, including taxis, and add them to a container. Implement the ability to interactively input information about new cars and add them to the collection. Print all the elements in the container. Find the cheapest car and determine if it's a taxi. Demonstrate the use of arithmetic operators. Increase the years of operation for each car in the collection by one year, creating a new collection with one car of each brand from the previous collection.

3. Demonstrate the storage of created objects into files (in various formats), databases (simulated in memory), and loading them from files and databases.

Please, execute this code to load the project
```Smalltalk
Metacello new
   baseline: 'CarsByPharo';
   repository: 'github://irrenne/team-3_cars_by_pharo/src';
   load
```
   
## Розподіл обов'язків
- Ірина: Відповідальна за створення та управління репозиторієм GitHub та вирішенням пов'язаних з ним питань. Також працювала над базовим класом "Автомобіль".
- Тарас: Працював над похідним класом "Таксі" та виконував завдання 2 та 3.
- Катерина: Зосередилася на написанні тестів для проекту.
  
## Завдання:
1. Оголосіть клас, що моделює сутність «автомобіль». Екземпляр класу пам’ятає модель авто, початкову вартість та термін експлуатації (в роках), вміє зображати себе, повідомляти свою модель та оціночну вартість (за кожен рік експлуатації оціночна вартість зменшується на 10% від попередньої). Автомобілі порівнюють за вартістю. Оголосіть підклас, що моделює сутність «автомобіль-таксі». Екземпляр класу пам’ятає назву фірми та коефіцієнт експлуатації (коефіцієнт k>1, щороку таксі знецінюється на (kх10)% ). Об’єкт вміє повідомляти свої дані.
   
2. Створіть п’ять різних авто (у тому числі таксі) та занесіть їх у контейнер. Забезпечте можливість вводити в режимі діалогу інформацію про нове авто і долучати його до колекції інших. Надрукуйте всі елементи контейнера. Знайдіть найдешевше авто. Чи це таксі? Продемонструйте використання арифметичних операторів. Збільшіть термін експлуатації кожного автомобіля в колекції на один рік; створіть нову колекцію, що містить по одному автомобілю кожної марки з попередньої колекції.
   
3. Продемонструйте зберігання створених об’єктів до файлу (до різних файлів у різних форматах), до бази даних (наявність бази можна імітувати в пам’яті) та завантаження їх з файлу, з бази.
   
Для завантаження цього проекту виконайте наступний код
```Smalltalk
Metacello new
   baseline: 'CarsByPharo';
   repository: 'github://irrenne/team-3_cars_by_pharo/src';
   load
```

## Документування робочого процесу
- **Додавання SSH-ключа до Pharo:** Виникли труднощі з додаванням SSH-ключа до Pharo, оскільки він не приймав стандартний RSA-ключ. Ця проблема була подолана шляхом генерації нового ключа із форматом ed25519, що успішно вирішило проблему.
- **Створення Класу BaselineOf:** Для ефективної спільної роботи та поширення наробітків серед учасників команди було створено клас `BaselineOfCarsByPharo`. Це дозволило успішно завантажити пакети. Без цього класу вони не завантажувались при клонуванні репозиторію.
