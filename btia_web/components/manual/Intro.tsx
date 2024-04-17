"use client";

import { useEffect, useRef } from "react";

function Intro() {
    const ment = useRef<HTMLDivElement>(null);
    const blurCircle = useRef<HTMLDivElement>(null);

    useEffect(() => {
        const bc = blurCircle.current;
        const mc = ment.current;
        if (!bc || !mc) return;

        setTimeout(() => (bc.style.opacity = "1"), 500);
        setTimeout(() => {
            mc.style.opacity = "1";
            mc.style.transform = "translateY(0)";
        }, 1500);

        const [qm1, qm2, qm3, qm4, qm5] = document.querySelectorAll(".qm");

        setTimeout(() => {
            qm1.classList.add("active");
            qm2.classList.add("active");
            qm3.classList.add("active");
            qm4.classList.add("active");
            qm5.classList.add("active");
        }, 2000);
    }, []);

    return (
        <div className="h-[100vh] flex justify-center items-center relative intro">
            <p
                className="text-white text-[100px] font-[900]"
                ref={ment}
                style={{
                    opacity: 0,
                    transform: "translateY(20px)",
                    transition: "all 1s",
                }}
            >
                어떻게 사용하지?
            </p>
            <div
                className="absolute w-[60vw] h-[25vw] bg-primary rounded-[100%] -z-10 blur-[120px]"
                style={{
                    opacity: 0,
                    transition: "all 1s",
                }}
                ref={blurCircle}
            ></div>
            <div className="absolute qm qm-1"></div>
            <div className="absolute qm qm-2"></div>
            <div className="absolute qm qm-3"></div>
            <div className="absolute qm qm-4"></div>
            <div className="absolute qm qm-5"></div>
        </div>
    );
}

export default Intro;
