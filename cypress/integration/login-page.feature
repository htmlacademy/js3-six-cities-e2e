Feature: 1.1.3 Страница Login

  Background: Мокаю запросы к серверу
    Given пользователь неавторизован
    Given подменяю запрос на логин
    When нахожусь на странице Login

  Scenario: Валидация логина и пароля
    Given подменяю данные о предложениях
    When кликаю на элемент '[name="email"]'
    When кликаю на элемент '[name="password"]'
    When в поле '[name="password"]' ввожу текст '{enter}'
    Then значение поля '[name="email"]' равно ''
    Then значение поля '[name="password"]' равно ''
    When в поле '[name="email"]' ввожу текст 'Lorem'
    When в поле '[name="password"]' ввожу текст 'i'
    When в поле '[name="password"]' ввожу текст '{enter}'
    Then значение поля '[name="email"]' равно 'Lorem'
    Then значение поля '[name="password"]' равно 'i'
    When в поле '[name="email"]' ввожу текст '@test.com'
    When в поле '[name="password"]' ввожу текст '{enter}'
    Then значение поля '[name="email"]' равно 'Lorem@test.com'
    Then значение поля '[name="password"]' равно 'i'
    When в поле '[name="password"]' ввожу текст '1'
    When в поле '[name="password"]' ввожу текст '{enter}'
    Then запрос на логин отправлен с правильными данными
    Then элемент '.page--main' видим

  Scenario: Если произошла ошибка, форма не очищается
    Given сервер не даёт залогиниться
    When в поле '[name="email"]' ввожу текст 'Lorem@test.com'
    When в поле '[name="password"]' ввожу текст 'i1'
    When в поле '[name="password"]' ввожу текст '{enter}'
    When запрос на логин завершён
    Then значение поля '[name="email"]' равно 'Lorem@test.com'
    Then значение поля '[name="password"]' равно 'i1'

  Scenario: При переключении страниц форма очищается
    Given подменяю запрос на логаут
    Given подменяю данные о предложениях
    Given подменяю данные об избранных предложениях
    When в поле '[name="email"]' ввожу текст 'Lorem'
    When в поле '[name="password"]' ввожу текст 'i'
    When в поле '[name="password"]' ввожу текст '{enter}'
    When кликаю на элемент '.header__logo-link'
    When кликаю на элемент '.header__login'
    Then значение поля '[name="email"]' равно ''
    Then значение поля '[name="password"]' равно ''
    When в поле '[name="email"]' ввожу текст 'Lorem@test.com'
    When в поле '[name="password"]' ввожу текст 'i1'
    When в поле '[name="password"]' ввожу текст '{enter}'
    When запрос на логин завершён
    Then элемент '.page--main' видим
    When кликаю на элемент '.header__signout'
    When кликаю на элемент '.header__login'
    Then значение поля '[name="email"]' равно ''
    Then значение поля '[name="password"]' равно ''

