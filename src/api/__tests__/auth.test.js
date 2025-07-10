const request = require('supertest');
let app;
beforeAll(async () => {
  app = (await import('../server.js')).default;
});

describe('Auth API', () => {
  it('should not register with existing email', async () => {
    const res = await request(app)
      .post('/api/register')
      .send({ email: 'test@example.com', password: '123456' });
    expect(res.statusCode).toBe(400);
    expect(res.body.error).toMatch(/already in use/i);
  });
});

export default app;
