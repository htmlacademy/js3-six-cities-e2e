Feature: 1.1.1.1 Главная страница. Список предложений

  Background: Мокаю запросы к серверу
    Given пользователь неавторизован
    Given подменяю данные о предложениях
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён

  Scenario: Сортировка
    Then элемент '.places__sorting-type' содержит текст 'Popular'
    Then элемент '.places__options' невидим
    Then элемент '.cities__card:nth-child(1) .place-card__name' содержит текст 'Offer #1'
    Then элемент '.cities__card:nth-child(2) .place-card__name' содержит текст 'Offer #2'
    When кликаю на элемент '.places__sorting-type'
    Then элемент '.places__options' видим
    When кликаю на элемент '.places__option:nth-child(2)'
    Then элемент '.places__sorting-type' содержит текст 'Price: low to high'
    Then элемент '.places__options' невидим
    Then элемент '.cities__card:nth-child(2) .place-card__name' содержит текст 'Offer #1'
    Then элемент '.cities__card:nth-child(1) .place-card__name' содержит текст 'Offer #2'
    When кликаю на элемент '.places__sorting-type'
    Then элемент '.places__options' видим
    When кликаю на элемент '.places__option:nth-child(3)'
    Then элемент '.places__sorting-type' содержит текст 'Price: high to low'
    Then элемент '.places__options' невидим
    Then элемент '.cities__card:nth-child(1) .place-card__name' содержит текст 'Offer #1'
    Then элемент '.cities__card:nth-child(2) .place-card__name' содержит текст 'Offer #2'
    When кликаю на элемент '.places__sorting-type'
    Then элемент '.places__options' видим
    When кликаю на элемент '.places__option:nth-child(4)'
    Then элемент '.places__sorting-type' содержит текст 'Top rated first'
    Then элемент '.places__options' невидим
    Then элемент '.cities__card:nth-child(2) .place-card__name' содержит текст 'Offer #1'
    Then элемент '.cities__card:nth-child(1) .place-card__name' содержит текст 'Offer #2'

  Scenario: Карточка предложения
    # Проверяю первую карточку
    Then элемент '.cities__card:nth-child(1) .place-card__image' содержит изображение 'https://13.design.pages.academy/static/hotel/10.jpg'
    Then элемента '.cities__card:nth-child(1) .place-card__mark' нет на странице
    Then элемент '.cities__card:nth-child(1) .place-card__price-value' содержит текст '€929'
    Then элемент '.cities__card:nth-child(1) .place-card__name' содержит текст 'Offer #1'
    Then элемент '.cities__card:nth-child(1) .place-card__type' содержит текст 'House'
    Then элемент '.cities__card:nth-child(1) .place-card__stars span:nth-child(1)' имеет ширину '29'

    # Проверяю вторую карточку
    Then элемент '.cities__card:nth-child(2) .place-card__image' содержит изображение 'https://13.design.pages.academy/static/hotel/13.jpg'
    Then элемент '.cities__card:nth-child(2) .place-card__mark' видим
    Then элемент '.cities__card:nth-child(2) .place-card__price-value' содержит текст '€137'
    Then элемент '.cities__card:nth-child(2) .place-card__name' содержит текст 'Offer #2'
    Then элемент '.cities__card:nth-child(2) .place-card__type' содержит текст 'Room'
    Then элемент '.cities__card:nth-child(2) .place-card__stars span:nth-child(1)' имеет ширину '73'

  Scenario: Клик по заголовку карточки выполняет переход на страницу с подробной информацией о предложении
    # Проверяю первую карточку
    Given подменяю данные об обычном тестовом предложении
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
    Then элемент '.page__main--offer' видим
    Then элемент '.offer__name' содержит текст 'Offer #1'

    # Проверяю вторую карточку
    Given подменяю данные о премиальном тестовом предложении
    When нахожусь на странице Main
    When кликаю на элемент '.cities__card:nth-child(2) .place-card__name a'
    Then элемент '.page__main--offer' видим
    Then элемент '.offer__name' содержит текст 'Offer #2'

  Scenario: Предложения отсутствуют
    # Мокаю запросы к серверу
    Given сервер отдаёт пустой список предложений
    When нахожусь на странице Main
    When запрос на получение данных о предложениях завершён

    # Проверяю Париж
    Then элемент '.page__main--index-empty' видим
    Then элемент '.cities__places-container--empty' видим
    Then элемент '.cities__no-places' видим
    Then элемента '.cities__places-list' нет на странице
    Then элемент '.cities__status' содержит текст 'No places to stay available'
    Then элемент '.cities__status-description' содержит текст 'We could not find any property available at the moment in Paris'
    Then элемента '.cities__map' нет на странице
    Then элемента '.leaflet-container' нет на странице

    # Проверяю Кёльн
    When кликаю на элемент '.locations__item:nth-child(2)'
    Then элемент '.page__main--index-empty' видим
    Then элемент '.cities__places-container--empty' видим
    Then элемент '.cities__no-places' видим
    Then элемента '.cities__places-list' нет на странице
    Then элемент '.cities__status' содержит текст 'No places to stay available'
    Then элемент '.cities__status-description' содержит текст 'We could not find any property available at the moment in Cologne'
    Then элемента '.cities__map' нет на странице
    Then элемента '.leaflet-container' нет на странице

