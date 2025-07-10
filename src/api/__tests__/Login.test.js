import { render, screen, fireEvent } from '@testing-library/react';
import Login from '../Login';

test('shows error on invalid login', () => {
  render(<Login />);
  fireEvent.change(screen.getByLabelText(/email/i), { target: { value: 'wrong@example.com' } });
  fireEvent.change(screen.getByLabelText(/password/i), { target: { value: 'badpass' } });
  fireEvent.click(screen.getByText(/login/i));
  expect(screen.getByText(/invalid credentials/i)).toBeInTheDocument();
});
