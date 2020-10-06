
&НаКлиенте
Процедура GetToken(Команда)
	ЧастьЗапроса = "response_type=code"+"&";
	ЧастьЗапроса = ЧастьЗапроса + "client_id="+ Object.ИДКлиента + "&";
	ЧастьЗапроса = ЧастьЗапроса + "redirect_uri=http://localhost" + "&";
	ЧастьЗапроса = ЧастьЗапроса + "access_type=offline"+"&";
	
	//scope для работы с сервисами google
	//подробнее https://developers.google.com/admin-sdk/directory/v1/guides/authorizing
	ЧастьЗапроса = ЧастьЗапроса + "scope=https://www.googleapis.com/auth/drive " + 
								"https://www.googleapis.com/auth/spreadsheets "+
								"https://www.googleapis.com/auth/drive.file "; 
	АдресАвторизации = "https://accounts.google.com/o/oauth2/auth?";
	ПолныйАдресАвторизации = АдресАвторизации + ЧастьЗапроса;
    
    HTML_Поле = ПолныйАдресАвторизации;
КонецПроцедуры

&НаКлиенте
Процедура HTMLДокументСформирован(Элемент)
	//Заместо localhost здесь может находиться и другой адрес, указанный в самом Google [обычно указывается localhost]
	Попытка
		ПоискВхождения = СтрНайти(Элементы.HTML_Поле.Документ.Body.InnerHTML, "http://localhost/?code=");
		
		Если ПоискВхождения = 0 Тогда 
			Возврат;
		КонецЕсли;	
		Code = Сред(Элементы.HTML_Поле.Документ.Body.InnerHTML, ПоискВхождения+23, 91);
	Исключение
	
	КонецПопытки;
	
	
КонецПроцедуры
