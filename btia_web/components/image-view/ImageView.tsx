"use client";

import { Suspense, useEffect, useState } from "react";
import ImageSkeleton from "./ImageSkeleton";
import LoadingImage from "./LoadingImage";

export default function ImageView() {
    const [userCode, setUserCode] = useState("");
    const [loading, setLoading] = useState(false);
    useEffect(() => {
        const saved = localStorage.getItem("btia_user_code");
        if (saved !== null) setUserCode(saved);
    }, []);

    return (
        <div className="max-w-[1200px] m-auto py-[36px]">
            <p className="text-[80px] font-[900] mb-[8px]">지금까지 업로드한 사진들</p>
            <p className="text-[40px]">업로드 후 7일뒤 자동 삭제됩니다</p>
            <div className="mt-[28px]">
                <Suspense fallback={<ImageSkeleton />}>
                    <LoadingImage />
                </Suspense>
            </div>
        </div>
    );
}
