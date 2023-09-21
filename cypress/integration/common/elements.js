import { Then } from 'cypress-cucumber-preprocessor/steps';

Then(/^элемент '(.*)' видим$/, (selector) => {
  cy.get(selector).should('be.visible');
});

Then(/^элемент '(.*)' невидим$/, (selector) => {
  cy.get(selector).should('not.be.visible');
});

Then(/^элемента '(.*)' нет на странице$/, (selector) => {
  cy.get(selector).should('not.exist');
});

Then(/^элемент '(.*)' содержит текст '(.*)'$/, (selector, text) => {
  cy.get(selector).should(($el) => {
    const elText = $el.text().trim().toLowerCase();
    expect(elText).to.include(text.toLowerCase());
  });
});

Then(/^элемент '(.*)' содержит класс '(.*)'$/, (selector, cssClass) => {
  cy.get(selector).should('have.class', cssClass);
});

Then(/^элемент '(.*)' не содержит класс '(.*)'$/, (selector, cssClass) => {
  cy.get(selector).should('not.have.class', cssClass);
});

Then(/^на странице '(.*)' карточек$/, (count) => {
  cy.get('.place-card')
    .should('have.length', count);
});

Then(/^на карте '(.*)' синих маркеров$/, (count) => {
  cy.get('.map [src$="pin.svg"]')
    .should('have.length', count);
});

Then(/^на карте '(.*)' оранжевых маркеров$/, (count) => {
  cy.get('.map [src$="pin-active.svg"]')
    .should('have.length', count);
});

Then(/^элемент '(.*)' содержит изображение '(.*)'$/, (selector, imgUrl) => {
  cy.get(selector).should('have.attr', 'src', imgUrl);
});

Then(/^элемент '(.*)' имеет ширину '(.*)'$/, (selector, value) => {
  cy.get(selector)
    .invoke('css', 'width')
    .then((width) => parseInt(width, 10).toString())
    .should('be.eq', value);
});

Then(/^на странице '(.*)' отзывов$/, (count) => {
  cy.get('.reviews__item').should('have.length', count);
});

Then(/^элемент '(.*)' заблокирован$/, (selector) => {
  cy.get(selector).should('have.attr', 'disabled');
});

Then(/^элемент '(.*)' не заблокирован$/, (selector) => {
  cy.get(selector).should('not.have.attr', 'disabled');
});

Then(/^выбран элемент '(.*)'$/, (selector) => {
  cy.get(selector).should('be.checked');
});

Then(/^элемент '(.*)' не выбран$/, (selector) => {
  cy.get(selector).should('not.be.checked');
});

Then(/^значение поля '(.*)' равно '(.*)'$/, (selector, value) => {
  cy.get(selector).should('have.value', value);
});

Then(/^на странице '(.*)' города$/, (count) => {
  cy.get('.favorites__locations-items').should('have.length', count);
});
