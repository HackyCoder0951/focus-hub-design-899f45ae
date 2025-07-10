describe('Home Page', () => {
    it('visits the app root url', () => {
      cy.visit('/');
      cy.contains('Your Expected Element or Text');
    });
  });
  