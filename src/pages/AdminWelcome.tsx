const AdminWelcome = () => (
  <div className="flex flex-col items-center justify-center h-full py-20">
    <h1 className="text-3xl font-bold mb-4">Welcome, Admin!</h1>
    <p className="text-lg text-muted-foreground text-center">
      You have successfully signed in as an administrator.<br />
      Use the sidebar to manage the platform.
    </p>
  </div>
);

export default AdminWelcome; 