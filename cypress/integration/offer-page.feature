Feature: 1.1.2 Страница предложения

  Background: Мокаю запросы к серверу
    Given пользователь неавторизован
    Given подменяю данные об обычном тестовом предложении
    Given подменяю данные о премиальном тестовом предложении
    Given подменяю запрос на добавление в избранное
    Given подменяю запрос на удаление из избранного
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён

  Scenario: На странице представлена расширенная информация об объекте для аренды (обычное предложение)
    # Проверяю информацию о предложении
    Then элемент '.offer__image-wrapper:nth-child(1) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/10.jpg'
    Then элемент '.offer__image-wrapper:nth-child(2) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/8.jpg'
    Then элемент '.offer__image-wrapper:nth-child(3) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/16.jpg'
    Then элемент '.offer__image-wrapper:nth-child(4) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/4.jpg'
    Then элемент '.offer__image-wrapper:nth-child(5) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/5.jpg'
    Then элемент '.offer__image-wrapper:nth-child(6) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/20.jpg'
    Then элемент '.offer__name' содержит текст 'Offer #1'
    Then элемент '.offer__description' содержит текст 'Regular Paris offer description.'
    Then элемента '.offer__mark' нет на странице
    Then элемент '.offer__feature--entire' содержит текст 'House'
    Then элемент '.offer__rating-value' содержит текст '2.1'
    Then элемент '.offer__stars span:nth-child(1)' имеет ширину '58'
    Then элемент '.offer__feature--bedrooms' содержит текст '1 Bedroom'
    Then элемент '.offer__feature--adults' содержит текст 'Max 1 adult'
    Then элемент '.offer__price-value' содержит текст '€929'
    Then элемент '.offer__inside-item:nth-child(1)' содержит текст 'Air conditioning'
    Then элемент '.offer__avatar' содержит изображение 'https://13.design.pages.academy/static/host/avatar-angelina.jpg'
    Then элемент '.offer__user-name' содержит текст 'Angelina'
    Then элемента '.offer__user-status' нет на странице
    Then элемент '.offer__avatar-wrapper' не содержит класс 'offer__avatar-wrapper--pro'

  Scenario: На странице представлена расширенная информация об объекте для аренды (премиальное предложение)
    When нахожусь на странице Premium Offer
    When запрос на получение данных о премиальном тестовом предложении завершён

    # Проверяю информацию о предложении
    Then элемент '.offer__image-wrapper:nth-child(1) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/13.jpg'
    Then элемент '.offer__image-wrapper:nth-child(2) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/8.jpg'
    Then элемент '.offer__image-wrapper:nth-child(3) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/16.jpg'
    Then элемент '.offer__image-wrapper:nth-child(4) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/4.jpg'
    Then элемент '.offer__image-wrapper:nth-child(5) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/5.jpg'
    Then элемент '.offer__image-wrapper:nth-child(6) .offer__image' содержит изображение 'https://13.design.pages.academy/static/hotel/20.jpg'
    Then элемента '.offer__image-wrapper:nth-child(7) .offer__image' нет на странице
    Then элемент '.offer__name' содержит текст 'Offer #2'
    Then элемент '.offer__description' содержит текст 'Premium Paris offer description.'
    Then элемент '.offer__mark' видим
    Then элемент '.offer__feature--entire' содержит текст 'Room'
    Then элемент '.offer__rating-value' содержит текст '4.9'
    Then элемент '.offer__stars span:nth-child(1)' имеет ширину '147'
    Then элемент '.offer__feature--bedrooms' содержит текст '2 Bedrooms'
    Then элемент '.offer__feature--adults' содержит текст 'Max 2 adults'
    Then элемент '.offer__price-value' содержит текст '€236'
    Then элемент '.offer__inside-item:nth-child(1)' содержит текст 'Air conditioning'
    Then элемент '.offer__inside-item:nth-child(2)' содержит текст 'Fridge'
    Then элемент '.offer__avatar' содержит изображение 'https://13.design.pages.academy/static/host/avatar-angelina.jpg'
    Then элемент '.offer__user-name' содержит текст 'Angelina'
    Then элемент '.offer__user-status' видим
    Then элемент '.offer__avatar-wrapper' содержит класс 'offer__avatar-wrapper--pro'

  Scenario: Кнопка «Избранное» (пользователь неавторизован)
    Then элемент '.offer__bookmark-button' не содержит класс 'offer__bookmark-button--active'
    When кликаю на элемент '.offer__bookmark-button'
    Then элемент '.page--login' видим

  Scenario: Кнопка «Избранное» (пользователь авторизован)
    # Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён

    # Проверяю кнопку
    Then элемент '.offer__bookmark-button' не содержит класс 'offer__bookmark-button--active'
    When кликаю на элемент '.offer__bookmark-button'
    When запрос на добавление в избранное завершён
    Then элемент '.offer__bookmark-button' содержит класс 'offer__bookmark-button--active'
    When кликаю на элемент '.offer__bookmark-button'
    When запрос на удаление из избранного завершён
    Then элемент '.offer__bookmark-button' не содержит класс 'offer__bookmark-button--active'

  Scenario: Предложения неподалёку (карта)
    Then на странице '3' карточек
    When прокручиваю страницу
    Then элемент '.leaflet-container' видим
    Then на карте '3' синих маркеров
    Then на карте '1' оранжевых маркеров
    Given запоминаю положение оранжевого маркера
    When навожу курсор на элемент '.near-places__card:nth-child(1)'
    Then на карте '3' синих маркеров
    Then на карте '1' оранжевых маркеров
    Then положение оранжевого маркера не изменилось
    Given запоминаю положение оранжевого маркера
    When убираю курсор с элемента '.near-places__card:nth-child(1)'
    Then на карте '3' синих маркеров
    Then на карте '1' оранжевых маркеров
    Then положение оранжевого маркера не изменилось
