describe('Registration Flow', () => {
  it('registers a new user', () => {
    cy.visit('/register');
    cy.get('input#name').type('Test User');
    cy.get('input#email').type('testuser' + Date.now() + '@example.com');
    cy.get('input#password').type('Test@1234');
    cy.get('input#confirmPassword').type('Test@1234');
    cy.get('input[type=radio][value=student]').check();
    // Check the terms using the label, since Checkbox is custom
    cy.get('label[for="terms"]').click();
    cy.get('button[type=submit]').should('not.be.disabled').click();
    // Optionally, assert successful registration
    cy.contains('Create account').should('not.exist');
  });
}); 