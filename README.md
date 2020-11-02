# Структура проекта bms-ios

* BL/ViewModels – папка, которая содержит в себе все VM, которые обычно разбиты на логический группы.

* BaseViewModel – базовый класс для VM, который позволяет распространять общую логику между VM, а также предоставляет следующие методы:
  * navigateTo – переход на новую страницу
    * parameters:
    * modules – страница, которую необходимо открыть 
    * mode – режим навигации
    * navigationParams – параметры навигации
  
  * navigateBack – возврат на предыдущую страницу
    * patameters:
    * mode – режим навигации
  
  * showLoading – отображает состояние загрузки
  
  * showAlert – отображает alert
    * parameters:
      * title – заголовок 
      * message – основной текст
      * action – текст на "положительной кнопке"
      * cancelAction – текст на "отрицательной кнопке "
      * completion – замыкание,который выполняется после выбора элемента. Если выбран положительный элемент, то в качестве параметра передается true, иначе - false 
  
  * showActionSheet – отображает ActionSheet 
    * parameters:
      * title – заголовок
      * message – основной текст
      * action – массив строк, который будет отображаться на "положительных кнопках"
      * cancelAction – текст на "отрицательной кнопке "
      * completion – замыкание, которое выполняется после выбора элемента. Если выбирается отрицательный элемент, то в метод completion передается nil, иначе выбранный action

  * hideLoading – скрывает состояние загрузки
  
  * viewDidLoad – срабатывает после открытия view
  
  * viewDidDisappear – срабатывает после закрытия view

* DAL – уровень доступа к данным
	* Файлы:
    * DataServices –  отвечает за инициализацию DataServices
	    * initialize - инициализирует DataServices
		  * parameters:
		    * isMock - флаг, который определяет  будут ли инициализированы MockDataServices или RemoteDataServices 
		    * baseUrl - базовый url
* DTO – здесь хранятся все DTO объекты. DTO – это объект, который не содержит в себе  логики и описывает данные принимаемые от сервера
* DataConverters – содержат в себе различные конверторы данных 
	*	File ConverterExtensions – содержит в себе расширения для DTO, которые конвертируют их в объекты
    * DataObjects – содержит в себе объекты, которые используются в бизнес логике приложения
    * MockDataServices – содержит в себе фиктивные сервисы данных, которые реализуют те же протоколы, что и RemoteDataServices 
  * File BaseMockDataService – является базовым для MockDataService 
	  * MakeRequestFromJson<T> - возвращает RequestResult  из JSON файла
		  * parameters:
		    * fileName – имя JSON файла
* RemoteDataService – содержит сервисы запроса данных из API и сопутствующие файлы 
  * Files:
    * BaseRemoteDataService - является базовым RemoteDataService классов и предоставляет  методы запроса данных из API
	    * POST<ModelType: Encodable> - отправляет POST запрос 
	      * Parameters:
	        * url – конечная точка API
	        * token – Bearer token 
	        * model – модель, которая передается в тело запроса
	    * GET – отправляет GET запрос 
	      * Parameters:
	        * url – конечная точка API
	        * token – Bearer token 
	        * parameters – параметры запроса 
	        * execute – выполняет запрос на основе URLRequest
	        * params:
	        * request – URLRequest
	        * onSuccess – выполнится в случае успешного завершения запроса
	        * decode<ResultType: Decodable> – возвращает декодированное значение
* Shell:
	* Consts – содержит в себе константы, которые используются во всем приложении
	* DialogService – содержит в себе обертки различных диалоговых методов
		* showLoading – отображает состояние загрузки
		* hideLoading – скрывает состояние загрузки 
		* showAlert – отображает Alert
		  * params:
		    * result – словарь, который содержит в себе параметры для UIAlertController
		* showActionSheet – отображает ActionSheet
		  * params:
		    * result – словарь, который содержит в себе параметры для UIAlertController
	* NavigationService -  содержит в реализацию поведения навигации
		* initialize - инициализирует NavigationService 
		  * params:
		    * module - название базовой страницы
		    * setRootHandler - 
	* SettingsService - содержит в себе:
		* BaseSettingsService - содержит в себе реализацию различных методов для работы с keychain
		* SettingsService - содержит в себе поля, которые хранятся 	
	* SwiftEventBus - обертка над NotificationCenter, которая позволяет удобно передавать данные внутри приложения.
* UI - папка, которая содержит в себе Modules и различные инструменты для работы с пользовательским интерфейсом.
	* Convertes - содержит в себе различные конвертеры и вспомогательные классы
	* UIConverters - конвертирует бизнес объекты к формату, требуемому для отображения на UI
	* Delegates - Базовые делегаты, используемые в нескольких модулях
		* DefaultTableViewDataSource -
		* DefaultTableViewDelegate -
* Modules - папка, которая содержит в себе "страницы", состоящие из .storyboard и ViewController
* BaseViewController - базовая реализация ViewController, которая позволяет распространять общую логику между VC
