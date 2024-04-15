"use client";

import { ImageInfo } from "./ImageView";

export default function ImageDashboard({ infoData }: { infoData: ImageInfo[] }) {
    return (
        <div>
            <a
                href='https://waterfacilitybucket.s3.ap-northeast-2.amazonaws.com/btia/behqegu-wnlrilb-1562-6313'
                download
            >
                다운
            </a>
        </div>
    );
}
