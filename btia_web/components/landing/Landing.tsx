"use client";

import Image from "next/image";
import LandingButton from "./LandingButton";
import LandingImage from "@/public/image/landing-image.png";
import { FormEvent, MouseEvent, useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";

const Landing = () => {
    const [loading, setLoading] = useState(false);
    const router = useRouter();
    const landingMentRef = useRef<HTMLParagraphElement>(null);
    const buttonsRef = useRef<HTMLDivElement>(null);
    const modalRef = useRef<HTMLDivElement>(null);
    const formerCodeRef = useRef<string>("");
    const latterCodeRef = useRef<string>("");
    const secondInputRef = useRef<HTMLInputElement>(null);

    const manualClickEvent = () => router.push("/manual");
    const modalOn = () => {
        if (!modalRef.current) return;
        modalRef.current.classList.add("active");
        document.body.style.overflow = "hidden";
    };
    const modalOff = (e: MouseEvent) => {
        const target = e.target;
        if (!modalRef.current) return;
        if (!(target instanceof HTMLDivElement) || !target.classList.contains("modal-back")) return;
        modalRef.current.classList.remove("active");
        document.body.style.overflow = "";
    };

    const firstInputEvent = (e: FormEvent) => {
        const target = e.target;
        if (!(target instanceof HTMLInputElement)) return;
        if (!secondInputRef.current) return;
        const value = target.value;
        if (value.length === 4) secondInputRef.current.focus();
        if (value.length > 4) {
            target.value = formerCodeRef.current;
            return;
        }
        formerCodeRef.current = value;
    };
    const secondInputEvent = (e: FormEvent) => {
        const target = e.target;
        if (!(target instanceof HTMLInputElement)) return;
        const value = target.value;
        if (value.length > 4) {
            target.value = latterCodeRef.current;
            return;
        }
        latterCodeRef.current = value;
    };

    const verifyCode = async () => {
        if (!formerCodeRef.current || !latterCodeRef.current) return alert("정확히 입력해주세요");
        const former = formerCodeRef.current;
        const latter = latterCodeRef.current;
        if (former.length !== 4 || latter.length !== 4) return alert("정확히 입력해주세요");
        const USERCODE = `${former}-${latter}`;
        setLoading(true);
        const result = await fetch(`/receive-image?userCode=${USERCODE}`);
        const json = await result.json();
        if (json.exist) {
            router.push(`image-view?userCode=${USERCODE}`);
            localStorage.setItem("btia_user_code", USERCODE);
        } else alert("유효한 코드가 아닙니다. 다시 확인해주세요.");
        setLoading(false);
    };
    useEffect(() => {
        if (localStorage.getItem("btia_user_code")) {
            router.push(`/image-view?userCode=${localStorage.getItem("btia_user_code")}`);
        }
        if (!landingMentRef.current || !buttonsRef.current) return;
        landingMentRef.current.classList.add("active");
        buttonsRef.current.classList.add("active");
    }, [router]);

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
                        <LandingButton content='내사진 보기' isGhost={false} clickEvent={modalOn} />
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
            <div
                className='fixed bg-[#00000000] flex invisible top-0 left-0 w-[100vw] h-[100vh] justify-center items-center cursor-pointer transition-all modal-back'
                onClick={modalOff}
                ref={modalRef}
            >
                <div className='p-[36px] flex-col bg-[#FFFFFF] rounded-[10px] cursor-default opacity-0 translate-y-[20px] modal'>
                    <p className='font-[900] text-[64px] mb-[6px]'>코드를 입력해주세요</p>
                    <p className='text-[32px] font-[700] mb-[4px]'>나의코드</p>
                    <div className='flex gap-[4px] items-center mb-[8px]'>
                        <input type='text' onInput={firstInputEvent} />
                        <div className='w-[24px] h-[2px] bg-black'></div>
                        <input
                            type='text'
                            ref={secondInputRef}
                            onKeyDown={(e) => {
                                if (e.key === "Enter") verifyCode();
                            }}
                            onInput={secondInputEvent}
                        />
                    </div>
                    <div
                        className='py-[16px] flex justify-center bg-primary rounded-[10px] text-[#FFFFFF] font-[700] text-[32px] cursor-pointer mb-[4px] fill-btn'
                        onClick={verifyCode}
                    >
                        {loading ? "검증중.." : "입력"}
                    </div>
                    <p className='text-[20px]'>앱 우측하단 열쇠아이콘 클릭하시면, 나의 코드를 보실수 있습니다</p>
                </div>
            </div>
        </>
    );
};

export default Landing;
