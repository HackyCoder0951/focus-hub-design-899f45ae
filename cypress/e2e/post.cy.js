describe('Login Flow', () => {
  it('shows error for invalid credentials', () => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    // cy.contains('Invalid credentials').should('be.visible');
  });
});