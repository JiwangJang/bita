import Image from "next/image";

function Manual() {
    return (
        <div className="py-[120px] max-w-[1200px] m-auto grid grid-cols-2 gap-[12px]">
            <div className="p-[36px] bg-[#FFFFFF] max-h-[730px] h-[38vw] flex flex-col rounded-[10px]">
                <p className="font-[900] text-[100px]">1</p>
                <p className="text-[56px]">어플을 다운받아주세요</p>
                <div className="flex-1 flex justify-center items-center">
                    <div className="relative h-full w-full max-h-[290px] max-w-[290px] shadow-lg rounded-[10px] overflow-hidden">
                        <Image src={"/image/manual/app-icon.png"} fill sizes="100%" alt="매뉴얼사진"></Image>
                    </div>
                </div>
                <p>스토어에 &quot;출장사진저장소&quot;라고 검색하시면 나와요!</p>
            </div>
            <div className="p-[36px] bg-[#FFFFFF] max-h-[730px] h-[38vw] flex flex-col rounded-[10px]">
                <p className="font-[900] text-[100px]">2</p>
                <p className="text-[56px]">찍고, 업로드해주세요</p>
                <div className="flex-1 flex justify-center items-center">
                    <div className="relative h-full w-full max-h-[290px] max-w-[290px] ">
                        <Image src={"/image/manual/camera.svg"} fill sizes="100%" alt="매뉴얼사진"></Image>
                    </div>
                </div>
            </div>
            <div className="p-[36px] bg-[#FFFFFF] max-h-[730px] h-[38vw] flex flex-col rounded-[10px]">
                <p className="font-[900] text-[100px]">3</p>
                <p className="text-[56px]">
                    사이트에 접속하셔서 <br /> 내 코드를 입력해주세요
                </p>
                <div className="flex-1 flex justify-center items-center">
                    <div className="relative h-full w-full max-h-[290px] max-w-[290px]">
                        <Image src={"/image/manual/key.svg"} fill sizes="100%" alt="매뉴얼사진"></Image>
                    </div>
                </div>
            </div>
            <div className="p-[36px] bg-[#FFFFFF] max-h-[730px] h-[38vw] flex flex-col rounded-[10px]">
                <p className="font-[900] text-[100px]">4</p>
                <p className="text-[56px]">
                    업로드한 사진을
                    <br />
                    다운받으세요
                </p>
                <div className="flex-1 flex justify-center items-center">
                    <div className="relative h-full w-full max-h-[290px] max-w-[290px]">
                        <Image
                            src={"/image/manual/download.png"}
                            fill
                            sizes="100%"
                            alt="매뉴얼사진"
                            style={{ objectFit: "contain" }}
                        ></Image>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Manual;
