import ImageView from "@/components/image-view/ImageView";
import { cookies } from "next/headers";

export default function Page() {
    const userCode: string = cookies().get("btia_user_code")?.value ?? "";
    return <ImageView cookieUserCode={userCode} />;
}
