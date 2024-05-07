"use client";

import { Dispatch, SetStateAction, useState } from "react";

function SelectDownload({
    count,
    imageDownload,
}: {
    count: number;
    imageDownload: (setDownload: Dispatch<SetStateAction<boolean>>, imgElems: NodeListOf<HTMLImageElement>) => void;
}) {
    const [download, setDownload] = useState<boolean>(false);

    return (
        <div
            className={`fixed w-full xl:p-0 px-[20px] bg-[#FFFFFF] left-0 z-[11] 
            ${count > 0 ? "bottom-[0%]" : "bottom-[-40%]"}`}
            style={{
                transition: "all 0.8s ease-in-out",
            }}
        >
            <div className="max-w-[1200px] w-full m-auto flex xl:py-[24px] py-[2vw] font-[700] items-center justify-between">
                <p className="xl:text-[40px] md:text-[3vw] text-[24px]">선택하신 사진 : {count}장</p>
                <div
                    className="sm:px-[28px] sm:py-[16px] px-[20px] py-[10px] text-white rounded-full sm:text-[24px] text-[18px] fill-btn"
                    onClick={() => {
                        const selectedImages: NodeListOf<HTMLImageElement> =
                            document.querySelectorAll(".check-circle.checked~img");
                        imageDownload(setDownload, selectedImages);
                    }}
                    style={{
                        opacity: download ? "0.4" : "1",
                    }}
                >
                    {download ? "다운중.." : "선택한 사진 다운로드"}
                </div>
            </div>
        </div>
    );
}

export default SelectDownload;
