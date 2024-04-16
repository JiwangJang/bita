"use client";

function SelectDownload({ count }: { count: number }) {
    return (
        <div
            className={`fixed w-full bg-[#FFFFFF] left-0 z-[11] ${count > 0 ? "bottom-[0%]" : "bottom-[-100%]"}`}
            style={{
                transition: "all 0.8s ease-in-out",
            }}
        >
            <div className="max-w-[1200px] w-full m-auto flex py-[24px] font-[700] items-center justify-between">
                <p className="text-[40px]">선택하신 사진 : {count}장</p>
                <div className="px-[28px] py-[16px] bg-[#00A3FF] text-white rounded-full text-[24px] fill-btn">
                    선택한 사진 다운로드
                </div>
            </div>
        </div>
    );
}

export default SelectDownload;
