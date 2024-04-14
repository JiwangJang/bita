"use client";

import Image from "next/image";
import LandingButton from "./LandingButton";
import LandingImage from "@/public/image/landing-image.png";
import { useEffect, useRef } from "react";
import { useRouter } from "next/navigation";

const Landing = () => {
    const landingMentRef = useRef<HTMLParagraphElement>(null);
    const buttonsRef = useRef<HTMLDivElement>(null);
    const modalRef = useRef<HTMLDivElement>(null);
    const router = useRouter();

    const manualClickEvent = () => router.push("/manual");
    const myPictureClickEvent = () => {
        if (!modalRef.current) return;
        modalRef.current.classList.add("active");
    };
    useEffect(() => {
        if (!landingMentRef.current || !buttonsRef.current) return;
        landingMentRef.current.classList.add("active");
        buttonsRef.current.classList.add("active");
    }, []);

    return (
        <>
            {/* 전체컨테이너 */}
            <div className='w-full flex gap-[24px]'>
                <div className='flex-1'>
                    <p
                        className='font-[900] leading-[1.1em] text-[100px] translate-y-[15px] opacity-0 landing-ment'
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
                        className='flex gap-[20px] mt-[12px] translate-y-[15px] opacity-0 landing-button'
                        ref={buttonsRef}
                    >
                        <LandingButton content='사용법 알아보기' isGhost={true} clickEvent={manualClickEvent} />
                        <LandingButton content='내사진 보기' isGhost={false} clickEvent={myPictureClickEvent} />
                    </div>
                </div>
                <div className='flex-1 relative'>
                    <div className='relative h-full max-w-[528px] max-h-[430px] rotate-[12deg] translate-x-[40px] landing-image'>
                        <Image src={LandingImage} fill sizes='100%' alt='랜딩페이지 이미지'></Image>
                    </div>
                    {/* 그림자 */}
                    <div className='image-shadow'></div>
                </div>
            </div>
            <div className='fixed bg-[#00000050] top-0 left-0 w-[100vw] h-[100vh] flex justify-center items-center cursor-pointer'>
                <div className='p-[36px] flex-col bg-[#FFFFFF] rounded-[10px] cursor-default'>
                    <p className='font-[900] text-[64px] mb-[6px]'>코드를 입력해주세요</p>
                    <p className='text-[32px] font-[700] mb-[4px]'>나의코드</p>
                    <div className='flex gap-[4px] items-center mb-[8px]'>
                        <input type='text' />
                        <div className='w-[24px] h-[2px] bg-black'></div>
                        <input type='text' />
                    </div>
                    <div className='py-[16px] flex justify-center bg-primary rounded-[10px] text-[#FFFFFF] font-[700] text-[32px] cursor-pointer mb-[4px] fill-btn'>
                        입력
                    </div>
                    <p className='text-[20px]'>앱 우측하단 열쇠아이콘 클릭하시면, 나의 코드를 보실수 있습니다</p>
                </div>
            </div>
        </>
    );
};

export default Landing;
