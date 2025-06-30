import { Outlet } from "react-router-dom";
import { SidebarProvider, SidebarInset } from "@/components/ui/sidebar";
import { AppSidebar } from "./AppSidebar";
import Header from "./Header";
import { useState } from "react";

const Layout = () => {
  const [search, setSearch] = useState("");
  return (
    <SidebarProvider>
      <div className="min-h-screen flex w-full">
        <AppSidebar />
        <SidebarInset>
          <Header search={search} setSearch={setSearch} />
          <main className="flex-1 p-4 md:p-6">
            <Outlet context={{ search }} />
          </main>
        </SidebarInset>
      </div>
    </SidebarProvider>
  );
};

export default Layout;
