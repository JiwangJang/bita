"use client";

interface Props {
    content: string;
    isGhost: boolean;
    clickEvent: () => void;
}

const LandingButton = ({ content, isGhost, clickEvent }: Props) => {
    return (
        <div
            onClick={clickEvent}
            className={`xl:px-[44px] xl:py-[16px] xl:text-[32px] md:px-[3.3vw] md:py-[1.2vw] md:text-[2.4vw] rounded-full
            cursor-pointer transition-all p-[8px] text-[16px] w-full
            ${isGhost ? "ghost-btn hover:bg-primary hover:text-white" : "fill-btn"}`}
        >
            {content}
        </div>
    );
};

export default LandingButton;
