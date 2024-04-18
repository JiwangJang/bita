function ImageSkeleton() {
    return (
        <div>
            <div className="h-[36px] w-[250px] bg-gray-300 mb-[12px] skeleton"></div>
            <div className="grid grid-cols-3 gap-[24px] max-h-[384px] h-[30vw] mb-[24px]">
                <div className="bg-gray-300 skeleton"></div>
                <div className="bg-gray-300 skeleton"></div>
                <div className="bg-gray-300 skeleton"></div>
            </div>
            <div className="h-[36px] w-[250px] bg-gray-300 mb-[12px] skeleton"></div>
            <div className="grid grid-cols-3 gap-[24px] max-h-[384px] h-[30vw]">
                <div className="bg-gray-300 skeleton"></div>
                <div className="bg-gray-300 skeleton"></div>
                <div className="bg-gray-300 skeleton"></div>
            </div>
        </div>
    );
}

export default ImageSkeleton;
