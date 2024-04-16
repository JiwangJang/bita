import Image from "next/image";

function loading() {
    return (
        <div className="fixed top-0 left-0 w-[100vw] h-[100vh] flex justify-center items-center bg-white z-20">
            <Image
                src={"/image/logo-black.svg"}
                width={300}
                height={100}
                style={{ objectFit: "contain" }}
                alt="로딩 로고"
            ></Image>
        </div>
    );
}

export default loading;
