#!/bin/bash

# Функция для подсчета строк в одном репозитории
count_lines() {
    cd "$1"
    result=$(git log --all --author="Mikhail" --since="1 month ago" --pretty=tformat: --numstat |
    awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%s,%s,%s\n", add, subs, loc }')
    echo "$result"
}

# Инициализация переменных для общего подсчета
total_add=0
total_subs=0
total_loc=0

# Создаем временный файл для хранения результатов
temp_file=$(mktemp)

# Поиск всех Git репозиториев и запись результатов во временный файл
find "$HOME" -name .git -type d 2>/dev/null | while read gitdir; do
    repo=$(dirname "$gitdir")
    echo "Processing: $repo"

    # Подсчет строк для текущего репозитория
    result=$(count_lines "$repo")
    IFS=',' read -r add subs loc <<< "$result"

    echo "  Added: $add, Removed: $subs, Total: $loc"

    # Запись результатов во временный файл
    echo "$add,$subs,$loc" >> "$temp_file"
done

# Чтение результатов из временного файла и подсчет общего итога
while IFS=',' read -r add subs loc; do
    total_add=$((total_add + add))
    total_subs=$((total_subs + subs))
    total_loc=$((total_loc + loc))
done < "$temp_file"

# Удаление временного файла
rm "$temp_file"

# Вывод общего результата
echo "Total added lines: $total_add"
echo "Total removed lines: $total_subs"
echo "Total lines: $total_loc"