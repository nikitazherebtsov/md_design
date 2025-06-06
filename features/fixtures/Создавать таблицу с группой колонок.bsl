﻿// Реквизиты

ДобавляемыеРеквизиты = Новый Массив;

ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Таблица", Новый ОписаниеТипов("ТаблицаЗначений")));
ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Подколонка11", Новый ОписаниеТипов("Строка"), "Таблица"));
ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Подколонка12", Новый ОписаниеТипов("Строка"), "Таблица"));

ИзменитьРеквизиты(ДобавляемыеРеквизиты);

// Элементы

Элемент_Таблица = Элементы.Добавить("Таблица", Тип("ТаблицаФормы"));
Элемент_Таблица.ПутьКДанным = "Таблица";
Элемент_Таблица.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;

Элемент_ТаблицаКолонкаГоризонтальная = Элементы.Добавить("ТаблицаКолонкаГоризонтальная", Тип("ГруппаФормы"), Элемент_Таблица);
Элемент_ТаблицаКолонкаГоризонтальная.Вид = ВидГруппыФормы.ГруппаКолонок;
Элемент_ТаблицаКолонкаГоризонтальная.Группировка = ГруппировкаКолонок.Горизонтальная;
Элемент_ТаблицаКолонкаГоризонтальная.Заголовок = "Группа 1";
Элемент_ТаблицаКолонкаГоризонтальная.ОтображатьВШапке = Истина;

Элемент_ТаблицаПодколонка11 = Элементы.Добавить("ТаблицаПодколонка11", Тип("ПолеФормы"), Элемент_ТаблицаКолонкаГоризонтальная);
Элемент_ТаблицаПодколонка11.Вид = ВидПоляФормы.ПолеВвода;
Элемент_ТаблицаПодколонка11.ПутьКДанным = "Таблица.Подколонка11";
Элемент_ТаблицаПодколонка11.Заголовок = "Подколонка 1.1";

Элемент_ТаблицаПодколонка12 = Элементы.Добавить("ТаблицаПодколонка12", Тип("ПолеФормы"), Элемент_ТаблицаКолонкаГоризонтальная);
Элемент_ТаблицаПодколонка12.Вид = ВидПоляФормы.ПолеВвода;
Элемент_ТаблицаПодколонка12.ПутьКДанным = "Таблица.Подколонка12";
Элемент_ТаблицаПодколонка12.Заголовок = "Подколонка 1.2";