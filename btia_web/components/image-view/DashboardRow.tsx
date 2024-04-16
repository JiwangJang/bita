"use client";

import { useState } from "react";
import { ImageInfo } from "./ImageView";
import ImageItem from "./ImageItem";

function DashboardRow({ data }: { data: ImageInfo }) {
    const [download, setDownload] = useState(false);
    const date = new Date(data[0]);
    const YEAR = date.getFullYear();
    const MONTH = date.getMonth() + 1;
    const DATE = date.getDate();
    const images = data[1];

    const imageDownload = async () => {
        setDownload(true);
        await new Promise((resolve, reject) => {
            setTimeout(() => {
                resolve(true);
            }, 1000);
        });
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
