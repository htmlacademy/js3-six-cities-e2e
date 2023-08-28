Feature: 1.1.2 Страница Favorites

  Background: Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об избранных предложениях
    When нахожусь на странице Favorites

  Scenario: На странице отображаются избранные предложения, сгруппированные по городам
    When запрос на получение данных об избранных предложениях завершён
    Then на странице '3' карточек
    Then на странице '2' города

  Scenario: После удаления предложения из избранного, список актуализируется
    Given подменяю запрос на удаление из избранного
    When запрос на получение данных об избранных предложениях завершён
    When кликаю на элемент '.favorites__locations-items:nth-child(1) .place-card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then на странице '2' карточек
    Then на странице '2' города
    When кликаю на элемент '.favorites__locations-items:nth-child(1) .place-card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then на странице '1' карточек
    Then на странице '1' города
    When кликаю на элемент '.favorites__locations-items:nth-child(1) .place-card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then на странице '0' карточек
    Then на странице '0' города
    Then элемента '.favorites__list' нет на странице
    Then элемента '.favorites__title' нет на странице

  Scenario: В шапке отображается количество избранных предложений
    Given подменяю запрос на удаление из избранного
    When запрос на получение данных об избранных предложениях завершён
    Then элемент '.header__favorite-count' содержит текст '3'
    When кликаю на элемент '.favorites__locations-items:nth-child(1) .place-card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then элемент '.header__favorite-count' содержит текст '2'
    When кликаю на элемент '.favorites__locations-items:nth-child(1) .place-card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then элемент '.header__favorite-count' содержит текст '1'
    When кликаю на элемент '.favorites__locations-items:nth-child(1) .place-card:nth-child(1) .place-card__bookmark-button'
    When запрос на удаление из избранного завершён
    Then элемент '.header__favorite-count' содержит текст '0'

  Scenario: Избранные предложения отсутствуют
    Given сервер отдаёт пустой список избранных предложений
    When нахожусь на странице Favorites
    When запрос на получение данных об избранных предложениях завершён
    Then элемент '.page--favorites-empty' видим
    Then элемент '.page__main--favorites-empty' видим
    Then элемент '.favorites--empty' видим
    Then элемент '.favorites__status' содержит текст 'Nothing yet saved.'
