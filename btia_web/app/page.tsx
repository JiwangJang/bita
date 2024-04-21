import Landing from "@/components/landing/Landing";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export default function Home({
    searchParams,
}: {
    searchParams?: {
        [key: string]: string | string[] | undefined;
    };
}) {
    const userCode = cookies().get("btia_user_code")?.value;
    const queryUserCode = searchParams?.userCode;
    if (userCode) redirect(`/image-view`);
    if (queryUserCode) redirect(`/image-view?userCode=${queryUserCode}`);

    return (
        <div
            className="max-h-[calc(100vh-100px)] max-w-[1200px] m-auto relative flex justify-center md:py-[15vh] py-[10vh] 
            xl:px-[0px] px-[20px]"
        >
            <Landing />
        </div>
    );
}
