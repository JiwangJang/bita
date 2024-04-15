function ImageSkeleton() {
    return (
        <div>
            <div className="h-[36px] w-[250px] bg-gray-300 mb-[12px] skeleton"></div>
            <div className="flex gap-[24px] h-[384px]">
                <div className="flex-1 bg-gray-300 skeleton"></div>
                <div className="flex-1 bg-gray-300 skeleton"></div>
                <div className="flex-1 bg-gray-300 skeleton"></div>
            </div>
        </div>
    );
}

export default ImageSkeleton;
