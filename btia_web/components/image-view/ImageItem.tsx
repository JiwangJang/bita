"use client";

import Image from "next/image";

function ImageItem({ imagePath }: { imagePath: string }) {
    const S3_ROOT = "https://waterfacilitybucket.s3.ap-northeast-2.amazonaws.com/";

    return (
        <div className="bg-gray-100 max-h-[384px] h-[30vw] relative dashboard-image-item">
            <div
                className="absolute top-[20px] right-[20px] w-[54px] h-[54px] z-10 rounded-full cursor-pointer check-circle"
                data-image-path={imagePath}
            ></div>
            <Image
                src={`${S3_ROOT}${imagePath}`}
                fill
                sizes="100%"
                alt="사용자가 올린 이미지"
                style={{ objectFit: "cover" }}
            ></Image>
        </div>
    );
}

export default ImageItem;
