Feature: 1.1.1 Главная страница

  Background: Мокаю запросы к серверу
    Given подменяю данные о предложениях
    Given пользователь неавторизован

  Scenario: На главной странице отображается список городов
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    Then элемент '.locations__list' содержит текст 'ParisCologneBrusselsAmsterdamHamburgDusseldorf'
    Then элемент '.tabs__item--active' содержит текст 'Paris'
    Then элемент '.places__found' содержит текст '2 places to stay in Paris'
    Then элемент '.cities__places-list' видим
    Then на странице '2' карточек
    Then элемент '.leaflet-container' видим
    Then на карте '2' синих маркеров
    When кликаю на элемент '.locations__item:nth-child(2)'
    Then элемент '.tabs__item--active' содержит текст 'Cologne'
    Then элемент '.places__found' содержит текст '1 place to stay in Cologne'
    Then элемент '.cities__places-list' видим
    Then на странице '1' карточек
    Then элемент '.leaflet-container' видим
    Then на карте '1' синих маркеров

  Scenario: Клик по кнопке «Избранное» (пользователь неавторизован)
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__bookmark-button'
    Then элемент '.page--login' видим

  Scenario: Клик по кнопке «Избранное» (пользователь авторизован)
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях
    Given подменяю запрос на добавление в избранное
    Given подменяю запрос на удаление из избранного
    When нахожусь на странице Main
    When запрос на получение данных об авторизации завершён
    When запрос на получение данных о предложениях завершён
    Then элемент '.cities__card:nth-child(1) .place-card__bookmark-button' не содержит класс 'place-card__bookmark-button--active'
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__bookmark-button'
    When запрос на добавление в избранное завершён
    Then элемент '.cities__card:nth-child(1) .place-card__bookmark-button' содержит класс 'place-card__bookmark-button--active'
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then элемент '.cities__card:nth-child(1) .place-card__bookmark-button' не содержит класс 'place-card__bookmark-button--active'

  Scenario: Избранное на главной странице работает корректно
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях
    Given подменяю запрос на добавление в избранное
    When нахожусь на странице Main
    When запрос на получение данных об авторизации завершён
    When запрос на получение данных о предложениях завершён
    Then элемент '.cities__card:nth-child(1) .place-card__bookmark-button' не содержит класс 'place-card__bookmark-button--active'
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__bookmark-button'
    When запрос на добавление в избранное завершён
    Then элемент '.cities__card:nth-child(1) .place-card__bookmark-button' содержит класс 'place-card__bookmark-button--active'

    # Переключаем город для проверки корректности отображения
    When кликаю на элемент '.locations__item:nth-child(2)'
    When кликаю на элемент '.locations__item:nth-child(1)'
    Then элемент '.cities__card:nth-child(1) .place-card__bookmark-button' содержит класс 'place-card__bookmark-button--active'
