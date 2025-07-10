describe('Profile Update', () => {
  beforeEach(() => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    cy.visit('/profile');
  });

  it('updates profile info', () => {
    cy.contains('Edit Profile').click();
    cy.get('input[name="full_name"]').clear().type('Updated Name');
    cy.get('button').contains('Save Changes').click();
    cy.contains('Updated Name').should('be.visible');
  });
}); 