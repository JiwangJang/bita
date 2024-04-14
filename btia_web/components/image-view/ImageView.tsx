"use client";

import { useEffect, useState } from "react";

export default function ImageView() {
    const [userCode, setUserCode] = useState("");
    const [loading, setLoading] = useState(false);
    useEffect(() => {
        const saved = localStorage.getItem("btia_user_code");
        if (saved !== null) setUserCode(saved);
    }, []);

    return <div>{/* 스켈레톤 띄우는 방법 찾아보기 */}</div>;
}
