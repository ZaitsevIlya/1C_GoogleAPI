
&НаКлиенте
Процедура GetToken(Команда)
	ЧастьЗапроса = "response_type=code"+"&";
	ЧастьЗапроса = ЧастьЗапроса + "client_id="+ Объект.ClientID + "&";
	ЧастьЗапроса = ЧастьЗапроса + "redirect_uri=http://localhost" + "&";
	ЧастьЗапроса = ЧастьЗапроса + "access_type=offline"+"&";
	
	//scope для работы с сервисами google
	//подробнее https://developers.google.com/admin-sdk/directory/v1/guides/authorizing
	ЧастьЗапроса = ЧастьЗапроса + "scope=https://www.googleapis.com/auth/drive " + 
								"https://www.googleapis.com/auth/spreadsheets "+
								"https://www.googleapis.com/auth/drive.file "; 
	АдресАвторизации = "https://accounts.google.com/o/oauth2/auth?";
	ПолныйАдресАвторизации = АдресАвторизации + ЧастьЗапроса;
    
    HTML = ПолныйАдресАвторизации;
КонецПроцедуры

&НаКлиенте
Процедура HTMLДокументСформирован(Элемент)
	//Заместо localhost здесь может находиться и другой адрес, указанный в самом Google [обычно указывается localhost]
	Попытка
		ПоискВхождения = СтрНайти(Элементы.HTML.Документ.URL, "http://localhost/?code=");
		
		Если ПоискВхождения = 0 Тогда 
			Возврат;
		КонецЕсли;	
		Code = Сред(Элементы.HTML.Документ.URL, ПоискВхождения+23, 91);
		
	Исключение
		Сообщить("Исключение в процедуре HTMLДокументСформирован");
		Возврат;
	КонецПопытки;
	Попытка
		Token = ПолучитьТокен(Code, Объект.ClientID, Объект.ClientSecret);
	Исключение
		Сообщить("Исключение токена");
	КонецПопытки;
	Возврат;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТокен(Код, ИДКлиента, СекретКлиента)
	Result = GoogleAPI.ПолучитьТокен(Код, ИДКлиента, СекретКлиента);
	Токен = Result.AccessToken;
	Константы.Token.Установить(Токен);
	Возврат(Токен);
КонецФункции

&НаКлиенте
Процедура ОформитьТаблицу(Команда)
	ОформитьТаблицуСервер();
КонецПроцедуры

&НаСервере
Процедура ОформитьТаблицуСервер()
	GoogleAPI.Тест("1Ve1UDzbnf8KSlmIcfivVjyUeKBkY3Es652Y7dccdO7I", 1, "AIzaSyBVIwQOOexE3-hQ8IzC1jNXJN3lCEUVtqE", Константы.Token.Получить());
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Объект.ClientID = "9816970693-20e6rfm4njh0b5g9ohjhg5ktpmdk32lt.apps.googleusercontent.com";
	Объект.ClientSecret = "VNE-LL7AFJ8UWrwQuxrwqLxW";
КонецПроцедуры
