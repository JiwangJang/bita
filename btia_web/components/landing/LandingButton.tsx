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
            className={`px-[44px] py-[16px] rounded-full text-[32px] cursor-pointer transition-all ${
                isGhost ? "ghost-btn hover:bg-primary hover:text-white" : "fill-btn"
            }`}
        >
            {content}
        </div>
    );
};

export default LandingButton;
