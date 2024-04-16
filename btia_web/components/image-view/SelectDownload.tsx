"use client";

import JSZip from "jszip";
import { useState } from "react";
import { saveAs } from "file-saver";

function SelectDownload({ count }: { count: number }) {
    const [download, setDownload] = useState<boolean>(false);

    const imageDownload = async () => {
        const selectedElems: NodeListOf<HTMLDivElement> = document.querySelectorAll(".check-circle.checked");
        const selected = [...selectedElems].map((elem) => elem.getAttribute("data-image-path"));
        setDownload(true);
        const imagePromises = selected.map(async (imagePath) => {
            const fetchData = await fetch(`https://waterfacilitybucket.s3.ap-northeast-2.amazonaws.com/${imagePath}`);
            const blob = await fetchData.blob();
            return blob;
        });
        const imagesBlobs = await Promise.all(imagePromises);
        if (confirm("압축파일로 다운받으시겠습니까?")) {
            // 압축파일로
            const zip = new JSZip();
            imagesBlobs.forEach((imageBlob, index) => {
                zip.file(`선택사진-${index}.jpg`, imageBlob);
            });
            const zipFile = await zip.generateAsync({ type: "blob" });
            saveAs(zipFile, `선택사진.zip`);
        } else {
            // 그냥 생으로
            const objectUrls = imagesBlobs.map((blob) => URL.createObjectURL(blob));
            const downloadA = document.createElement("a");

            objectUrls.forEach((objectUrl, index) => {
                downloadA.href = objectUrl;
                downloadA.download = String(index + 1);
                downloadA.click();
            });
        }

        selectedElems.forEach((elem: HTMLDivElement) => elem.click());
        setDownload(false);
    };

    return (
        <div
            className={`fixed w-full bg-[#FFFFFF] left-0 z-[11] ${count > 0 ? "bottom-[0%]" : "bottom-[-40%]"}`}
            style={{
                transition: "all 0.8s ease-in-out",
            }}
        >
            <div className="max-w-[1200px] w-full m-auto flex py-[24px] font-[700] items-center justify-between">
                <p className="text-[40px]">선택하신 사진 : {count}장</p>
                <div
                    className="px-[28px] py-[16px] bg-[#00A3FF] text-white rounded-full text-[24px] fill-btn"
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
