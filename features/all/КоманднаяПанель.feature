﻿#language: ru

@tree

Функционал: Добавление командной панели

Как Аналитик я хочу
Добавлять командную панель
чтобы видеть макет формы

Контекст:
	Дано Запускаю обработку

Сценарий: Создавать командную панель
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
<Кнопка 1|Кнопка 2>
"""
	И я нажимаю на кнопку "Сформировать"

	Тогда кнопка "Кнопка 1" существует
	И кнопка "Кнопка 2" существует

	Тогда сверяю сформированный код с файлом "Создавать командную панель"

Сценарий: Форматировать командную панель
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
<Кнопка 1|Кнопка 2>
"""
	И я нажимаю на кнопку с именем '__Форматировать'

	Тогда значение поля с именем '__Редактор' содержит текст
"""
< Кнопка 1 | Кнопка 2 >
"""

Сценарий: Создавать командную панель с меню
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
<Кнопка 1| Меню
Меню 
.Подменю>
"""
	И я нажимаю на кнопку "Сформировать"

	И кнопка "Меню" существует
	И кнопка "Подменю" существует

	Тогда сверяю сформированный код с файлом "Создавать командную панель с меню"

Сценарий: Форматировать командную панель с меню
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
<Кнопка 1|Меню
Меню 
.Подменю
.Подменю 2>
"""
	И я нажимаю на кнопку с именем '__Форматировать'

	Тогда значение поля с именем '__Редактор' содержит текст
"""
< Кнопка 1 | Меню
Меню
. Подменю
. Подменю 2 >
"""