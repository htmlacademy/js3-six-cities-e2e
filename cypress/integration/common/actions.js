import { When } from 'cypress-cucumber-preprocessor/steps';

When('нахожусь на странице Main', () => {
  cy.visit('/');
});

When('нахожусь на странице Login', () => {
  cy.visit('/login');
});

When('нахожусь на странице Favorites', () => {
  cy.visit('/favorites');
});

When('нахожусь на странице Regular Offer', () => {
  cy.visit('/offer/regular-offer-paris');
});

When('нахожусь на странице Premium Offer', () => {
  cy.visit('/offer/premium-offer-paris');
});

When('нахожусь на несуществующей странице', () => {
  cy.visit('/test');
});

When('нахожусь на странице несуществующего предложения', () => {
  cy.visit('/offer/test');
});

When(/^кликаю на элемент '(.*)'$/, (selector) => {
  cy.get(selector).click();
});

When(/^навожу курсор на элемент '(.*)'$/, (selector) => {
  cy.get(selector).trigger('mouseenter');
  cy.get(selector).trigger('mouseover');
});

When(/^убираю курсор с элемента '(.*)'$/, (selector) => {
  cy.get(selector).trigger('mouseleave');
  cy.get(selector).trigger('mouseout');
});

When(/^прокручиваю страницу$/, () => {
  cy.window().scrollTo('bottom');
});

let markerRect;
Given(/^запоминаю положение оранжевого маркера$/, () => {
  cy
    .get('.map [src$="pin-active.svg"]')
    .then(($marker) => {
      markerRect = $marker[0].getBoundingClientRect();
    });
});

Then(/^положение оранжевого маркера не изменилось$/, () => {
  cy
    .get('.map [src$="pin-active.svg"]')
    .then(($marker) => $marker[0].getBoundingClientRect())
    .then(({x, y}) => {
      expect(x).to.eq(markerRect.x);
      expect(y).to.eq(markerRect.y);
      markerRect = undefined;
    });
});

Then(/^положение оранжевого маркера изменилось$/, () => {
  cy
    .get('.map [src$="pin-active.svg"]')
    .then(($marker) => $marker[0].getBoundingClientRect())
    .then(({x, y}) => {
      expect(x !== markerRect.x || y !== markerRect.y).to.eq(true);
      markerRect = undefined;
    });
});

When(/^в поле '(.*)' ввожу текст '(.*)'$/, (selector, text) => {
  cy.get(selector).type(text);
});

let randomCity;
const citySet = new Set();
Given(/^запоминаю случайный город$/, () => {
  cy
    .get('.locations__item-link')
    .then(($link) => {
      randomCity = $link[0].textContent;
      citySet.add(randomCity);
    });
});

Then(/^выбран случайный город$/, () => {
  cy
    .get('.tabs__item--active')
    .should('have.text', randomCity)
    .then(() => {
      markerRect = undefined;
    });
});

Then(/^города были случайны$/, () => {
  expect(citySet.size).to.be.greaterThan(1);
  citySet.clear();
});
