  # ShellCurrencyConverter

ShellCurrencyConverter - это скрипт, позволяющий конвертировать валюты с использованием стандартных команд и актуального курса Fixer API. С помощью этого скрипта вы можете конвертировать валюты, вводя их как аргументы с клавиатуры или считывая их из текстового файла построчно.

## Установка и использование

Для использования ShellCurrencyConverter выполните следующие шаги:

1. Клонируйте репозиторий, выполнив следующую команду в терминале:
   ```
   git clone https://github.com/akiko23/ShellCurrencyConverter.git
   ```

2. Перейдите в директорию c клонированным репозиторием и дайте права на выполнение скрипта:
   ```
   cd ShellCurrencyConverter/ && chmod +x script.sh
   ```

3. Запустите скрипт:
   ```
   ./script.sh
   ```

После запуска скрипта вы получите инструкции по его использованию. Также вы можете использовать опцию `-h`, чтобы отобразить справочное меню:
   ```
   ./script.sh -h
   ```

## Примеры использования

### Конвертация валют с использованием аргументов с клавиатуры

Для конвертации валют по аргументам с клавиатуры, используйте следующий синтаксис:
```
./script.sh [сумма] [исходная_валюта] [целевая_валюта]
```
Замените `[сумма]` числовым значением суммы, которую вы хотите конвертировать, `[исходная_валюта]` - кодом исходной валюты, `[целевая_валюта]` - кодом целевой валюты.

Например, для конвертации 100 долларов США в рубли выполните следующую команду:
```
./script.sh 100 USD RUB
```

### Конвертация валют из текстового файла

Для конвертации валют, считываемых из текстового файла построчно, создайте файл (например, `currencies.txt`), где каждая строка содержит параметры конвертации в следующем формате:
```
[сумма] [исходная_валюта] [целевая_валюта]
```

Затем выполните запуск скрипта с опцией `-f`, указав путь к текстовому файлу:
```
./script.sh -f путь/до/currencies.txt
```
Замените `путь/до/currencies.txt` на фактический путь к вашему файлу.

## Требования

Для работы ShellCurrencyConverter требуется:

- Unix подобная операционная система (например, Linux, macOS)
- Наличие стандартных команд оболочки (например, `awk`, `grep`, `jq`, `curl`).

## Внесение вклада

Приветствуются вклады в ShellCurrencyConverter! Если у вас есть предложения, улучшения или исправления ошибок, пожалуйста, создайте issue или отправьте pull request.

## Благодарности

ShellCurrencyConverter был создан студентом `It-Колледжа Сириус` группы 1.9.7.1 Василенко Дмитрием. Хотелось бы выразить благодарность open source сообществу за ценный вклад и разработчиков API конвертации валют, использованных в этом проекте.

## Контакты

По всем вопросам или запросам обращайтесь по адресу dmvasilenko43@gmail.com.

Приятного конвертирования валют!

<img width="600" height="365" src="https://www.meme-arsenal.com/memes/ee9d59eb87605907186a2407b84f2b89.jpg" />
