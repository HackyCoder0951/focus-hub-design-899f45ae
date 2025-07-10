describe('Commenting Flow', () => {
  beforeEach(() => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    cy.url().should('include', '/feed');
  });

  it('adds a comment to the first post', () => {
    cy.get('[data-cy=post-card]').first().within(() => {
      cy.get('input[placeholder="Add a comment..."]').type('This is a test comment!');
      cy.get('button').contains('Post').click();
      cy.contains('This is a test comment!').should('be.visible');
    });
  });
}); 