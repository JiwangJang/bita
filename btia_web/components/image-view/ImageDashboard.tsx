"use client";

import { Dispatch, MouseEvent, SetStateAction } from "react";
import DashboardRow from "./DashboardRow";
import { ImageInfo } from "./ImageView";

export default function ImageDashboard({
    infoData,
    checkCounter,
    imageDownload,
}: {
    infoData: ImageInfo[];
    checkCounter: (e: MouseEvent) => void;
    imageDownload: (setDownload: Dispatch<SetStateAction<boolean>>, imgElems: NodeListOf<HTMLImageElement>) => void;
}) {
    return (
        <div onClick={checkCounter}>
            {infoData.length > 0 ? (
                infoData.map((data, key) => <DashboardRow key={key} data={data} imageDownload={imageDownload} />)
            ) : (
                <div className="text-[32px] font-[700]">현재 업로드하신 사진이 없습니다. 우선 업로드부터 해주세요</div>
            )}
        </div>
    );
}
