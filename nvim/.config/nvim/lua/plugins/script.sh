#!/bin/bash

# Создаём или очищаем файл olan.txt (если нужно перезаписать, раскомментируйте следующую строку)
# > olan.txt

for file in *.lua; do
    if [ -f "$file" ]; then  # Проверяем, что это файл
        echo "Файл: $file" >> olan.txt
        echo "Содержимое:" >> olan.txt
        cat "$file" >> olan.txt
        echo "" >> olan.txt  # Добавляем пустую строку для разделения
    fi
done

echo "Готово! Содержимое файлов записано в olan.txt"
