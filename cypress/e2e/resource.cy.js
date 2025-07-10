describe('Resource Upload', () => {
  beforeEach(() => {
    cy.visit('/login');
    cy.get('input#email').type('priyakumari@gmail.com');
    cy.get('input#password').type('user@123');
    cy.get('button[type=submit]').click();
    cy.visit('/resources');
  });

  it('uploads a resource file', () => {
    cy.get('button').contains('Upload Resource').click();
    cy.get('input[type=file]').attachFile('testfile.pdf'); // requires cypress-file-upload plugin
    cy.get('textarea[placeholder="Describe your file..."]').type('Test PDF upload');
    cy.get('button').contains('Upload File').click();
    cy.contains('Upload successful').should('be.visible');
  });
}); 