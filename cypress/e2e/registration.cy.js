describe('Registration Flow', () => {
  it('registers a new user', () => {
    cy.visit('/register');
    cy.get('input#name').type('Test User');
    cy.get('input#email').type('testuser' + Date.now() + '@example.com');
    cy.get('input#password').type('Test@1234');
    cy.get('input#confirmPassword').type('Test@1234');
    cy.get('input[type=radio][value=student]').check();
    // cy.get('input#terms').check();
    cy.get('button[type=submit]').contains('Create Account').click();
    // Assert successful registration (update selector/message as needed)
    cy.contains('Create account').should('not.exist');
  });
}); 