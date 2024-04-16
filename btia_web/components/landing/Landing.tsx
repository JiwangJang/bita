"use client";

import Image from "next/image";
import LandingButton from "./LandingButton";
import LandingImage from "@/public/image/landing-image.png";
import { useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import CodeForm from "./codeForm";

const Landing = () => {
    const router = useRouter();
    const landingMentRef = useRef<HTMLParagraphElement>(null);
    const buttonsRef = useRef<HTMLDivElement>(null);

    const modalOn = () => {
        const modal = document.querySelector(".modal-back");
        if (!modal) return;
        modal.classList.add("active");
        document.body.style.overflow = "hidden";
    };
    const manualClickEvent = () => router.push("/manual");

    useEffect(() => {
        if (!landingMentRef.current || !buttonsRef.current) return;
        landingMentRef.current.classList.add("active");
        buttonsRef.current.classList.add("active");
    }, [router]);

    return (
        <>
            {/* 전체컨테이너 */}
            <div className="w-full flex gap-[24px]">
                <div className="flex-1">
                    <p
                        className="font-[900] leading-[1.1em] text-[100px] translate-y-[15px] opacity-0 landing-ment"
                        ref={landingMentRef}
                    >
                        공무원의
                        <br />
                        공무원에 의한
                        <br />
                        공무원을 위한
                        <br />
                        사진저장서비스
                    </p>
                    <div
                        className="flex gap-[20px] mt-[12px] translate-y-[15px] opacity-0 landing-button"
                        ref={buttonsRef}
                    >
                        <LandingButton content="사용법 알아보기" isGhost={true} clickEvent={manualClickEvent} />
                        <LandingButton content="내사진 보기" isGhost={false} clickEvent={modalOn} />
                    </div>
                </div>
                <div className="flex-1 relative">
                    <div className="relative h-full max-w-[528px] max-h-[430px] rotate-[12deg] translate-x-[40px] landing-image">
                        <Image src={LandingImage} fill sizes="100%" alt="랜딩페이지 이미지"></Image>
                    </div>
                    {/* 그림자 */}
                    <div className="image-shadow"></div>
                </div>
            </div>
            <CodeForm />
        </>
    );
};

export default Landing;
