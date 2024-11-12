package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

// Product представляет продукт
type Product struct {
	ID          int
	Title       string
	Author      string
	ImageLink   string
	Description string
	PageCount   int
	Price       int

	Favourite bool
}

// Пример списка продуктов
var products = []Product{
	{ID: 1, Title: "Кровавый Меридиан", Author: "Кормак Маккарти", ImageLink: "https://imo10.labirint.ru/books/395820/cover.jpg/242-0", Description: "«Кровавый меридиан, или закатный багрянец на западе» (англ. Blood Meridian; or, The Evening Redness in the West ) — эпический роман американского писателя Кормака Маккарти. Роман относится к жанру вестерн, а иногда его классифицируют как ревизионистский вестерн.\n\nПовествование романа следует за вымышленным персонажем, которого называют «Малец». Большую часть повествования «Малец» пребывает в банде Глэнтона — группе охотников за скальпами, которые убивали коренных американцев с 1849 по 1850 год из-за денег, ради удовольствия и даже по нигилистической привычке.", PageCount: 1250, Price: 120, Favourite: false},
	{ID: 2, Title: "Многорукий бог Далайна", Author: "Святослав Логинов", ImageLink: "https://cdn.azbooka.ru/cv/w1100/4cec730a-adc2-4b86-832d-568c805fe801.jpg", Description: "«Многору́кий бог далайна» — первое крупное произведение (роман) советского и российского фантаста Святослава Логинова, написанное в 1991—1992 годах и опубликованное в 1995 году (издание датировано 1994 годом). Роман представляет собой вершину русской философско-метафорической фэнтези.\n\nДействие романа разворачивается в вымышленном мире — далайне, представляющем собой четырёхугольный бассейн, который можно обойти по периметру всего за четыре дня. Внутри далайна существуют квадратные участки суши фиксированного размера — оройхоны. По признанию автора, прототипом такой «вселенной» послужила его детская забава: на листе тетради в клеточку он создавал карты, состоящие из квадратных элементов. Несмотря на изначальную схематичность и условность подобного «мироустройства», его фрагменты проработаны весьма подробно, создавая в результате стройную и гармоничную картину мира.", PageCount: 1708, Price: 60, Favourite: false},
	{ID: 3, Title: "Возвышение Хоруса", Author: "Дэн Абнетт", ImageLink: "https://m.media-amazon.com/images/I/81p1PCweWEL._AC_UF1000,1000_QL80_.jpg", Description: "«Возвыше́ние Хоруса» (англ. «Horus Rising») — книга Дэна Абнетта в жанре фантастики, действие которой разворачивается во вселенной Warhammer 40,000.\n\nДействие книги разворачивается за 10 тысяч лет до временной границы сеттинга Warhammer 40,000 и распространяется на историю Ереси Хоруса, величайшей галактической гражданской войны и предтечи многих событий вселенной Warhammer 40,000. Для возвращения разрозненных человеческих миров под контроль Империума был объявлен Великий крестовый поход. Однако, через некоторое время Император человечества решает отойти от ратных дел и командование кампанией поручает своему самому любимому примарху — Хорусу из Легиона Лунных волков. Получив широчайшие полномочия, Хорус приводит многие миры к согласию.", PageCount: 1400, Price: 120, Favourite: false},
	{ID: 4, Title: "Метро 2033", Author: "Дмитрий Глуховский", ImageLink: "https://upload.wikimedia.org/wikipedia/ru/c/c2/Metro_2033_Eksmo.jpg", Description: "«Метро́ 2033» — постапокалиптический роман Дмитрия Глуховского, описывающий жизнь людей в московском метро после ядерной войны на Земле.\n\nКнига повествует о людях, оставшихся в живых после ядерной войны. В романе война упоминается лишь вскользь. В результате обмена ядерными ударами все крупные города были стёрты с лица земли. Почти всё действие разворачивается в Московском метрополитене, где на станциях и в переходах живут люди. Благодаря оперативным действиям служб гражданской обороны метрополитен удалось оградить от радиации: почти на всех станциях были закрыты гермозатворы, а в системах вентиляции и водоснабжения активированы противорадиационные фильтры. При этом лишь менее половины станций обитаемы: часть станций заброшена, часть изолирована обрушением тоннелей, часть сгорела. Некоторые станции захвачены существами с поверхности.", PageCount: 1500, Price: 200, Favourite: false},
	{ID: 5, Title: "К самому себе", Author: "Марк Аврелий", ImageLink: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Marcus_Aurelius._De_seipso%2C_seu_vita_sua_%28Xylander%2C_1558%29.pdf/page1-246px-Marcus_Aurelius._De_seipso%2C_seu_vita_sua_%28Xylander%2C_1558%29.pdf.jpg", Description: "«К самому себе» - сборник афористических мыслей римского императора Марка Аврелия в двенадцати «книгах» (небольших главах), написанный им на греческом языке (койне) в 70-е годы II в. н. э., главным образом на северо-восточных границах империи и в Сирмии. Ключевой памятник Поздней Стои.\n\nПо всей видимости, император не предназначал личный моралистический дневник для публикации. Его занимают преимущественно проблемы долга и смерти. Раз за разом он напоминает себе о необходимости не поддаваться ненависти или гневу, несмотря на подлые поступки и промахи окружающих. Деонтологическая рефлексия Марка Аврелия основана на осознании личной ответственности за судьбы огромного общества, которое подтачивают изнутри разложение нравов, а извне — набеги варваров. В этих сложных условиях он пытается сохранять позу мудреца и удерживать душевное равновесие.\n\nФилософские взгляды императора не отличаются оригинальностью. В основных пунктах это переосмысление учения Эпиктета: пытаться переделать мир на свой лад бесполезно, судьбу должно принимать без ропота, каждый жребий хорош по-своему. Религиозное чувство Марка Аврелия сродни неоплатонизму и даже христианству (хотя последнее при нём подвергалось гонениям). В космосе он видит некое целесообразно упорядоченное Целое, которым управляет всеобщий разум (промысел).", PageCount: 500, Price: 0, Favourite: false},
	{ID: 6, Title: "Смертные машины", Author: "Филип Рив", ImageLink: "https://static.wikia.nocookie.net/hungrycitychronicles/images/3/3c/Mortal_Engines_-_2018_Cover_-_Mcque.png/revision/latest?cb=20200224100510&path-prefix=ru", Description: "Смертные Машины (англ. Mortal Engines) – первая книга в Тетралогии (Или в Хрониках Хищных Городов).\n\nСобытия «Смертных Машин» происходят в постапокалиптическом мире, уничтоженном Шестидесятиминутной Войной, которая вызвала массу геологических изменений. Чтобы стать независимым от набегов кочевников и природных катаклизмов, лидер Империи кочевников «Движение» Никола Кверкус (позже известный, как Николас Квирк) поставил Лондон на огромные двигатели и колеса и присоединил к нему огромные челюсти. Тем самым он дал возможность Лондону разбирать (или же поедать) другие города для получения ресурсов. Технология «движущихся городов» быстро распространялась по миру. Эту технологию стали называть Муниципальным Дарвинизмом. Муниципальный дарвинизм распространился на большую часть мира, за исключением Азии и некоторых территорий Африки, но основным местоположением движущихся городов стали Великие Охотничьи Угодья.", PageCount: 807, Price: 120, Favourite: false},
	{ID: 7, Title: "Низший", Author: "Дем Михайлов", ImageLink: "https://cm.author.today/content/2019/09/03/w/3f3de1623e28480894974d0dbf0851f2.jpeg", Description: "Безымянный мир, где рождаешься уже взрослым и в долгах. Мир, где даже твои руки и ноги тебе не принадлежат, а являются собственностью бездушной системы. Безумно жестокий мир, где жизнь не стоит ни единого сола, где ты добровольно низший со стертой памятью, где за ошибки, долги и преступления тебя лишают конечности за конечностью, медленно превращая в беспомощного червя с человеческим лицом... Мир со стальными небом и землей, с узкими давящими стенами, складывающимися в бесконечный стальной лабиринт. Мир, где в торговых автоматах продают шизу и дубины, где за тобой охотятся кровожадные безголовые плуксы, а самая страшная участь - превратиться в откормленную свинью...", PageCount: 891, Price: 60, Favourite: false},
	{ID: 8, Title: "Пролетая над гнездом кукушки", Author: "Кен Кизи", ImageLink: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdPDbUpLk0oPq4iMnmzoS8-TqfaEGE0ATLmQ&s", Description: "Действие романа происходит в психиатрической больнице. Повествование идёт от лица индейца по кличке Вождь Бромден, одного из пациентов; Вождь притворяется глухонемым. Одним из главных героев романа является свободолюбивый пациент Рэндл Патрик Макмёрфи, переведённый в психиатрическую больницу из тюрьмы.\n\nМакмёрфи противостоит старшей сестре Милдред Рэтчед. Она немолодая женщина, работающая в отделении больницы. Старшая сестра, олицетворение системы (Комбинат, как называет её рассказчик), личная жизнь которой не сложилась, тщательно укрепляет свою власть над пациентами и персоналом отделения. Бунтарь Макмёрфи принимается рушить устроенный ею порядок и быстро завоёвывает весомый авторитет среди остальных пациентов, уча їх наслаждаться благами жизни и даже освобождая от хронических комплексов. Он заключает разнообразные пари с другими пациентами, организует в отделении карточные игры, пытается устроить просмотр трансляции бейсбольных игр Мировой серии по телевизору. Вопреки выигранному Макмёрфи голосованию среди пациентов, в котором решающим оказывается голос Вождя, сестра Рэтчед отключает телевизор от сети, но пациенты остаются перед экраном и притворяются, что смотрят бейсбол — этот акт массового неповиновения заставляет сестру Рэтчед потерять контроль над собой и сорваться.", PageCount: 1061, Price: 120, Favourite: false},
	{ID: 9, Title: "451 градус по фаренгейту", Author: "Рэй Брэдбери", ImageLink: "https://upload.wikimedia.org/wikipedia/ru/thumb/d/d3/451_%D0%B3%D1%80%D0%B0%D0%B4%D1%83%D1%81_%D0%BF%D0%BE_%D0%A4%D0%B0%D1%80%D0%B5%D0%BD%D0%B3%D0%B5%D0%B9%D1%82%D1%83.jpg/239px-451_%D0%B3%D1%80%D0%B0%D0%B4%D1%83%D1%81_%D0%BF%D0%BE_%D0%A4%D0%B0%D1%80%D0%B5%D0%BD%D0%B3%D0%B5%D0%B9%D1%82%D1%83.jpg", Description: "451 градус по Фаренгейту» (англ. Fahrenheit 451) — научно-фантастический роман-антиутопия Рэя Брэдбери, изданный в 1953 году. Роман описывает американское общество близкого будущего, в котором книги находятся под запретом; «пожарные», к числу которых принадлежит и главный герой Гай Монтэг, сжигают любые найденные книги. В ходе романа Монтэг разочаровывается в идеалах общества, частью которого он является, становится изгоем и присоединяется к небольшой подпольной группе маргиналов, сторонники которой заучивают тексты книг, чтобы спасти их для потомков. В книге содержится немало цитат из произведений англоязычных авторов прошлого (таких, как Уильям Шекспир, Джонатан Свифт и другие), а также несколько цитат из Библии.", PageCount: 636, Price: 200, Favourite: false},
}

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	fmt.Printf("Got items")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)

	newProduct.ID = len(products) + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

//Добавление маршрута для получения одного продукта

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			fmt.Printf("Got item by id %v", id)
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {

			products[i].Title = updatedProduct.Title
			products[i].Author = updatedProduct.Author
			products[i].ImageLink = updatedProduct.ImageLink
			products[i].Description = updatedProduct.Description
			products[i].PageCount = updatedProduct.PageCount
			products[i].Price = updatedProduct.Price

			products[i].Favourite = updatedProduct.Favourite

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)           // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)  // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)       // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler) // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler) // Удалить продукт

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}
