"use client";

import { useRouter } from "next/navigation";
import { FormEvent, useRef, useState, MouseEvent, SetStateAction, Dispatch } from "react";
import { ImageInfo } from "../image-view/ImageView";
import { cookies } from "next/headers";

interface Props {
    availableClose?: boolean;
    setUserCode?: Dispatch<SetStateAction<string>>;
}

function CodeForm({ availableClose = true, setUserCode }: Props) {
    const [loading, setLoading] = useState(false);
    const router = useRouter();
    const modalRef = useRef<HTMLDivElement>(null);
    const formerCodeRef = useRef<string>("");
    const latterCodeRef = useRef<string>("");
    const secondInputRef = useRef<HTMLInputElement>(null);

    const modalOff = (e: MouseEvent) => {
        if (!availableClose) return;
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

        document.cookie = `btia_user_code = ${USERCODE}`;
        if (availableClose) {
            router.push(`/image-view`);
        } else {
            if (setUserCode) setUserCode(USERCODE);
        }

        setLoading(false);
    };
    return (
        <div
            className={`fixed bg-[#00000000] flex invisible top-0 left-0 w-[100vw] h-[100vh] justify-center items-center transition-all ${
                availableClose ? "cursor-pointer" : "active"
            } modal-back`}
            onClick={modalOff}
            ref={modalRef}
        >
            <div className="p-[36px] flex-col bg-[#FFFFFF] rounded-[10px] cursor-default opacity-0 translate-y-[20px] modal">
                <p className="font-[900] text-[64px] mb-[6px]">코드를 입력해주세요</p>
                <p className="text-[32px] font-[700] mb-[4px]">나의코드</p>
                <div className="flex gap-[4px] items-center mb-[8px]">
                    <input type="text" onInput={firstInputEvent} />
                    <div className="w-[24px] h-[2px] bg-black"></div>
                    <input
                        type="text"
                        ref={secondInputRef}
                        onKeyDown={(e) => {
                            if (e.key === "Enter") verifyCode();
                        }}
                        onInput={secondInputEvent}
                    />
                </div>
                <div
                    className={`py-[16px] flex justify-center bg-primary rounded-[10px] text-[#FFFFFF] font-[700] text-[32px] cursor-pointer mb-[4px] fill-btn ${
                        loading ? "working" : ""
                    }`}
                    onClick={verifyCode}
                >
                    {loading ? "검증중.." : "입력"}
                </div>
                <p className="text-[20px]">앱 우측하단 열쇠아이콘 클릭하시면, 나의 코드를 보실수 있습니다</p>
            </div>
        </div>
    );
}

export default CodeForm;
