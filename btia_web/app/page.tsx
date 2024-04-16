import Landing from "@/components/landing/Landing";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export default function Home() {
    const userCode = cookies().get("btia_user_code")?.value;
    if (userCode) redirect(`/image-view?userCode=${userCode}`);

    return (
        <div className="h-[calc(100vh-100px)] max-w-[1200px] m-auto relative flex justify-center pt-[15vh]">
            <Landing />
        </div>
    );
}
