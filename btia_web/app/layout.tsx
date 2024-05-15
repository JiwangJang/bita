import type { Metadata } from "next";
import "./globals.css";
import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";
import { Analytics } from "@vercel/analytics/react";

export const metadata: Metadata = {
    title: "출장사진저장소",
    description: "출장사진을 이젠 서버에 저장하세요!",
    keywords: "출장사진, 사진저장",
};

export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode;
}>) {
    return (
        <html lang="en">
            <head>
                <link rel="icon" href="/image/manual/app-icon.png" />
                <link rel="apple-touch-icon" href="/image/manual/app-icon.png" />
            </head>
            <body className="bg-white">
                <Header />
                {children}
                <Footer />
                <Analytics />
            </body>
        </html>
    );
}
