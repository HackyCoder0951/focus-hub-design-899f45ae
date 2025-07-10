describe('Q&A Flow', () => {
  beforeEach(() => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    cy.visit('/app/qa');
  });

  it('posts a new question', () => {
    cy.contains('Ask Question', { timeout: 10000 }).should('be.visible').click();
    cy.get('input[placeholder="What\'s your question? Be specific."]').type('How do I use Cypress?');
    cy.get('textarea[placeholder="Provide more context about your question..."]').type('I want to automate my tests.');
    cy.get('button').contains('Post Question').click();
    cy.contains('Your question has been published successfully.').should('be.visible');
  });
}); 