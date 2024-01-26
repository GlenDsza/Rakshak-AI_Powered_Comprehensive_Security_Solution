import Footer from "@/components/footer/FooterAuthDefault";
import { Routes, Route, Navigate } from "react-router-dom";
import logo from "@/assets/img/logo.png";
import routes from "@/routes";
import FixedPlugin from "@/components/fixedPlugin/FixedPlugin";

export default function Auth() {
  const getRoutes = (routes: RoutesType[]): any => {
    return routes.map((prop, key) => {
      if (prop.layout === "/auth") {
        return (
          <Route path={`/${prop.path}`} element={prop.component} key={key} />
        );
      } else {
        return null;
      }
    });
  };
  document.documentElement.dir = "ltr";
  return (
    <div>
      <div className="h-full min-h-screen w-full !bg-gray-50 dark:!bg-navy-900">
        <FixedPlugin />
        <main>
          <div className="mx-auto flex items-center justify-center py-3">
            <img src={logo} width={65} height={65} alt="Logo" />
            <span className="ml-2 text-3xl font-bold dark:text-white">
              {" "}
              Rakshak (रक्षक)
            </span>
          </div>
          <Routes>
            {getRoutes(routes)}
            <Route path="/" element={<Navigate to="/auth/sign-in" replace />} />
          </Routes>
          <div className="absolute bottom-1">
            <Footer />
          </div>
        </main>
      </div>
    </div>
  );
}
