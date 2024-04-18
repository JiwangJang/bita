"use client";

import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import Logo from "@/public/image/logo.svg";

export default function Header() {
    const pathname = usePathname();
    return (
        <div className="xl:h-[100px] h-[7vw] min-h-[60px] bg-black w-full text-white">
            <div className="h-full max-w-[1200px] flex justify-between items-center m-auto xl:px-[0px] px-[20px]">
                <div className="min-w-[80px] min-h-[40px] w-[10vw] h-[5vw] max-w-[160px] max-h-[80px] relative">
                    <Link href={"/"}>
                        <Image src={Logo} fill sizes="100%" alt="로고"></Image>
                    </Link>
                </div>
                <nav className="flex xl:gap-[20px] xl:text-[28px] gap-[1.5vw] text-[20px]">
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
