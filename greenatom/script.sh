#!/bin/bash

# Выносим все, что может меняться в переменные
url="https://example.org" # Сайт https://it.is.mysite.ru/ недоступен
check_content="illustrative examples"

# Запрашиваем страницу. Ключи 
# -s убирает прогресс бар загрузки
# -i выводит полученные заголовки
# -L позволяет переходить по редиректам
request_answer=$(curl -s -i -L "$url")

# Получаем код ответа из заголовков
answer_code=$(echo $request_answer | head -n1 | awk '{print $2}')

# Проверяем статус запроса
if [[ "$answer_code" -eq 200 ]]; then
    re="$check_content"
    # Проверяем контент
    if [[ "$request_answer" =~ "$re" ]]; then
        echo "Страница ${url} доступна и содержит нужные данные"
    else
        echo "Страница ${url} доступна, но не содержит нужные данные"
    fi
else
    echo "Страница ${url} не доступна"
fi
