"use client";

import { useState } from "react";
import { ImageInfo } from "./ImageView";
import ImageItem from "./ImageItem";
import JSZip from "jszip";
import { saveAs } from "file-saver";

function DashboardRow({ data }: { data: ImageInfo }) {
    const [download, setDownload] = useState(false);
    const date = new Date(data[0]);
    const YEAR = date.getFullYear();
    const MONTH = date.getMonth() + 1;
    const DATE = date.getDate();
    const images = data[1];

    const imageDownload = async () => {
        setDownload(true);
        if (!Array.isArray(images)) return;
        const imagePromises = images.map(async (imagePath) => {
            const fetchData = await fetch(`https://waterfacilitybucket.s3.ap-northeast-2.amazonaws.com/${imagePath}`);
            const blob = await fetchData.blob();
            return blob;
        });
        const imagesBlobs = await Promise.all(imagePromises);
        if (confirm("압축파일로 다운받으시겠습니까?")) {
            // 압축파일로
            const zip = new JSZip();
            imagesBlobs.forEach((imageBlob, index) => {
                zip.file(`${YEAR}년 ${MONTH}월 ${DATE}일-${index}.jpg`, imageBlob);
            });

            const zipFile = await zip.generateAsync({ type: "blob" });
            saveAs(zipFile, `${YEAR}년 ${MONTH}월 ${DATE}일 사진.zip`);
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
            <div className="grid grid-cols-3 gap-[12px] mt-[12px]">
                {Array.isArray(images) && images.map((image: string) => <ImageItem key={image} imagePath={image} />)}
            </div>
        </div>
    );
}

export default DashboardRow;
