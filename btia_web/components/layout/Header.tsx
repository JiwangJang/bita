"use client";

import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import Logo from "@/public/image/logo.svg";

export default function Header() {
    const pathname = usePathname();
    return (
        <div className="h-[100px] bg-black w-full text-white">
            <div className="h-full max-w-[1200px] flex justify-between items-center m-auto">
                <div className="h-[80px] w-[190px] relative">
                    <Link href={"/"}>
                        <Image src={Logo} fill sizes="100%" alt="로고"></Image>
                    </Link>
                </div>
                <nav className="flex gap-[20px] text-[28px]">
                    <span className={`nav-item ${pathname === "/manual" ? "active" : ""}`}>
                        <Link href={"/manual"}>사용방법</Link>
                    </span>
                    <span className={`nav-item ${pathname === "/introduce" ? "active" : ""}`}>
                        <Link href={"/introduce"}>서비스소개</Link>
                    </span>
                </nav>
            </div>
        </div>
    );
}
