describe('Profile Update via Settings', () => {
  beforeEach(() => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    cy.visit('/settings');
  });

  it('updates profile info', () => {
    cy.get('input#name').clear().type('Updated Name');
    cy.get('button').contains('Save Changes').click();
    cy.contains('Profile updated').should('be.visible');
  });
}); 