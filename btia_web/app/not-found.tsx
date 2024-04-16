import Link from "next/link";

function NotFound() {
    return (
        <div className="h-[calc(100vh-100px)] flex justify-center items-center">
            <div className="flex items-center flex-col">
                <p className="font-[900] text-[44px] mb-[4px]">지금 찾으시는 페이지는 없는 페이지입니다</p>
                <Link href={"/"}>
                    <div className="w-fit text-[24px] py-[4px] px-[20px] rounded-full cursor-pointer fill-btn">
                        홈페이지로 가기
                    </div>
                </Link>
            </div>
        </div>
    );
}

export default NotFound;
