Feature: 1.1.2.2 Страница предложения. Форма отправки отзыва

  Background: Мокаю запросы к серверу
    Given пользователь авторизован
    Given подменяю данные об обычном тестовом предложении
    Given подменяю данные об избранных предложениях
    Given подменяю данные о предложениях
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён

  Scenario: Форма отправки отзыва отображается только для авторизованных пользователей
    Then элемент '.reviews__form' видим
    Given пользователь неавторизован
    When нахожусь на странице Regular Offer
    When запрос на получение данных об обычном тестовом предложении завершён
    Then элемента 'reviews__form' нет на странице

  Scenario: Пока пользователь не выбрал оценку и не ввёл текст, кнопка отправки не активна
    Then элемент '.reviews__submit' заблокирован
    When кликаю на элемент '[title="perfect"]'
    Then выбран элемент '#5-stars'
    When кликаю на элемент '[title="good"]'
    Then выбран элемент '#4-stars'
    When кликаю на элемент '[title="not bad"]'
    Then выбран элемент '#3-stars'
    When кликаю на элемент '[title="badly"]'
    Then выбран элемент '#2-stars'
    When кликаю на элемент '[title="terribly"]'
    Then выбран элемент '#1-stars'
    Then элемент '.reviews__submit' заблокирован
    When в поле '.reviews__textarea' ввожу текст 'not long enough...'
    Then элемент '.reviews__submit' заблокирован
    When в поле '.reviews__textarea' ввожу текст ' but now it should be long enough!'
    Then элемент '.reviews__submit' не заблокирован
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eget mollis neque. Quisque egestas, arcu in feugiat lobortis, quam turpis suscipit velit, eu accumsan mi leo feugiat metus. In non erat cursus, dignissim risus blandit, mattis augue nulla.'
    Then элемент '.reviews__submit' заблокирован

  Scenario: Данные об отзыве отправляются в правильном формате
    Given подменяю запрос на отправку отзыва
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    Then запрос на отправку отзыва отправлен с правильными данными

  Scenario: При отправке данных форма блокируется
    Given отзыв отправляется с задержкой
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    Then элемент '.reviews__submit' заблокирован
    Then элемент '#5-stars' заблокирован
    Then элемент '#4-stars' заблокирован
    Then элемент '#3-stars' заблокирован
    Then элемент '#2-stars' заблокирован
    Then элемент '#1-stars' заблокирован
    Then элемент '.reviews__textarea' заблокирован
    When запрос на отправку отзыва завершён
    Then элемент '.reviews__submit' заблокирован
    Then элемент '#5-stars' не заблокирован
    Then элемент '#4-stars' не заблокирован
    Then элемент '#3-stars' не заблокирован
    Then элемент '#2-stars' не заблокирован
    Then элемент '#1-stars' не заблокирован
    Then элемент '.reviews__textarea' не заблокирован

  Scenario: При успешной отправке данных форма очищается
    Given подменяю запрос на отправку отзыва
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    When запрос на отправку отзыва завершён
    Then элемент '#5-stars' не выбран
    Then значение поля '.reviews__textarea' равно ''
    Then элемент '.reviews__textarea' не заблокирован
    Then элемент '.reviews__submit' заблокирован

  Scenario: Если при отправке произошла ошибка, форма не очищается
    Given сервер не принимает отзывы
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    When запрос на отправку отзыва завершён
    Then выбран элемент '#5-stars'
    Then значение поля '.reviews__textarea' равно 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    Then элемент '.reviews__textarea' не заблокирован
    Then элемент '.reviews__submit' не заблокирован

  Scenario: Новый отзыв добавляется в начало списка
    Given подменяю запрос на отправку отзыва
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    When запрос на отправку отзыва завершён
    Then элемент '.reviews__amount' содержит текст '13'
    Then на странице '10' отзывов
    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'New Comment'
    Then элемент '.reviews__item:nth-child(1) .reviews__stars span:nth-child(1)' имеет ширину '58'
    Then элемент '.reviews__item:nth-child(1) .reviews__user-name' содержит текст 'Test user'

  Scenario: Пользователь может оставить любое количество отзывов
    Given подменяю запрос на отправку отзыва
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    When запрос на отправку отзыва завершён
    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'New Comment'
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.reviews__submit'
    When запрос на отправку отзыва завершён
    Then элемент '.reviews__amount' содержит текст '14'
    Then на странице '10' отзывов
    Then элемент '.reviews__item:nth-child(1) .reviews__text' содержит текст 'New Comment'
    Then элемент '.reviews__item:nth-child(2) .reviews__text' содержит текст 'New Comment'

  Scenario: При переключении страниц форма очищается
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When кликаю на элемент '.header__logo-link'
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
    Then элемент '#5-stars' не выбран
    Then значение поля '.reviews__textarea' равно ''
    When в поле '.reviews__textarea' ввожу текст 'Lorem ipsum dolor sit amet, consectetur porta ante.'
    When в поле '.reviews__textarea' ввожу текст '{enter}'
    When кликаю на элемент '.header__logo-link'
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
    Then элемент '#5-stars' не выбран
    Then значение поля '.reviews__textarea' равно ''
    When кликаю на элемент '[title="perfect"]'
    When в поле '.reviews__textarea' ввожу текст 'not long enough...'
    When в поле '.reviews__textarea' ввожу текст '{enter}'
    When кликаю на элемент '.header__logo-link'
    When кликаю на элемент '.cities__card:nth-child(1) .place-card__name a'
    Then элемент '#5-stars' не выбран
    Then значение поля '.reviews__textarea' равно ''
