﻿// MIT License

// Copyright (c) 2025 Zherebtsov Nikita <nikita@crimsongold.ru>

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// https://github.com/crimsongoldteam/md_design

#Область ОбработчикиСобытийФормы

&НаКлиенте
Функция Заполнить(ДанныеГрупп, Префикс = "") Экспорт
	Результат = Новый Массив;
		
	ЗаполнитьОписаниеЭлементов(Результат, ДанныеГрупп);

	Для Каждого КлючЗначение Из Результат Цикл
		ЗаполнитьПолучитьИмяРеквизита(Результат, КлючЗначение, Префикс);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

#Область ЗаполнитьОписания

&НаКлиенте
Процедура ЗаполнитьОписаниеЭлементов(ПараметрыВыполнения, ЭлементДанных)
	Выполнен = Ложь;  

	ДобавитьГруппу(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли;

	ДобавитьСтраницу(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли;   

	ДобавитьОписаниеКоманднойПанели(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли; 

	ДобавитьОписаниеСтраницы(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли; 

	ДобавитьОписаниеНадписи(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли; 
	
	ДобавитьОписаниеФлажка(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли; 

	ДобавитьОписаниеПоляВвода(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли; 		

	ДобавитьОписаниеТаблицы(ПараметрыВыполнения, ЭлементДанных, Выполнен);
	Если Выполнен Тогда
		Возврат;
	КонецЕсли; 		
КонецПроцедуры

&НаКлиенте
Функция ДобавитьРеквизитЭлемент(Реквизиты, УИД, ТипРеквизита)
	Результат = Новый Структура;
	Результат.Вставить("УИД", УИД);
	Результат.Вставить("ТипРеквизита", ТипРеквизита);
	Результат.Вставить("ИмяРеквизита", "");
	Результат.Вставить("УИДВладельца");
	Результат.Вставить("РабочееИмяРеквизита", "");
	Результат.Вставить("РабочееИмяЭлемента", "");
	Результат.Вставить("ИмяЭлемента", "");
	Результат.Вставить("Номер", 0);
	Результат.Вставить("ПолноеИмяРеквизита", "");
	Результат.Вставить("ПолноеИмяЭлемента", "");
	Результат.Вставить("ОписаниеТипов", Неопределено);
	
	Реквизиты.Добавить(Результат);
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ДобавитьЭлемент(Реквизиты, УИД, ТипРеквизита)
	Результат = ДобавитьРеквизитЭлемент(Реквизиты, УИД, ТипРеквизита);
	Результат.РабочееИмяЭлемента = ТипРеквизита;
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ДобавитьРеквизит(Реквизиты, УИД, ТипРеквизита, ОписаниеТипов = Неопределено)
	Результат = ДобавитьРеквизитЭлемент(Реквизиты, УИД, ТипРеквизита);
	Результат.РабочееИмяЭлемента = ТипРеквизита;
	Результат.ОписаниеТипов = ОписаниеТипов;
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура ДобавитьГруппу(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	ЭтоФорма = 
		ЭлементДанных.Тип = "Форма";
	
	ЭтоГруппа = 
		ЭтоФорма
		ИЛИ ЭлементДанных.Тип = "ГоризонтальнаяГруппа"
		ИЛИ ЭлементДанных.Тип = "ВертикальнаяГруппа"
		ИЛИ ЭлементДанных.Тип = "ОднострочнаяГруппа";

	Если НЕ ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  

	НовыйЭлемент = ДобавитьЭлемент(ОписанияРеквизитов, ЭлементДанных.УИД, "Группа");

	Если ЭтоФорма Тогда	
		Если ЭлементДанных.НаборСвойств.Свойство("Заголовок") И НЕ ПустаяСтрока(ЭлементДанных.НаборСвойств.Заголовок) Тогда
			НовыйЭлемент.РабочееИмяЭлемента = "Форма " + ЭлементДанных.НаборСвойств.Заголовок;
		Иначе
			НовыйЭлемент.РабочееИмяЭлемента = "Форма";
		КонецЕсли;
		
	КонецЕсли;
	
	Для Каждого Подэлемент Из ЭлементДанных.Элементы Цикл
		ЗаполнитьОписаниеЭлементов(ОписанияРеквизитов, Подэлемент);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеСтраницы(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "Страницы" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	ДобавитьЭлемент(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип);
	
	Для Каждого Подэлемент Из ЭлементДанных.Элементы Цикл
		ЗаполнитьОписаниеЭлементов(ОписанияРеквизитов, Подэлемент);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеНадписи(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "Надпись" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	ДобавитьЭлемент(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеФлажка(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "ПолеФлажка" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	НовоеОписание = ДобавитьРеквизит(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип, ЭлементДанных.ОписаниеТипов);
	НовоеОписание.РабочееИмяРеквизита = СокрЛП(ЭлементДанных.НаборСвойств.Заголовок);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеПоляВвода(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "ПолеВвода" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	НовоеОписание = ДобавитьРеквизит(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип, ЭлементДанных.ОписаниеТипов);
	НовоеОписание.РабочееИмяРеквизита = ЭлементДанных.НаборСвойств.Заголовок;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтраницу(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "Страница" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	НовоеОписание = ДобавитьЭлемент(ОписанияРеквизитов, ЭлементДанных.УИД, "Страница");
	
	Если НЕ ПустаяСтрока(ЭлементДанных.НаборСвойств.Заголовок) Тогда
		НовоеОписание.РабочееИмяЭлемента = ЭлементДанных.НаборСвойств.Заголовок;
	КонецЕсли; 
	
	Для Каждого Подэлемент Из ЭлементДанных.Элементы Цикл
		ЗаполнитьОписаниеЭлементов(ОписанияРеквизитов, Подэлемент);
	КонецЦикла;	
КонецПроцедуры
 
&НаКлиенте
Процедура ДобавитьОписаниеТаблицы(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "Таблица"
		И ЭлементДанных.Тип <> "Дерево" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	НовоеОписание = ДобавитьРеквизит(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип, ЭлементДанных.ОписаниеТипов);

	Если ЭлементДанных.НаборСвойств.Свойство("Имя") Тогда
		НовоеОписание.РабочееИмяРеквизита = ЭлементДанных.НаборСвойств.Имя;  
	Иначе
		НовоеОписание.РабочееИмяРеквизита = ЭлементДанных.Тип;  
	КонецЕсли;
	
	Для Каждого Колонка Из ЭлементДанных.Колонки Цикл
		ДобавитьОписаниеКолонкиТаблицы(ОписанияРеквизитов, Колонка, ЭлементДанных.УИД);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеКолонкиТаблицы(ОписанияРеквизитов, ЭлементДанных, ТаблицаУИД)
	НовоеОписание = ДобавитьРеквизит(ОписанияРеквизитов, ЭлементДанных.УИД, "Колонка", ЭлементДанных.ОписаниеТипов);
	НовоеОписание.УИДВладельца = ТаблицаУИД;
	
	Если НЕ ЭлементДанных.Тип = "ГруппаКолонокТаблицы" Тогда
		Если ПустаяСтрока(ЭлементДанных.НаборСвойств.Заголовок) Тогда
			НовоеОписание.РабочееИмяРеквизита = "Колонка";
		Иначе
			НовоеОписание.РабочееИмяРеквизита = ЭлементДанных.НаборСвойств.Заголовок;
		КонецЕсли;    
	КонецЕсли;
	
	Если ЭлементДанных.ЕстьФлажок Тогда
		НовоеОписаниеФлажок = ДобавитьРеквизит(ОписанияРеквизитов, ЭлементДанных.УИДФлажок, "КолонкаФлажок", ЭлементДанных.ОписаниеТиповФлажок);
		НовоеОписаниеФлажок.УИДВладельца = ТаблицаУИД;
		НовоеОписаниеФлажок.РабочееИмяРеквизита = ЭлементДанных.НаборСвойств.Заголовок + "Флажок";
	КонецЕсли;
	
	Для Каждого Колонка Из ЭлементДанных.Колонки Цикл
		ДобавитьОписаниеКолонкиТаблицы(ОписанияРеквизитов, Колонка, ТаблицаУИД);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеКоманднойПанели(ОписанияРеквизитов, ЭлементДанных, Выполнен)
	Если ЭлементДанных.Тип <> "КоманднаяПанель" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  

	ДобавитьЭлемент(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип);
	
	ЗаполнитьКнопкиКоманднойПанели(ОписанияРеквизитов, ЭлементДанных, ЭлементДанных.УИД);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьКнопкиКоманднойПанели(ОписанияРеквизитов, ЭлементДанных, КоманднаяПанельУИД)
	Для Каждого Подэлемент Из ЭлементДанных.Элементы Цикл                                           
		Выполнен = Ложь;
		ДобавитьОписаниеГруппыКнопок(ОписанияРеквизитов, Подэлемент, КоманднаяПанельУИД, Выполнен);
		Если Выполнен Тогда
			Продолжить;
		КонецЕсли;
		
		ДобавитьОписаниеКнопки(ОписанияРеквизитов, Подэлемент, КоманднаяПанельУИД);
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеГруппыКнопок(ОписанияРеквизитов, ЭлементДанных, КоманднаяПанельУИД, Выполнен)
	Если ЭлементДанных.Тип <> "ГруппаКнопок" Тогда
		Возврат;
	КонецЕсли;
	Выполнен = Истина;  
	
	НовоеОписание = ДобавитьЭлемент(ОписанияРеквизитов, ЭлементДанных.УИД, ЭлементДанных.Тип);
	НовоеОписание.УИДВладельца = КоманднаяПанельУИД;  
	
	ЗаполнитьКнопкиКоманднойПанели(ОписанияРеквизитов, ЭлементДанных, КоманднаяПанельУИД);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОписаниеКнопки(ОписанияРеквизитов, ЭлементДанных, КоманднаяПанельУИД)
	НовоеОписание = ДобавитьЭлемент(
		ОписанияРеквизитов, 
		ЭлементДанных.УИД, 
		ЭлементДанных.Тип);
		
	НовоеОписание.УИДВладельца = КоманднаяПанельУИД;   
	
	Если НЕ ПустаяСтрока(ЭлементДанных.НаборСвойств.Заголовок) Тогда
		НовоеОписание.РабочееИмяЭлемента = ЭлементДанных.НаборСвойств.Заголовок;  
	ИначеЕсли НЕ ПустаяСтрока(ЭлементДанных.Картинка) Тогда
		НовоеОписание.РабочееИмяЭлемента = ЭлементДанных.Картинка;  
	Иначе
		НовоеОписание.РабочееИмяЭлемента = ЭлементДанных.Тип;  
	КонецЕсли;
	
	Если ЭлементДанных.Тип <> "Подменю" Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьКнопкиКоманднойПанели(ОписанияРеквизитов, ЭлементДанных, КоманднаяПанельУИД);
КонецПроцедуры

#КонецОбласти

#Область ЗаполнитьИмена

&НаКлиенте
Процедура ЗаполнитьПолучитьИмяРеквизита(ОписанияРеквизитов, Описание, Префикс)  
	Если НЕ ПустаяСтрока(Описание.РабочееИмяРеквизита) Тогда 
		ИмяРеквизита = Префикс + ПреобразоватьИмяВРазрешенныйФормат(Описание.РабочееИмяРеквизита, Описание.ТипРеквизита);
		
		МассивСтрок = НайтиОписаниеРеквизита(ОписанияРеквизитов, "ИмяРеквизита", ИмяРеквизита, Описание.УИДВладельца);
		
		ТекНомер = 0;
		Для Каждого ТекСтрока Из МассивСтрок Цикл
			ТекНомер = Макс(ТекСтрока.Номер, ТекНомер);
		КонецЦикла;  
		
		Если ЭтоЗапрещенноеИмяРеквизита(ИмяРеквизита) И ТекНомер = 0 Тогда
			ТекНомер = 1;
		КонецЕсли;
		
		Описание.ИмяРеквизита = ИмяРеквизита;
		Описание.ИмяЭлемента = Описание.ИмяРеквизита;
		Описание.Номер = ТекНомер + 1;   
		
		ПолноеИмяРеквизита = ИмяРеквизита;
		Если Описание.Номер > 1 Тогда
			СтрокаНомер = Формат(Описание.Номер - 1, "ЧГ=0");
			ПолноеИмяРеквизита = ПолноеИмяРеквизита + СтрокаНомер;
		КонецЕсли;
		
		Описание.ПолноеИмяРеквизита = ПолноеИмяРеквизита;
		Описание.ПолноеИмяЭлемента = ПолноеИмяРеквизита;
		Возврат;
	КонецЕсли;

	Если НЕ ПустаяСтрока(Описание.РабочееИмяЭлемента) Тогда
		ИмяЭлемента = Префикс + ПреобразоватьИмяВРазрешенныйФормат(Описание.РабочееИмяЭлемента, Описание.ТипРеквизита);
		
		МассивСтрок = НайтиОписаниеРеквизита(ОписанияРеквизитов, "ИмяЭлемента", ИмяЭлемента, Описание.УИДВладельца);
		
		ТекНомер = 0;   
		// Для совместимости
		Если Описание.ТипРеквизита = "Группа" И Описание.РабочееИмяЭлемента <> "Форма" Тогда
			ТекНомер = 1;
		КонецЕсли;
		
		Для Каждого ТекСтрока Из МассивСтрок Цикл
			ТекНомер = Макс(ТекСтрока.Номер, ТекНомер);
		КонецЦикла;
		
		Описание.ИмяЭлемента = ИмяЭлемента;         
		
		Описание.Номер = ТекНомер + 1;         
		
		ПолноеИмяЭлемента = ИмяЭлемента;
		Если Описание.Номер > 1 Тогда
			СтрокаНомер = Формат(Описание.Номер - 1, "ЧГ=0");
			ПолноеИмяЭлемента = ПолноеИмяЭлемента + СтрокаНомер;
		КонецЕсли;
		Описание.ПолноеИмяЭлемента =  ПолноеИмяЭлемента;
	КонецЕсли;
КонецПроцедуры    

&НаКлиенте
Функция ПреобразоватьИмяВРазрешенныйФормат(Строка, Префикс)
	Если НЕ ЗначениеЗаполнено(Строка) Тогда
		Возврат Строка;
	КонецЕсли;
	
	ДиапазоныПервогоСимвола = ПолучитьДиапазоныРазрешенныхСимволов(Истина);
	Диапазоны = ПолучитьДиапазоныРазрешенныхСимволов(Ложь);
	
	Результат = "";
	Для Сч = 1 По СтрДлина(Строка) Цикл     
		Символ = Сред(Строка, Сч, 1);
		КодСимвола = КодСимвола(Символ); 
		
		ДопустимыйСимвол = Ложь;  
		
		ЭтоПервыйСимвол = ПустаяСтрока(Результат);
		
		Если Символ = "№" Тогда
			Результат = Результат + "Номер";
			Продолжить;
		КонецЕсли;
		
		// Первый символ не может быть числом
		Если ЭтоПервыйСимвол Тогда
			ДиапазонПоиска = ДиапазоныПервогоСимвола;
		Иначе
			ДиапазонПоиска = Диапазоны;
		КонецЕсли;
		
		ДопустимыйСимвол = ЭтоДопустимыйСимвол(ДиапазонПоиска, КодСимвола);
		
		Если ДопустимыйСимвол Тогда
			Результат = Результат + Символ;
		Иначе
			Результат = Результат + " ";
		КонецЕсли;
	КонецЦикла;
	
	Если ПустаяСтрока(Результат) Тогда
		Возврат Префикс;
	КонецЕсли;	

	МассивСтрок = СтрРазделить(Результат, " ");
	
	МассивРезультат = Новый Массив;
	Для Каждого Строка Из МассивСтрок Цикл
		Строка = ВРег(Лев(Строка, 1)) + Сред(Строка, 2);
		МассивРезультат.Добавить(Строка);
	КонецЦикла;
	Результат = СтрСоединить(МассивРезультат, "");
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ПолучитьДиапазоныРазрешенныхСимволов(ПервыйСимвол)
	Диапазоны = Новый Массив;
	
	Если НЕ ПервыйСимвол Тогда
		ДобавитьДопустимыйДиапазон(Диапазоны, "0", "9");
	КонецЕсли;
	
	ДобавитьДопустимыйДиапазон(Диапазоны, "A", "Z");
	ДобавитьДопустимыйДиапазон(Диапазоны, "a", "z");
	ДобавитьДопустимыйДиапазон(Диапазоны, "А", "я");
	ДобавитьДопустимыйДиапазон(Диапазоны, "Ё", "Ё");
	ДобавитьДопустимыйДиапазон(Диапазоны, "ё", "ё");
	ДобавитьДопустимыйДиапазон(Диапазоны, "_", "_");
	
	Возврат Диапазоны;
КонецФункции

&НаКлиенте
Процедура ДобавитьДопустимыйДиапазон(Диапазоны, СимволНачало, СимволКонец)
	Диапазоны.Добавить(
		Новый Структура("Мин,Макс", КодСимвола(СимволНачало), КодСимвола(СимволКонец)));
КонецПроцедуры

&НаКлиенте
Функция ЭтоДопустимыйСимвол(Диапазоны, КодСимвола)
	Для Каждого Диапазон Из Диапазоны Цикл
		Если КодСимвола >= Диапазон.Мин И КодСимвола <= Диапазон.Макс Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
КонецФункции

&НаКлиенте
Функция ЭтоЗапрещенноеИмяРеквизита(Имя)
	Возврат нрег(Имя) = "заголовок";
КонецФункции

&НаКлиенте
Функция НайтиОписаниеРеквизита(ОписанияРеквизитов, Поле, ЗначениеПоля, УИДВладельца)
	Результат = Новый Массив;
	Для Каждого Описание Из ОписанияРеквизитов Цикл

		Если Описание[Поле] <> ЗначениеПоля Тогда
			Продолжить;
		КонецЕсли;
		Если Описание.УИДВладельца <> УИДВладельца Тогда
			Продолжить;
		КонецЕсли;
		
		Результат.Добавить(Описание);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

#КонецОбласти
