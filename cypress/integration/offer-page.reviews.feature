Feature: 1.1.2.1 Страница предложения. Отзывы пользователей

  Background: Мокаю запросы к серверу
    Given пользователь неавторизован
    Given подменяю данные об обычном тестовом предложении
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён

  Scenario: Список отзывов
    Then элемент '.reviews__amount' содержит текст '12'
    Then на странице '10' отзывов
    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'Comment #7'
    Then элемент '.reviews__item:nth-child(10) .reviews__text' содержит текст 'Comment #3'

  Scenario: Карточка с отзывом
    Then элемент '.reviews__item:nth-child(2) .reviews__avatar' содержит изображение 'https://13.design.pages.academy/static/avatar/3.jpg'
    Then элемент '.reviews__item:nth-child(2) .reviews__user-name' содержит текст 'Isaac'
    Then элемент '.reviews__item:nth-child(2) .reviews__stars span:nth-child(1)' имеет ширину '78'
    Then элемент '.reviews__item:nth-child(2) .reviews__time' содержит текст 'October 2023'
    Then элемент '.reviews__item:nth-child(2) .reviews__text' содержит текст 'Comment #9'
