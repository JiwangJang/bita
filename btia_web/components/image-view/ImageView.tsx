"use client";

import { MouseEvent, useEffect, useState } from "react";
import ImageSkeleton from "./ImageSkeleton";
import ImageDashboard from "./ImageDashboard";
import SelectDownload from "./SelectDownload";
import CodeForm from "../landing/codeForm";
import { useSearchParams } from "next/navigation";

export type ImageInfo = string[] | string;

/**
 * 유저가 올렸던 사진들을 가져오는 함수
 * @param userCode 유저 코드
 * @returns 날짜별 사진들
 */
async function getImageInfo(userCode: string) {
    const data = await fetch(`/image-info?userCode=${userCode}`);
    await new Promise((resolve, rejects) => {
        setTimeout(() => resolve(true), 1000);
    });
    const json = await data.json();
    return json;
}

export default function ImageView({ cookieUserCode }: { cookieUserCode: string }) {
    const [infoData, setInfoData] = useState<ImageInfo[] | null>(null);
    const [checkCount, setCheckCount] = useState<number>(0);
    const [codeFormOn, setCodeFormOn] = useState<boolean>(false);
    const [userCode, setUserCode] = useState(useSearchParams().get("userCode") ?? "");
    const [err, setErr] = useState<string>("");

    useEffect(() => {
        document.body.style.overflow = "auto";
        if (!cookieUserCode && !userCode) {
            setCodeFormOn(true);
            return;
        } else {
            const MONTH_SECOND = 3600 * 24 * 30;
            document.cookie = `btia_user_code = ${cookieUserCode ?? userCode}; max-age=${MONTH_SECOND}`;

            setCodeFormOn(false);
            getImageInfo(userCode ? userCode : cookieUserCode).then((result) => {
                if (result.success) {
                    setInfoData(result.result);
                } else {
                    setErr(result.err);
                }
            });
        }
    }, [userCode, cookieUserCode]);

    const checkCounter = (e: MouseEvent) => {
        const target = e.target;
        if (!(target instanceof HTMLDivElement)) return;
        if (!target.classList.contains("check-circle")) return;

        target.classList.toggle("checked");
        const checkCount = document.querySelectorAll(".check-circle.checked").length;
        setCheckCount(checkCount);
    };

    return (
        <div className="max-w-[1200px] xl:px-0 px-[20px] m-auto min-h-[calc(100vh-100px)] py-[36px] flex flex-col">
            {err ? (
                <div className=" flex-1 flex flex-col items-center justify-center">
                    <p className="font-[900] text-[44px] mb-[4px]">서버에서 에러발생</p>
                    <div
                        className="text-[24px] py-[4px] px-[20px] rounded-full cursor-pointer fill-btn"
                        onClick={() => {
                            setErr("");
                            getImageInfo(userCode ?? cookieUserCode).then((result) => {
                                if (result.success) {
                                    setInfoData(result.result);
                                } else {
                                    setErr(result.err);
                                }
                            });
                        }}
                    >
                        다시시도
                    </div>
                </div>
            ) : (
                <>
                    <p className="xl:text-[80px] text-[6.5vw] font-[900] sm:mb-[8px] mb-[2px]">
                        지금까지 업로드한 사진들
                    </p>
                    <div className="flex xl:gap-[12px] gap-[1vw] items-center">
                        <p className="xl:text-[32px] sm:text-[2.5vw]">보관기간은 업로드시점부터 일주일입니다</p>
                        <div
                            className="sm:text-[18px] text-[14px] md:px-[12px] md:py-[4px] px-[8px] py-[2px] rounded-full ghost-btn"
                            onClick={() => {
                                setInfoData(null);
                                setCodeFormOn(true);
                            }}
                        >
                            유저코드 변경
                        </div>
                    </div>
                    <div className="xl:mt-[28px] mt-[2vw]">
                        {infoData ? (
                            <ImageDashboard infoData={infoData} checkCounter={checkCounter} />
                        ) : (
                            <ImageSkeleton />
                        )}
                    </div>
                    <SelectDownload count={checkCount} />
                    {codeFormOn && <CodeForm availableClose={false} setUserCode={setUserCode} />}
                </>
            )}
        </div>
    );
}
