"use client";

const Footer = () => {
    return (
        <div className="w-full xl:p-0 px-[20px] xl:text-[20px] text-[16px] bg-black text-white">
            <div className="max-w-[1200px] m-auto xl:py-[24px] py-[20px] developer-info flex flex-col gap-[4px]">
                <p>
                    <span>
                        <i>만</i>
                        <i>든</i>
                        <i>이</i>
                    </span>
                    : 장지왕
                </p>
                <p>
                    <span>
                        <i>소</i>
                        <i>속</i>
                    </span>
                    : 전라남도 여수시 문화산업국 에너지정책과
                </p>
                <p>
                    <span>
                        <i>개</i>
                        <i>발</i>
                        <i>기</i>
                        <i>간</i>
                    </span>
                    : 2주
                </p>
            </div>
        </div>
    );
};

export default Footer;
