"use client";

import { getImageInfo } from "./getImageInfo";

function LoadingImage() {
    getImageInfo();
    return <div>Enter</div>;
}

export default LoadingImage;
