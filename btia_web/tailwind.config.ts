import type { Config } from "tailwindcss";

const config: Config = {
    content: [
        "./pages/**/*.{js,ts,jsx,tsx,mdx}",
        "./components/**/*.{js,ts,jsx,tsx,mdx}",
        "./app/**/*.{js,ts,jsx,tsx,mdx}",
    ],
    theme: {
        extend: {
            fontFamily: {
                sans: ["Pretendard"],
            },
            colors: {
                black: "#131313",
                white: "#F3F3F3",
                primary: "#FF6B00",
            },
        },
    },
    plugins: [],
};
export default config;
