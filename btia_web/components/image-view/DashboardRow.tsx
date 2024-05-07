"use client";

import { Dispatch, SetStateAction, useState } from "react";
import { ImageInfo } from "./ImageView";
import ImageItem from "./ImageItem";
import JSZip from "jszip";
import { saveAs } from "file-saver";

function DashboardRow({
    data,
    imageDownload,
}: {
    data: ImageInfo;
    imageDownload: (setDownload: Dispatch<SetStateAction<boolean>>, imgElems: NodeListOf<HTMLImageElement>) => void;
}) {
    const [download, setDownload] = useState(false);
    const date = new Date(data[0]);
    const YEAR = date.getFullYear();
    const MONTH = date.getMonth() + 1;
    const DATE = date.getDate();
    const images = data[1];

    return (
        <div className="xl:mt-[40px] mt-[3vw]">
            <div className="font-[700] flex gap-[12px] items-center">
                <p className="xl:text-[48px] sm:text-[3.5vw] text-[24px]">{`${YEAR}년 ${MONTH}월 ${DATE}일`}</p>
                <div
                    className={`xl:text-[20px]  md:px-[12px] md:py-[4px] px-[8px] py-[2px] font-[500]
                    sm:text-[18px] text-[14px] rounded-full cursor-pointer relative ghost-btn 
                    ${download ? "working" : ""}`}
                    onClick={() => {
                        const imageParent: HTMLDivElement = document.getElementById(data[0]) as HTMLDivElement;
                        const images = imageParent.querySelectorAll("img");
                        imageDownload(setDownload, images);
                    }}
                >
                    {download ? "다운로드중.." : "전체 다운로드"}
                </div>
            </div>
            <div className={`grid grid-cols-3 sm:gap-[12px] gap-[6px] mt-[12px]`} id={data[0]}>
                {Array.isArray(images) && images.map((image: string) => <ImageItem key={image} imagePath={image} />)}
            </div>
        </div>
    );
}

export default DashboardRow;
