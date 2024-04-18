"use client";

import JSZip from "jszip";
import { useState } from "react";
import { saveAs } from "file-saver";

function SelectDownload({ count }: { count: number }) {
    const [download, setDownload] = useState<boolean>(false);

    const imageDownload = async () => {
        setDownload(true);
        const selectedImgs: NodeListOf<HTMLImageElement> = document.querySelectorAll(".check-circle.checked~img");
        const canvas = document.createElement("canvas");
        const a = document.createElement("a");
        const ctx = canvas.getContext("2d");

        const base64Images = [...selectedImgs].map((imgElem) => {
            canvas.width = imgElem.naturalWidth;
            canvas.height = imgElem.naturalHeight;
            ctx?.drawImage(imgElem, 0, 0);
            return canvas.toDataURL("image/jpeg");
        });

        if (confirm("압축파일로 다운받으시겠습니까?")) {
            // 압축파일로
            const zip = new JSZip();
            base64Images.forEach((base64: string, index: number) => {
                const e = base64.split(",")[1];
                zip.file(`${index}.jpg`, e, { base64: true });
            });

            const zipFile = await zip.generateAsync({ type: "blob" });
            saveAs(zipFile, `선택한사진.zip`);
        } else {
            // 그냥 생으로
            base64Images.forEach((base64: string, index: number) => {
                a.href = base64;
                a.download = `${index + 1}`;
                a.click();
            });
        }

        setDownload(false);
    };

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
                    onClick={imageDownload}
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
