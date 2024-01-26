import { Routes, Route, Navigate } from "react-router-dom";

import AdminLayout from "./layouts/admin";
import AuthLayout from "./layouts/auth";

const App = () => {
  return (
    <Routes>
      <Route path="auth/*" element={<AuthLayout />} />
      <Route path="super-admin/*" element={<AdminLayout />} />
      <Route path="station-admin/*" element={<AdminLayout />} />
      <Route
        path="/"
        element={
          localStorage.getItem("persist") ? (
            localStorage.getItem("role") === "SUPER_ADMIN" ? (
              <Navigate to="/super-admin/dashboard" replace />
            ) : (
              <Navigate to="/station-admin/dashboard" replace />
            )
          ) : (
            <Navigate to="/auth" replace />
          )
        }
      />
    </Routes>
  );
};
export default App;
