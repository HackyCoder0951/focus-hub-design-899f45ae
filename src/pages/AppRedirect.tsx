import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";

const AppRedirect = () => {
  const { isAdmin, loading } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    if (loading) return;
    if (isAdmin) {
      navigate("/app/admin", { replace: true });
    } else {
      navigate("/app", { replace: true }); // Change to /app/feed if that's your feed route
    }
  }, [isAdmin, loading, navigate]);

  return null;
};

export default AppRedirect; 