﻿#language: ru

@tree

Функционал: Добавление флажка

Как Аналитик я хочу
Добавлять флажок на форму
чтобы видеть макет формы

Контекст:
	Дано я запускаю обработку

Сценарий: Создавать флажок с пометкой
	Когда в поле редактора я ввожу текст
"""
[v] Флажок
"""	
	И я формирую форму

	И флаг 'Флажок' равен 'Да'

Сценарий: Форматировать флажок с пометкой
	Когда в поле редактора я ввожу текст
"""
[v] Флажок
"""	
	И я форматирую текст в редакторе

	Тогда текст в поле редактора стал равен
"""
[X] Флажок
"""
Сценарий: Создавать флажок без пометки
	Когда в поле редактора я ввожу текст
"""
[] Флажок
"""	
	И я формирую форму

	И флаг 'Флажок' равен 'Нет'

	Тогда я сверяю сформированный код с файлом "Создавать флажок"

Сценарий: Форматировать флажок без пометки

	Когда в поле редактора я ввожу текст
"""
[] Флажок
"""	
	И я форматирую текст в редакторе

	Тогда текст в поле редактора стал равен
"""
[ ] Флажок
"""

Сценарий: Создавать флажок-выключатель с пометкой
	Когда в поле редактора я ввожу текст
"""
[|v] Флажок
"""	
	И я формирую форму

	И флаг 'Флажок' равен 'Да'

Сценарий: Создавать флажок-выключатель без пометки
	Когда в поле редактора я ввожу текст
"""
[v|] Флажок
"""	
	И я формирую форму

 	И флаг 'Флажок' равен 'Нет'

 	Тогда я сверяю сформированный код с файлом "Создавать флажок-выключатель"

Сценарий: Создавать флажок с положением заголовка слева
	Когда в поле редактора я ввожу текст
"""
Флажок [v]
"""	

  	Тогда я сверяю сформированный код с файлом "Создавать флажок с положением заголовка слева"

	