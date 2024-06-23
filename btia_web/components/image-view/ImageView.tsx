"use client";

import { Dispatch, MouseEvent, SetStateAction, useEffect, useRef, useState } from "react";
import ImageSkeleton from "./ImageSkeleton";
import ImageDashboard from "./ImageDashboard";
import SelectDownload from "./SelectDownload";
import CodeForm from "../landing/codeForm";
import { useSearchParams } from "next/navigation";
import JSZip from "jszip";
import { saveAs } from "file-saver";

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

export default function mageView({ cookieUserCode }: { cookieUserCode: string }) {
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

        // 사용자 접속 체크
        const logDate = localStorage.getItem("log");
        const today = new Date();
        const docId = `${today.getFullYear()}-${today.getMonth() + 1}-${today.getDate()}`;
        // 날짜가 같으면 page_view만 올라감
        const isFirstAccess = !(Number(logDate) === today.getDate());

        fetch(`/logging?docId=${docId}&isFirstAccess=${isFirstAccess}`)
            .then((res) => res.json())
            .then((result) => {
                if (result.success) {
                    localStorage.setItem("log", String(today.getDate()));
                }
            });
    }, [userCode, cookieUserCode]);

    const checkCounter = (e: MouseEvent) => {
        const target = e.target;
        if (!(target instanceof HTMLElement)) return;
        if (target.classList.contains("check-circle") || target.classList.contains("user-image")) {
            target instanceof HTMLDivElement
                ? target.classList.toggle("checked")
                : (target.previousSibling as HTMLDivElement).classList.toggle("checked");
            const checkCount = document.querySelectorAll(".check-circle.checked").length;
            setCheckCount(checkCount);
        }
    };
    const imageDownload = async (
        setDownload: Dispatch<SetStateAction<boolean>>,
        imgElems: NodeListOf<HTMLImageElement>
    ) => {
        setDownload(true);
        const ArrayImgElems = [...imgElems];
        const canvas = document.createElement("canvas");
        const a = document.createElement("a");
        const ctx = canvas.getContext("2d");

        const base64Images = ArrayImgElems.map((imgElem) => {
            canvas.width = imgElem.naturalWidth;
            canvas.height = imgElem.naturalHeight;
            ctx?.drawImage(imgElem, 0, 0);
            return canvas.toDataURL("image/jpeg");
        });

        if (confirm("압축파일로 다운받으시겠습니까? 취소를 누르시면 개별파일로 다운받아집니다.")) {
            // 압축파일로
            const zip = new JSZip();
            base64Images.forEach((base64: string, index: number) => {
                const e = base64.split(",")[1];
                zip.file(`${index}.jpg`, e, { base64: true });
            });

            const zipFile = await zip.generateAsync({ type: "blob" });
            saveAs(zipFile, `선택한사진.zip`);
        } else {
            // 그냥 생으로
            base64Images.forEach((base64: string, index: number) => {
                a.href = base64;
                a.download = `${index + 1}`;
                a.click();
            });
        }

        const imgPaths = ArrayImgElems.map((elem) => elem.getAttribute("data-image-path"));
        if (infoData) {
            const newInfodata = infoData.reduce((acc: any, cur) => {
                const oldCur = cur[1] as any;
                const newCur = oldCur.filter((path: string) => imgPaths.every((seletedPath) => path !== seletedPath));
                acc.push([cur[0], newCur]);
                return acc;
            }, []);
            setInfoData(newInfodata);
            fetch("/delete", {
                method: "POST",
                body: JSON.stringify(imgPaths),
            });
        }

        setDownload(false);
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
                        <p className="xl:text-[32px] sm:text-[2.5vw]">다운 즉시 서버에서 삭제됩니다</p>
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
                            <ImageDashboard
                                infoData={infoData}
                                checkCounter={checkCounter}
                                imageDownload={imageDownload}
                            />
                        ) : (
                            <ImageSkeleton />
                        )}
                    </div>
                    <SelectDownload count={checkCount} imageDownload={imageDownload} />
                    {codeFormOn && <CodeForm availableClose={false} setUserCode={setUserCode} />}
                </>
            )}
        </div>
    );
}
