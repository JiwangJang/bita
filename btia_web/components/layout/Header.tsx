"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

export default function Header() {
    const pathname = usePathname();
    return (
        <div className='h-[100px] bg-black w-full text-white'>
            <div className='h-full max-w-[1200px] flex justify-between items-center m-auto'>
                <div className='h-[80px] w-[150px] bg-red-300'>로고자리</div>
                <nav className='flex gap-[20px] text-[28px]'>
                    <span className={`nav-item ${pathname === "/manual" ? "active" : ""}`}>
                        <Link href={"/manual"}>사용방법</Link>
                    </span>
                    <span className={`nav-item ${pathname === "/about" ? "active" : ""}`}>
                        <Link href={"/about"}>서비스소개</Link>
                    </span>
                    <span className={`nav-item ${pathname === "/contact" ? "active" : ""}`}>
                        <Link href={"/contact"}>문의하기</Link>
                    </span>
                </nav>
            </div>
        </div>
    );
}
