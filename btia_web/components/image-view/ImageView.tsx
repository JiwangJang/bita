"use client";

import { useEffect, useState } from "react";
import ImageSkeleton from "./ImageSkeleton";
import ImageDashboard from "./ImageDashboard";
import { useSearchParams } from "next/navigation";

export interface ImageInfo {
    [key: string]: string;
    user_code: string;
    created_at: string;
    image_path: string;
}

export default function ImageView() {
    const [infoData, setInfoData] = useState<ImageInfo[] | null>(null);
    const userCode = useSearchParams().get("userCode");
    useEffect(() => {
        const localUserCode = localStorage.getItem("btia_user_code");
        if (!localUserCode && !userCode) {
            // 코드입력창 띄워주기
            return alert("코드부터 입력하시길");
        }

        if (userCode) {
            getImageInfo(userCode).then((result) => setInfoData(result));
            return;
        }

        if (localUserCode) {
            getImageInfo(localUserCode).then((result) => setInfoData(result));
            return;
        }
    }, [userCode]);

    return (
        <div className='max-w-[1200px] m-auto py-[36px]'>
            <p className='text-[80px] font-[900] mb-[8px]'>지금까지 업로드한 사진들</p>
            <p className='text-[40px]'>업로드 후 7일뒤 자동 삭제됩니다</p>
            <div className='mt-[28px]'>{infoData ? <ImageDashboard infoData={infoData} /> : <ImageSkeleton />}</div>
        </div>
    );
}

async function getImageInfo(userCode: string) {
    const data = await fetch(`/image-info?userCode=${userCode}`);
    await new Promise((resolve, rejects) => {
        setTimeout(() => resolve(true), 1000);
    });
    const json = await data.json();
    return json;
}
