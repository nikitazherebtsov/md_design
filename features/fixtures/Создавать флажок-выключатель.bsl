﻿// Реквизиты

ДобавляемыеРеквизиты = Новый Массив;

ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Флажок", Новый ОписаниеТипов("Булево")));

ИзменитьРеквизиты(ДобавляемыеРеквизиты);

// Элементы

Элемент_Флажок = Элементы.Добавить("Флажок", Тип("ПолеФормы"));
Элемент_Флажок.Вид = ВидПоляФормы.ПолеФлажка;
Элемент_Флажок.ПутьКДанным = "Флажок";
Элемент_Флажок.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Право;
Элемент_Флажок.ВидФлажка = ВидФлажка.Выключатель;
Элемент_Флажок.Заголовок = "Флажок";