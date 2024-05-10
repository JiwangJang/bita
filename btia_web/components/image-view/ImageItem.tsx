"use client";

import Image from "next/image";
import { useState } from "react";

function ImageItem({ imagePath }: { imagePath: string }) {
    const [err, setErr] = useState<string | null>(null);
    const cloudFront = "https://de9nqjthi7764.cloudfront.net/";

    return (
        <div className="bg-gray-100 max-h-[384px] h-[30vw] relative dashboard-image-item cursor-pointer">
            <div className="absolute top-[5%] right-[5%] xl:w-[54px] xl:h-[54px] w-[4.5vw] h-[4.5vw] min-h-[36px] min-w-[36px] z-10 rounded-full check-circle"></div>
            <Image
                src={err ? err : `${cloudFront}${imagePath}?noCache`}
                onError={() => setErr("/image/error.png")}
                className="user-image"
                data-image-path={imagePath}
                crossOrigin="anonymous"
                fill
                sizes="100%"
                alt="사용자가 올린 이미지"
                style={{ objectFit: "cover" }}
                placeholder="blur"
                blurDataURL="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUwAAAE7CAYAAAC2SbgmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABhaVRYdFNuaXBNZXRhZGF0YQAAAAAAeyJjbGlwUG9pbnRzIjpbeyJ4IjowLCJ5IjowfSx7IngiOjMzMiwieSI6MH0seyJ4IjozMzIsInkiOjMxNX0seyJ4IjowLCJ5IjozMTV9XX372upHAAAEIUlEQVR4Xu3UsQ2AQAADscD+OwMF/d8AthRlg7u2Pd8AOLj/B+BAMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAEiwQSIBBMgEkyASDABIsEEiAQTIBJMgEgwASLBBIgEEyASTIBIMAGS7QVKDQN10Q4+uAAAAABJRU5ErkJggg=="
            ></Image>
        </div>
    );
}

export default ImageItem;
