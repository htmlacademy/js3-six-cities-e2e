import { Given } from 'cypress-cucumber-preprocessor/steps';

const baseApiUrl = Cypress.config('baseApiUrl');
const APIRoute = {
  OFFERS: `${baseApiUrl}/offers`,
  COMMENTS: `${baseApiUrl}/comments`,
  FAVORITES: `${baseApiUrl}/favorite`,
  LOGIN: `${baseApiUrl}/login`,
  LOGOUT: `${baseApiUrl}/logout`,
  NEARBY: '/nearby',
};
const OfferId = {
  FIRST: 'regular-offer-paris',
  SECOND: 'premium-offer-paris',
  THIRD: 'regular-offer-cologne',
  NONEXISTENT: 'test',
};

const Token = {
  KEY: 'six-cities-token',
  VALUE: 'token'
}

const firstOfferUrl = `${APIRoute.OFFERS}/${OfferId.FIRST}`;
const firstOfferComentsUrl = `${APIRoute.COMMENTS}/${OfferId.FIRST}`;
const firstOfferNearbyUrl = `${firstOfferUrl}${APIRoute.NEARBY}`;
const firstOfferFavoritesUrl = `${APIRoute.FAVORITES}/${OfferId.FIRST}`;

const secondOfferUrl = `${APIRoute.OFFERS}/${OfferId.SECOND}`;
const secondOfferComentsUrl = `${APIRoute.COMMENTS}/${OfferId.SECOND}`;
const secondOfferNearbyUrl = `${secondOfferUrl}${APIRoute.NEARBY}`;
const secondOfferFavoritesUrl = `${APIRoute.FAVORITES}/${OfferId.SECOND}`;

const thirdOfferFavoritesUrl = `${APIRoute.FAVORITES}/${OfferId.THIRD}`;

const nonexistentOfferUrl = `${APIRoute.OFFERS}/${OfferId.NONEXISTENT}`;
const nonexistentComentsUrl = `${APIRoute.COMMENTS}/${OfferId.NONEXISTENT}`;
const nonexistentNearbyUrl = `${nonexistentOfferUrl}${APIRoute.NEARBY}`;


Given(/^подменяю данные о предложениях$/, () => {
  cy.intercept('GET', APIRoute.OFFERS, {
    fixture: 'offers.json',
  }).as('getOffers');
});

Given(/^сервер отдаёт пустой список предложений$/, () => {
  cy.intercept(
    {
      method: 'GET',
      url: APIRoute.OFFERS,
    },
    {
      statusCode: 200,
      body: [],
    }
  ).as('getOffers');
});

When(/^запрос на получение данных о предложениях завершён$/, () => {
  cy.wait('@getOffers');
});

Given(/^подменяю данные об обычном тестовом предложении$/, () => {
  cy.intercept(
    'GET',
    firstOfferUrl,
    { fixture: 'regular-offer.json' }
  ).as('getRegularOffer');

  cy.intercept(
    'GET',
    firstOfferNearbyUrl,
    { fixture: 'nearby.json' }
  ).as('getNearby');

  cy.intercept(
    'GET',
    firstOfferComentsUrl,
    { fixture: 'reviews.json' }
  ).as('getComments');
});

Given(/^подменяю данные о премиальном тестовом предложении$/, () => {
  cy.intercept(
    'GET',
    secondOfferUrl,
    { fixture: 'premium-offer.json' }
  ).as('getPremiumOffer');

  cy.intercept(
    'GET',
    secondOfferNearbyUrl,
    { fixture: 'nearby.json' }
  ).as('getNearby');

  cy.intercept(
    'GET',
    secondOfferComentsUrl,
    { fixture: 'reviews.json' }
  ).as('getComments');
});

Given(/^подменяю данные о несуществующем тестовом предложении$/, () => {
  cy.intercept(
    'GET',
    nonexistentOfferUrl,
    { statusCode: 404 }
  ).as('getPremiumOffer');

  cy.intercept(
    'GET',
    nonexistentNearbyUrl,
    { statusCode: 404 }
  ).as('getNearby');

  cy.intercept(
    'GET',
    nonexistentComentsUrl,
    { statusCode: 404 }
  ).as('getComments');
});

When(/^запрос на получение данных об обычном тестовом предложении завершён$/, () => {
  cy.wait(['@getRegularOffer', '@getNearby', '@getComments']);
});

When(/^запрос на получение данных о премиальном тестовом предложении завершён$/, () => {
  cy.wait(['@getPremiumOffer', '@getNearby', '@getComments']);
});


Given(/^подменяю данные об избранных предложениях$/, () => {
  cy.intercept({
    method: 'GET',
    url: APIRoute.FAVORITES,
  }, {
    fixture: 'favorites.json',
  }).as('getFavorites');
});

Given(/^сервер отдаёт пустой список избранных предложений$/, () => {
  cy.intercept(
    {
      method: 'GET',
      url: APIRoute.FAVORITES,
    },
    {
      statusCode: 200,
      body: [],
    }
  ).as('getFavorites');
});

Given(/^запрос на получение данных об избранных предложениях не должен отправляться$/, () => {
  cy.intercept('GET', APIRoute.FAVORITES, () => {
    throw new Error('Запрос на получение данных об избранных предложениях отправлен!');
  })
    .as('getFavorites');
});

When(/^запрос на получение данных об избранных предложениях завершён$/, () => {
  cy.wait('@getFavorites');
});

Given(/^пользователь неавторизован$/, () => {
  cy.intercept(
    {
      method: 'GET',
      url: APIRoute.LOGIN,
    },
    {
      statusCode: 401,
    }
  ).as('getLogin');
});

Given(/^пользователь авторизован$/, () => {
  cy.intercept('GET', APIRoute.LOGIN, {
    fixture: 'user.json',
  }).as('getLogin');
  window.localStorage.setItem(Token.KEY, Token.VALUE);
});

When(/^запрос на получение данных об авторизации завершён$/, () => {
  cy.wait('@getLogin');
});

Given(/^подменяю запрос на логин$/, () => {
  cy.intercept('POST', APIRoute.LOGIN, {
    fixture: 'user.json',
  }).as('postLogin');
});

Given(/^сервер не даёт залогиниться$/, () => {
  cy.intercept({
    method: 'POST',
    url: APIRoute.LOGIN,
  }, {
    statusCode: 500,
  })
    .as('postLogin');
});

When(/^запрос на логин завершён$/, () => {
  cy.wait('@postLogin');
});

Then(/^запрос на логин отправлен с правильными данными$/, () => {
  cy.wait('@postLogin')
    .its('request.body')
    .then(({ email, password }) => {
      expect(email).to.eq('Lorem@test.com');
      expect(password).to.eq('i1');
    });
});

Given(/^подменяю запрос на логаут$/, () => {
  cy.intercept(
    {
      method: 'DELETE',
      url: APIRoute.LOGOUT,
    },
    {
      statusCode: 204,
    }
  ).as('deleteLogout');
});

When(/^запрос на логаут$/, () => {
  cy.wait('@deleteLogout');
});

Given(/^подменяю запрос на добавление в избранное$/, () => {
  cy.intercept('POST', `${firstOfferFavoritesUrl}/1`, {
    fixture: 'favorite-offer.json',
  })
    .as('addFavorite');
});

Given(/^подменяю запрос на удаление из избранного$/, () => {
  cy.intercept('POST', `${firstOfferFavoritesUrl}/0`, {
    fixture: 'regular-offer.json',
  })
    .as('deleteFavorite');
  cy.intercept('POST', `${secondOfferFavoritesUrl}/0`, {
    fixture: 'premium-offer.json',
  })
    .as('deleteFavorite');

  cy.intercept('POST', `${thirdOfferFavoritesUrl}/0`, {
    fixture: 'cologne-offer.json',
  })
    .as('deleteFavorite');
});

When(/^запрос на добавление в избранное завершён$/, () => {
  cy.wait('@addFavorite');
});

When(/^запрос на удаление из избранного завершён$/, () => {
  cy.wait('@deleteFavorite');
});

Given(/^подменяю запрос на отправку отзыва$/, () => {
  cy.intercept('POST', firstOfferComentsUrl, {
    fixture: 'new-review.json',
  })
    .as('postReview');
});

Given(/^отзыв отправляется с задержкой$/, () => {
  cy.intercept({
    method: 'POST',
    url: firstOfferComentsUrl
  }, {
    statusCode: 201,
    delayMs: 500,
    fixture: 'new-review.json'
  })
    .as('postReview');
});

Given(/^сервер не принимает отзывы$/, () => {
  cy.intercept({
    method: 'POST',
    url: firstOfferComentsUrl,
  }, {
    statusCode: 500,
  })
    .as('postReview');
});

When(/^запрос на отправку отзыва завершён$/, () => {
  cy.wait('@postReview');
});

Then(/^запрос на отправку отзыва отправлен с правильными данными$/, () => {
  cy.wait('@postReview')
    .its('request.body')
    .then(({ comment, rating }) => {
      expect(comment).to.eq('Lorem ipsum dolor sit amet, consectetur porta ante.');
      expect(rating).to.eq(5);
    });
});
