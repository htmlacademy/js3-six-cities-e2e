Feature: 3 Дополнительно

  Scenario: Страница «Login». Кнопка для быстрого перехода к списку предложений
    Given пользователь неавторизован
    Given подменяю данные о предложениях
    When нахожусь на странице Login
    Then элемент '.locations__item-link' видим
    Given запоминаю случайный город
    When кликаю на элемент '.locations__item-link'
    Then выбран случайный город
    When кликаю на элемент '.header__nav-link--profile'
    Given запоминаю случайный город
    When кликаю на элемент '.locations__item-link'
    Then выбран случайный город
    When кликаю на элемент '.header__nav-link--profile'
    Given запоминаю случайный город
    When кликаю на элемент '.locations__item-link'
    Then выбран случайный город
    When кликаю на элемент '.header__nav-link--profile'
    Given запоминаю случайный город
    When кликаю на элемент '.locations__item-link'
    Then выбран случайный город
    When кликаю на элемент '.header__nav-link--profile'
    Given запоминаю случайный город
    When кликаю на элемент '.locations__item-link'
    Then выбран случайный город
    Then города были случайны
