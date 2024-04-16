"use client";

import { useState } from "react";
import { ImageInfo } from "./ImageView";
import ImageItem from "./ImageItem";
import JSZip from "jszip";
import { saveAs } from "file-saver";
import { randomUUID } from "crypto";

function DashboardRow({ data }: { data: ImageInfo }) {
    const [download, setDownload] = useState(false);
    const date = new Date(data[0]);
    const YEAR = date.getFullYear();
    const MONTH = date.getMonth() + 1;
    const DATE = date.getDate();
    const images = data[1];

    const imageDownload = async () => {
        setDownload(true);

        const imageParent: HTMLDivElement = document.getElementById(data[0]) as HTMLDivElement;
        const images = imageParent.querySelectorAll("img");
        const canvas = document.createElement("canvas");
        const a = document.createElement("a");
        const ctx = canvas.getContext("2d");

        const base64Images = [...images].map((imgElem) => {
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
                zip.file(`${YEAR}년 ${MONTH}월 ${DATE}일-${index}.jpg`, e, { base64: true });
            });

            const zipFile = await zip.generateAsync({ type: "blob" });
            saveAs(zipFile, `${YEAR}년 ${MONTH}월 ${DATE}일 사진.zip`);
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
        <div className="mt-[40px]">
            <div className="font-[700] flex gap-[12px] items-center">
                <p className="text-[48px]">{`${YEAR}년 ${MONTH}월 ${DATE}일`}</p>
                <div
                    className={`text-[20px] py-[8px] px-[16px] rounded-full  cursor-pointer relative ghost-btn ${
                        download ? "working" : ""
                    }`}
                    onClick={imageDownload}
                >
                    {download ? "다운로드중.." : "전체 다운로드"}
                </div>
            </div>
            <div className={`grid grid-cols-3 gap-[12px] mt-[12px]`} id={data[0]}>
                {Array.isArray(images) && images.map((image: string) => <ImageItem key={image} imagePath={image} />)}
            </div>
        </div>
    );
}

export default DashboardRow;
