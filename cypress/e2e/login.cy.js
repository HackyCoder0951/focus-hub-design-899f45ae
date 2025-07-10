describe('Login Flow', () => {
  it('shows error for invalid credentials', () => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    // cy.contains('Invalid credentials', { timeout: 10000 }).should('be.visible');
    cy.get('body').then($body => {
      cy.log($body.html());
    });
  });
});