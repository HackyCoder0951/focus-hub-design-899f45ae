import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ThemeProvider } from "@/components/theme-provider";
import { AuthProvider } from "@/contexts/AuthContext";
import { ProtectedRoute } from "@/components/ProtectedRoute";
import Index from "./pages/Index";
import Login from "./pages/Login";
import Register from "./pages/Register";
import ForgotPassword from "./pages/ForgotPassword";
import Feed from "./pages/Feed";
import Profile from "./pages/Profile";
import QandA from "./pages/QandA";
import Resources from "./pages/Resources";
import Chat from "./pages/Chat";
import Settings from "./pages/Settings";
import AdminDashboard from "./pages/AdminDashboard";
import NotFound from "./pages/NotFound";
import Layout from "./components/Layout";
import AdminWelcome from "./pages/AdminWelcome";
import AppRedirect from "./pages/AppRedirect";
import FollowersList from "./pages/FollowersList";
import FollowingList from "./pages/FollowingList";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <ThemeProvider defaultTheme="system" storageKey="focus-ui-theme">
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <AuthProvider>
            <Routes>
              <Route path="/" element={<Index />} />
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route path="/forgot-password" element={<ForgotPassword />} />
              <Route path="/app" element={
                <ProtectedRoute>
                  <Layout />
                </ProtectedRoute>
              }>
                <Route index element={<AppRedirect />} />
                <Route path="feed" element={<Feed />} />
                <Route path="profile" element={<Profile />} />
                <Route path="qa" element={<QandA />} />
                <Route path="resources" element={<Resources />} />
                <Route path="chat" element={<Chat />} />
                <Route path="settings" element={<Settings />} />
                <Route path="admin" element={
                  <ProtectedRoute requireAdmin={true}>
                    <AdminWelcome />
                  </ProtectedRoute>
                } />
                <Route path="AdminDashboard" element={
                  <ProtectedRoute requireAdmin={true}>
                    <AdminDashboard />
                  </ProtectedRoute>
                } />
                <Route path="followers" element={<FollowersList />} />
                <Route path="following" element={<FollowingList />} />
              </Route>
              <Route path="*" element={<NotFound />} />
            </Routes>
          </AuthProvider>
        </BrowserRouter>
      </TooltipProvider>
    </ThemeProvider>
  </QueryClientProvider>
);

export default App;
